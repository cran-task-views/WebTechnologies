## CRAN Task View: Web Technologies and Services

|                 |                                                                                  |
| --------------- | -------------------------------------------------------------------------------- |
| **Maintainer:** | Scott Chamberlain, Thomas Leeper, Patrick Mair, Karthik Ram, Christopher Gandrud |
| **Contact:**    | scott at ropensci.org                                                            |
| **Version:**    | 2018-07-13                                                                       |
| **URL:**        | <https://CRAN.R-project.org/view=WebTechnologies>                                |

<div>

*Do not edit this README by hand. See [CONTRIBUTING.md](CONTRIBUTING.md).*

This Task View contains information about to use R and the world wide web together. The base version of R does not ship with many tools for interacting with the web. Thankfully, there are an increasingly large number of tools for interacting with the web. This task view focuses on packages for obtaining web-based data and information, frameworks for building web-based R applications, and online services that can be accessed from R. A list of available packages and functions is presented below, grouped by the type of activity. The [Open Data Task View](https://github.com/ropensci/opendata) provides further discussion of online data sources that can be accessed from R.

If you have any comments or suggestions for additions or improvements for this Task View, go to GitHub and [submit an issue](https://github.com/ropensci/webservices/issues), or make some changes and [submit a pull request](https://github.com/ropensci/webservices/pulls). If you can’t contribute on GitHub, [send Scott an email](mailto:scott@ropensci.org). If you have an issue with one of the packages discussed below, please contact the maintainer of that package. If you know of a web service, API, data source, or other online resource that is not yet supported by an R package, consider adding it to [the package development to do list on GitHub](https://github.com/ropensci/webservices/wiki/ToDo).

## Tools for Working with the Web from R

**Core Tools For HTTP Requests**

There are two packages that should cover most use cases of interacting with the web from R. [httr](http://cran.rstudio.com/web/packages/httr/index.html) provides a user-friendly interface for executing HTTP methods (GET, POST, PUT, HEAD, DELETE, etc.) and provides support for modern web authentication protocols (OAuth 1.0, OAuth 2.0). HTTP status codes are helpful for debugging HTTP calls. httr makes this easier using, for example, `stop_for_status()`, which gets the http status code from a response object, and stops the function if the call was not successful. (See also `warn_for_status()`.) Note that you can pass in additional libcurl options to the `config` parameter in http calls. [curl](http://cran.rstudio.com/web/packages/curl/index.html) is a lower-level package that provides a closer interface between R and the [libcurl C library](https://curl.haxx.se/libcurl/), but is less user-friendly. It may be useful for operations on web-based XML or to perform FTP operations. `curl::curl()` is an SSL-compatible replacement for base R’s `url()` and has support for http 2.0, SSL (https, ftps), gzip, deflate and more. For websites serving insecure HTTP (i.e. using the “http” not “https” prefix), most R functions can extract data directly, including `read.table` and `read.csv`; this also applies to functions in add-on packages such as `jsonlite::fromJSON()` and `XML::parseXML`. For more specific situations, the following resources may be useful:

  - [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html) is another low level client for libcurl. Of the two low-level curl clients, we recommend using [curl](http://cran.rstudio.com/web/packages/curl/index.html). [httpRequest](http://cran.rstudio.com/web/packages/httpRequest/index.html) is another low-level package for HTTP requests that implements the GET, POST and multipart POST verbs, but we do not recommend its use.
  - [crul](http://cran.rstudio.com/web/packages/crul/index.html) ([GitHub](https://github.com/ropensci/crul)) is an R6-based HTTP client that provides asynchronous HTTP requests, a pagination helper, HTTP mocking via [webmockr](http://cran.rstudio.com/web/packages/webmockr/index.html), and request caching via [vcr](http://cran.rstudio.com/web/packages/vcr/index.html). It targets developers of other R packages more so than end users.
  - [<span class="GitHub">curlconverter</span>](https://github.com/hrbrmstr/curlconverter/) (not on CRAN) is a useful package for converting curl command-line code, for example from a browser developer’s console, into R code.
  - [request](http://cran.rstudio.com/web/packages/request/index.html) provides a high-level package that is useful for developing other API client packages. [httping](http://cran.rstudio.com/web/packages/httping/index.html) provides simplified tools to ping and time HTTP requests, around [httr](http://cran.rstudio.com/web/packages/httr/index.html) calls. [httpcache](http://cran.rstudio.com/web/packages/httpcache/index.html) provides a mechanism for caching HTTP requests.
  - For dynamically generated webpages (i.e., those requiring user interaction to display results), [<span class="GitHub">RSelenium</span>](https://github.com/ropensci/RSelenium/) can be used to automate those interactions and extract page contents. It provides a set of bindings for the Selenium 2.0 webdriver using the [JsonWireProtocol](https://github.com/seleniumhq/selenium-google-code-issue-archive). It can also aid in automated application testing, load testing, and web scraping. [seleniumPipes](http://cran.rstudio.com/web/packages/seleniumPipes/index.html) ([GitHub](https://github.com/johndharrison/seleniumPipes)) provides a “pipe”-oriented interface to the same. [<span class="GitHub">rdom</span>](https://github.com/cpsievert/rdom/) (not on CRAN) uses [phantomjs](http://phantomjs.org/) to access a webpage’s Document Object Model (DOM). [<span class="GitHub">decapitated</span>](https://github.com/hrbrmstr/decapitated/) provides headless Chrome browser orchestration.
  - For capturing static content of web pages [postlightmercury](http://cran.rstudio.com/web/packages/postlightmercury/index.html) is a client for the web service [Mercury](https://mercury.postlight.com/) that turns web pages into structured and clean text.
  - Another, higher-level alternative package useful for webscraping is [rvest](http://cran.rstudio.com/web/packages/rvest/index.html), which is designed to work with [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html) to make it easy to express common web scraping tasks.
  - Many base R tools can be used to download web content, provided that the website does not use SSL (i.e., the URL does not have the “https” prefix). `download.file()` is a general purpose function that can be used to download a remote file. For SSL, the `download()` function in [downloader](http://cran.rstudio.com/web/packages/downloader/index.html) wraps `download.file()`, and takes all the same arguments.
  - Tabular data sets (e.g., txt, csv, etc.) can be input using `read.table()`, `read.csv()`, and friends, again assuming that the files are not hosted via SSL. An alternative is to use `httr::GET` (or `RCurl::getURL`) to first read the file into R as a character vector before parsing with `read.table(text=...)`, or you can download the file to a local directory. [rio](http://cran.rstudio.com/web/packages/rio/index.html) ([GitHub](https://github.com/leeper/rio)) provides an `import()` function that can read a number of common data formats directly from an https:// URL. The [repmis](http://cran.rstudio.com/web/packages/repmis/index.html) function `source_data()` can load and cache plain-text data from a URL (either http or https). That package also includes `source_Dropbox()` for downloading/caching plain-text data from non-public Dropbox folders and `source_XlsxData()` for downloading/caching Excel xlsx sheets.
  - *Authentication*: Using web resources can require authentication, either via API keys, OAuth, username:password combination, or via other means. Additionally, sometimes web resources that require authentication be in the header of an http call, which requires a little bit of extra work. API keys and username:password combos can be combined within a url for a call to a web resource (api key: http://api.foo.org/?key=yourkey; user/pass: http://username:password@api.foo.org), or can be specified via commands in [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html) or [httr](http://cran.rstudio.com/web/packages/httr/index.html). OAuth is the most complicated authentication process, and can be most easily done using [httr](http://cran.rstudio.com/web/packages/httr/index.html). See the 6 demos within [httr](http://cran.rstudio.com/web/packages/httr/index.html), three for OAuth 1.0 (linkedin, twitter, vimeo) and three for OAuth 2.0 (facebook, GitHub, google). [ROAuth](http://cran.rstudio.com/web/packages/ROAuth/index.html) is a package that provides a separate R interface to OAuth. OAuth is easier to to do in [httr](http://cran.rstudio.com/web/packages/httr/index.html), so start there. [<span class="GitHub">googleAuthR</span>](https://github.com/MarkEdmondson1234/googleAuthR/) provides an OAuth 2.0 setup specifically for Google web services.

**Handling HTTP Errors/Codes**

  - [fauxpas](http://cran.rstudio.com/web/packages/fauxpas/index.html) brings a set of Ruby or Python like R6 classes for each individual HTTP status code, allowing simple and verbose messages, with a choice of using messages, warnings, or stops.
  - [httpcode](http://cran.rstudio.com/web/packages/httpcode/index.html) is a simple package to help a user/package find HTTP status codes and associated messages by name or number.

**Parsing Structured Web Data**

The vast majority of web-based data is structured as plain text, HTML, XML, or JSON (javascript object notation). Web service APIs increasingly rely on JSON, but XML is still prevalent in many applications. There are several packages for specifically working with these format. These functions can be used to interact directly with insecure webpages or can be used to parse locally stored or in-memory web files.

  - *XML*: There are two packages for working with XML: [XML](http://cran.rstudio.com/web/packages/XML/index.html) and [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) ([GitHub](https://github.com/r-lib/xml2)). Both support general XML (and HTML) parsing, including XPath queries. The package [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) is less fully featured, but more user friendly with respect to memory management, classes (e.g., XML node vs. node set vs. document), and namespaces. Of the two, only the [XML](http://cran.rstudio.com/web/packages/XML/index.html) supports *de novo* creation of XML nodes and documents. The [XML2R](http://cran.rstudio.com/web/packages/XML2R/index.html) ([GitHub](https://github.com/cpsievert/XML2R)) package is a collection of convenient functions for coercing XML into data frames. An alternative to [XML](http://cran.rstudio.com/web/packages/XML/index.html) is [selectr](https://sjp.co.nz/projects/selectr/), which parses CSS3 Selectors and translates them to XPath 1.0 expressions. [XML](http://cran.rstudio.com/web/packages/XML/index.html) package is often used for parsing xml and html, but selectr translates CSS selectors to XPath, so can use the CSS selectors instead of XPath.
  - *HTML*: All of the tools that work with XML also work for HTML, though HTML is - in practice - more prone to be malformed. Some tools are designed specifically to work with HTML. `xml2::read_html()` is a good first function to use for importing HTML. [htmltools](http://cran.rstudio.com/web/packages/htmltools/index.html) provides functions to create HTML elements. [htmltab](http://cran.rstudio.com/web/packages/htmltab/index.html) ([GitHub](https://github.com/crubba/htmltab)) extracts structured information from HTML tables, similar to `XML::readHTMLTable` of the [XML](http://cran.rstudio.com/web/packages/XML/index.html) package, but automatically expands row and column spans in the header and body cells, and users are given more control over the identification of header and body rows which will end up in the R table. The [selectorgadget browser extension](https://selectorgadget.com/) can be used to identify page elements. [<span class="Ohat">RHTMLForms</span>](http://www.Omegahat.net/RHTMLForms/) reads HTML documents and obtains a description of each of the forms it contains, along with the different elements and hidden fields. [scrapeR](http://cran.rstudio.com/web/packages/scrapeR/index.html) provides additional tools for scraping data from HTML documents. [htmltidy](http://cran.rstudio.com/web/packages/htmltidy/index.html) ([GitHub](https://github.com/hrbrmstr/htmltidy)) provides tools to “tidy” messy HTML documents. [htm2txt](http://cran.rstudio.com/web/packages/htm2txt/index.html) uses regex to converts html documents to plain text by removing all html tags. [Rcrawler](http://cran.rstudio.com/web/packages/Rcrawler/index.html) does crawling and scraping of web pages.
  - *JSON*: There are several packages for reading and writing JSON: [rjson](http://cran.rstudio.com/web/packages/rjson/index.html), [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html), and [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html). [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html) includes a different parser from [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html) called [yajl](https://lloyd.github.io/yajl/). We recommend using [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html). Check out the paper describing jsonlite by Jeroen Ooms <https://arxiv.org/abs/1403.2805>. [jqr](http://cran.rstudio.com/web/packages/jqr/index.html) provides bindings for the fast JSON library, [jq](http://stedolan.github.io/jq/). [jsonvalidate](http://cran.rstudio.com/web/packages/jsonvalidate/index.html) ([GitHub](https://github.com/ropensci/jsonvalidate)) validates JSON against a schema using the “is-my-json-valid” Javascript library; [validatejsonr](http://cran.rstudio.com/web/packages/validatejsonr/index.html) does the same using the RapidJSON C++ library; [ajv](http://cran.rstudio.com/web/packages/ajv/index.html) does the same using the ajv Javascript library. [ndjson](http://cran.rstudio.com/web/packages/ndjson/index.html) ([GitHub](https://gitlab.com/hrbrmstr/ndjson)) supports the “ndjson” format.
  - *RSS/Atom*: [feedeR](http://cran.rstudio.com/web/packages/feedeR/index.html) can be used to parse RSS or Atom feeds. [tidyRSS](http://cran.rstudio.com/web/packages/tidyRSS/index.html) parses RSS, Atom XML/JSON and geoRSS into a tidy data.frame.
  - [swagger](http://cran.rstudio.com/web/packages/swagger/index.html) can be used to automatically generate functions for working with an web service API that provides documentation in [Swagger.io](https://swagger.io/) format.

**Tools for Working with URLs**

  - The `httr::parse_url()` function can be used to extract portions of a URL. The `RCurl::URLencode()` and `utils::URLencode()` functions can be used to encode character strings for use in URLs. `utils::URLdecode()` decodes back to the original strings. [urltools](http://cran.rstudio.com/web/packages/urltools/index.html) ([GitHub](https://github.com/Ironholds/urltools)) can also handle URL encoding, decoding, parsing, and parameter extraction.
  - The [<span class="GitHub">tldextract</span>](https://github.com/jayjacobs/tldextract/) package extracts top level domains and subdomains from a host name. It’s a port of [a Python library of the same name](https://github.com/john-kurkowski/tldextract).
  - [iptools](http://cran.rstudio.com/web/packages/iptools/index.html) can facilitate working with IPv4 addresses, including for use in geolocation.
  - [urlshorteneR](http://cran.rstudio.com/web/packages/urlshorteneR/index.html) offers URL expansion and analysis for Bit.ly, Goo.gl, and is.gd. [longurl](http://cran.rstudio.com/web/packages/longurl/index.html) uses the longurl.org API to provide similar functionality.
  - [gdns](http://cran.rstudio.com/web/packages/gdns/index.html) provides access to Google’s secure HTTP-based DNS resolution service.

**Tools for Working with Scraped Webpage Contents**

  - Several packages can be used for parsing HTML documents. [boilerpipeR](http://cran.rstudio.com/web/packages/boilerpipeR/index.html) provides generic extraction of main text content from HTML files; removal of ads, sidebars and headers using the boilerpipe Java library. [<span class="Ohat">RTidyHTML</span>](http://www.Omegahat.net/RTidyHTML/) interfaces to the libtidy library for correcting HTML documents that are not well-formed. This library corrects common errors in HTML documents. [W3CMarkupValidator](http://cran.rstudio.com/web/packages/W3CMarkupValidator/index.html) provides an R Interface to W3C Markup Validation Services for validating HTML documents.
  - For XML documents, the [<span class="Ohat">XMLSchema</span>](http://www.Omegahat.net/XMLSchema/) package provides facilities in R for reading XML schema documents and processing them to create definitions for R classes and functions for converting XML nodes to instances of those classes. It provides the framework for meta-computing with XML schema in R. [xslt](http://cran.rstudio.com/web/packages/xslt/index.html) is an extension for the [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) package to transform XML documents by applying an xslt style-sheet. (It can be seen as a modern replacement for [<span class="Ohat">Sxslt</span>](http://www.Omegahat.net/Sxslt/), which is an interface to Dan Veillard’s libxslt translator, and the [<span class="Ohat">SXalan</span>](http://www.Omegahat.net/SXalan/) package.) This may be useful for webscraping, as well as transforming XML markup into another human- or machine-readable format (e.g., HTML, JSON, plain text, etc.). [<span class="Ohat">SSOAP</span>](http://www.Omegahat.net/SSOAP/) provides a client-side SOAP (Simple Object Access Protocol) mechanism. It aims to provide a high-level interface to invoke SOAP methods provided by a SOAP server. [<span class="Ohat">XMLRPC</span>](http://www.Omegahat.net/XMLRPC/) provides an implementation of XML-RPC, a relatively simple remote procedure call mechanism that uses HTTP and XML. This can be used for communicating between processes on a single machine or for accessing Web services from within R.
  - [<span class="Ohat">Rcompression</span>](http://www.Omegahat.net/Rcompression/) (not on CRAN): Interface to zlib and bzip2 libraries for performing in-memory compression and decompression in R. This is useful when receiving or sending contents to remote servers, e.g. Web services, HTTP requests via RCurl.
  - [tm.plugin.webmining](http://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html): Extensible text retrieval framework for news feeds in XML (RSS, ATOM) and JSON formats. Currently, the following feeds are implemented: Google Blog Search, Google Finance, Google News, NYTimes Article Search, Reuters News Feed, Yahoo Finance and Yahoo Inplay.
  - [webshot](http://cran.rstudio.com/web/packages/webshot/index.html) uses [PhantomJS](http://phantomjs.org/) to provide screenshots of web pages without a browser. It can be useful for testing websites (such as Shiny applications).

**Security**

  - [securitytxt](http://cran.rstudio.com/web/packages/securitytxt/index.html) identifies and parses web Ssecurity policy files.

**Other Useful Packages and Functions**

  - *Javascript*: [V8](http://cran.rstudio.com/web/packages/V8/index.html) ([GitHub](https://github.com/jeroen/V8)) is an R interface to Google’s open source, high performance JavaScript engine. It can wrap Javascript libraries as well as NPM packages. The [<span class="Ohat">SpiderMonkey</span>](http://www.Omegahat.net/SpiderMonkey/) package provides another means of evaluating JavaScript code, creating JavaScript objects and calling JavaScript functions and methods from within R. This can work by embedding the JavaScript engine within an R session or by embedding R in an browser such as Firefox and being able to call R from JavaScript and call back to JavaScript from R. The [js](http://cran.rstudio.com/web/packages/js/index.html) package wraps [V8](http://cran.rstudio.com/web/packages/V8/index.html) and validates, reformats, optimizes and analyzes JavaScript code.
  - *Email:*: [mailR](http://cran.rstudio.com/web/packages/mailR/index.html) is an interface to Apache Commons Email to send emails from within R. [sendmailR](http://cran.rstudio.com/web/packages/sendmailR/index.html) provides a simple SMTP client. [gmailr](http://cran.rstudio.com/web/packages/gmailr/index.html) provides access the Google’s gmail.com RESTful API.
  - *Mocking:*: [webmockr](http://cran.rstudio.com/web/packages/webmockr/index.html) is a library for stubbing and setting expectations on HTTP requests. It is inspired from Rubys `webmock`. This package only helps mock HTTP requests, and returns nothing when requests match expectations. See *Testing* for mocking with returned responses.
  - *Testing:*: [vcr](http://cran.rstudio.com/web/packages/vcr/index.html) provides an interface to easily cache HTTP requests in R package test suites (but can be used outside of testing use cases as well). vcr relies on [webmockr](http://cran.rstudio.com/web/packages/webmockr/index.html) to do the HTTP request mocking. [httptest](http://cran.rstudio.com/web/packages/httptest/index.html) provides a framework for testing packages that communicate with HTTP APIs, offering tools for mocking APIs, for recording real API responses for use as mocks, and for making assertions about HTTP requests, all without requiring a live connection to the API server at runtime.
  - *Miscellaneous*: [webutils](http://cran.rstudio.com/web/packages/webutils/index.html) contains various functions for developing web applications, including parsers for `application/x-www-form-urlencoded` as well as `multipart/form-data`. [mime](http://cran.rstudio.com/web/packages/mime/index.html) ([GitHub](https://github.com/yihui/mime)) guesses the MIME type for a file from its extension. [rsdmx](http://cran.rstudio.com/web/packages/rsdmx/index.html) provides tools to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML). [robotstxt](http://cran.rstudio.com/web/packages/robotstxt/index.html) provides functions and classes for parsing robots.txt files and checking access permissions; [spiderbar](http://cran.rstudio.com/web/packages/spiderbar/index.html) does the same. [uaparserjs](http://cran.rstudio.com/web/packages/uaparserjs/index.html) ([GitHub](https://github.com/hrbrmstr/uaparserjs)) uses the javascript [“ua-parser” library](https://github.com/ua-parser) to parse User-Agent HTTP headers. [rjsonapi](http://cran.rstudio.com/web/packages/rjsonapi/index.html) consumes APIs that Follow the [JSON API Specification](http://jsonapi.org/). [rapiclient](http://cran.rstudio.com/web/packages/rapiclient/index.html) is a client for consuming APIs that follow the [Open API format](https://www.openapis.org/). [restfulr](http://cran.rstudio.com/web/packages/restfulr/index.html) models a RESTful service as if it were a nested R list.

## Web and Server Frameworks

  - [DeployR](https://docs.microsoft.com/en-us/machine-learning-server/deployr/deployr-welcome) is part of Microsoft R Server that provides support for integrating R as an application and website backend.
  - The [shiny](http://cran.rstudio.com/web/packages/shiny/index.html) package makes it easy to build interactive web applications with R.
  - Other web frameworks include: [fiery](http://cran.rstudio.com/web/packages/fiery/index.html) that is meant to be more flexible but less easy to use than shiny ([reqres](http://cran.rstudio.com/web/packages/reqres/index.html) and [routr](http://cran.rstudio.com/web/packages/routr/index.html) are utilities used by fiery that provide HTTP request and response classes, and HTTP routing, respectively); [<span class="GitHub">prairie</span>](https://github.com/nteetor/prairie/) (not on CRAN) which is a lightweight web framework that uses magrittr-style syntax and is modeled after [expressjs](http://expressjs.com/); [<span class="GitHub">rcloud</span>](https://github.com/att/rcloud/) provides an iPython notebook-style web-based R interface; and [Rook](http://cran.rstudio.com/web/packages/Rook/index.html), which contains the specification and convenience software for building and running Rook applications.
  - The [opencpu](http://cran.rstudio.com/web/packages/opencpu/index.html) framework for embedded statistical computation and reproducible research exposes a web API interfacing R, LaTeX and Pandoc. This API is used for example to integrate statistical functionality into systems, share and execute scripts or reports on centralized servers, and build R based apps.
  - Several general purpose server/client frameworks for R exist. [Rserve](http://cran.rstudio.com/web/packages/Rserve/index.html) and [RSclient](http://cran.rstudio.com/web/packages/RSclient/index.html) provide server and client functionality for TCP/IP or local socket interfaces. [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html) provides a low-level socket and protocol support for handling HTTP and WebSocket requests directly within R. Another related package, perhaps which [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html) replaces, is [websockets](https://cran.rstudio.com/src/contrib/Archive/websockets/). [servr](http://cran.rstudio.com/web/packages/servr/index.html) provides a simple HTTP server to serve files under a given directory based on httpuv.
  - Several packages offer functionality for turning R code into a web API. [jug](http://cran.rstudio.com/web/packages/jug/index.html) is a simple API-builder web framework, built around [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html). [FastRWeb](http://cran.rstudio.com/web/packages/FastRWeb/index.html) provides some basic infrastructure for this. [plumber](http://cran.rstudio.com/web/packages/plumber/index.html) allows you to create a REST API by decorating existing R source code.
  - The [<span class="Ohat">WADL</span>](http://www.Omegahat.net/WADL/) package provides tools to process Web Application Description Language (WADL) documents and to programmatically generate R functions to interface to the REST methods described in those WADL documents. (not on CRAN)
  - The [<span class="Ohat">RDCOMServer</span>](http://www.Omegahat.net/RDCOMServer/) provides a mechanism to export R objects as (D)COM objects in Windows. It can be used along with the [<span class="Ohat">RDCOMClient</span>](http://www.Omegahat.net/RDCOMClient/) package which provides user-level access from R to other COM servers. (not on CRAN)
  - [rapporter.net](http://rapporter.net/welcome/en) provides an online environment (SaaS) to host and run [rapport](http://cran.rstudio.com/web/packages/rapport/index.html) statistical report templates in the cloud.
  - [radiant](http://cran.rstudio.com/web/packages/radiant/index.html) ([GitHub](https://github.com/radiant-rstats/radiant)) is Shiny-based GUI for R that runs in a browser from a server or local machine.
  - [<span class="GitHub">neocities</span>](https://github.com/seankross/neocities/) wraps the API for the [Neocities](https://neocities.org/) web hosting service. (not on CRAN)
  - The [Tiki](https://tiki.org/tiki-index.php) Wiki CMS/Groupware framework has an R plugin ([PluginR](https://doc.tiki.org/PluginR)) to run R code from wiki pages, and use data from their own collected web databases (trackers). A demo: <https://r.tiki.org/tiki-index.php>.
  - The [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) has an extension ([Extension:R](https://www.mediawiki.org/wiki/Extension:R)) to run R code from wiki pages, and use uploaded data. A mailing list used to be available: R-sig-mediawiki.
  - [whisker](http://cran.rstudio.com/web/packages/whisker/index.html): Implementation of logicless templating based on [Mustache](http://mustache.github.io/) in R. Mustache syntax is described in <http://mustache.github.io/mustache.5.html>
  - [<span class="Ohat">CGIwithR</span>](http://www.Omegahat.net/CGIwithR/) (not on CRAN) allows one to use R scripts as CGI programs for generating dynamic Web content. HTML forms and other mechanisms to submit dynamic requests can be used to provide input to R scripts via the Web to create content that is determined within that R script.

## Web Services

**Cloud Computing and Storage**

  - Amazon Web Services is a popular, proprietary cloud service offering a suite of computing, storage, and infrastructure tools. [aws.signature](http://cran.rstudio.com/web/packages/aws.signature/index.html) provides functionality for generating AWS API request signatures.
      - *Simple Storage Service (S3)* is a commercial server that allows one to store content and retrieve it from any machine connected to the Internet. [aws.s3](http://cran.rstudio.com/web/packages/aws.s3/index.html) is probably the best R client for S3. [<span class="Ohat">RAmazonS3</span>](http://www.Omegahat.net/RAmazonS3/) and [<span class="GitHub">s3mpi</span>](https://github.com/robertzk/s3mpi/) (not on CRAN) provides basic infrastructure for communicating with S3. [<span class="GitHub">awsConnect</span>](https://github.com/lalas/awsConnect/) (not on CRAN) is another package using the AWS Command Line Interface to control EC2 and S3, which is only available for Linux and Mac OS.
      - *Elastic Cloud Compute (EC2)* is a cloud computing service. AWS.tools and [<span class="GitHub">awsConnect</span>](https://github.com/lalas/awsConnect/) (not on CRAN) both use the AWS command line interface to control EC2. [<span class="Gcode">segue</span>](https://code.google.com/p/segue/) (not on CRAN) is another package for managing EC2 instances and S3 storage, which includes a parallel version of `lapply()` for the Elastic Map Reduce (EMR) engine called `emrlapply()`. It uses Hadoop Streaming on Amazon’s EMR in order to get simple parallel computation.
      - *Simple Notification Service (SNS)* is a service for Pub/Sub messaging and mobile notifications for microservices, distributed systems, and serverless applications. [aws.sns](http://cran.rstudio.com/web/packages/aws.sns/index.html)
      - *AWS Polly* is a Text-to-Speech (TTS) cloud service that converts text into lifelike speech. [aws.polly](http://cran.rstudio.com/web/packages/aws.polly/index.html)
      - *DBREST*: [<span class="Ohat">RAmazonDBREST</span>](http://www.Omegahat.net/RAmazonDBREST/) provides an interface to Amazon’s Simple DB API.
      - [The cloudyr project](https://cloudyr.github.io/), which is currently under active development on GitHub, aims to provide a unified interface to the full Amazon Web Services suite without the need for external system dependencies.
  - [googleComputeEngineR](http://cran.rstudio.com/web/packages/googleComputeEngineR/index.html) interacts with the Google Compute Engine API, and lets you create, start and stop instances in the Google Cloud.
  - *Cloud Storage*: [googleCloudStorageR](http://cran.rstudio.com/web/packages/googleCloudStorageR/index.html) interfaces with Google Cloud Storage. [boxr](http://cran.rstudio.com/web/packages/boxr/index.html) ([GitHub](https://github.com/brendan-R/boxr)) is a lightweight, high-level interface for the [box.com API](https://developer.box.com/docs/). [rdrop2](http://cran.rstudio.com/web/packages/rdrop2/index.html) is a Dropbox interface that provides access to a full suite of file operations, including dir/copy/move/delete operations, account information (including quotas) and the ability to upload and download files from any Dropbox account. [backblazer](http://cran.rstudio.com/web/packages/backblazer/index.html) ([GitHub](https://github.com/phillc73/backblazer)) provides access to the Backblaze B2 storage API.
  - *Docker*: [analogsea](http://cran.rstudio.com/web/packages/analogsea/index.html) is a general purpose client for the Digital Ocean v2 API. In addition, the package includes functions to install various R tools including base R, RStudio server, and more. There’s an improving interface to interact with docker on your remote droplets via this package.
  - [crunch](http://cran.rstudio.com/web/packages/crunch/index.html) [GitHub](https://github.com/Crunch-io/rcrunch) provides an interface to the [crunch.io](https://crunch.io/) storage and analytics platform. [crplyr](http://cran.rstudio.com/web/packages/crplyr/index.html) [GitHub](https://github.com/Crunch-io/crplyr) implements `dplyr` methods on top of Crunch, and [crunchy](http://cran.rstudio.com/web/packages/crunchy/index.html) [GitHub](https://github.com/Crunch-io/crunchy) facilitates making Shiny apps on Crunch.
  - [rrefine](http://cran.rstudio.com/web/packages/rrefine/index.html) provides a client for the [OpenRefine](http://openrefine.org/) (formerly Google Refine) data cleaning service.

**Document and Code Sharing**

  - *Code Sharing*: [gistr](http://cran.rstudio.com/web/packages/gistr/index.html) ([GitHub](https://github.com/ropensci/gistr)) works with GitHub gists ([gist.github.com](https://gist.github.com/)) from R, allowing you to create new gists, update gists with new files, rename files, delete files, get and delete gists, star and un-star gists, fork gists, open a gist in your default browser, get embed code for a gist, list gist commits, and get rate limit information when authenticated. [git2r](http://cran.rstudio.com/web/packages/git2r/index.html) provides bindings to the git version control system and two packages provide access to the GitHub API: [gh](http://cran.rstudio.com/web/packages/gh/index.html) and [<span class="GitHub">rgithub</span>](https://github.com/cscheid/rgithub/) (not on CRAN), all of which can facilitate code or data sharing via GitHub. [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html) is a [GitLab](https://about.gitlab.com/) -specific client. [<span class="GitHub">pastebin</span>](https://github.com/hrbrmstr/pastebin/) is a client for <https://pastebin.com/> a code sharing site.
  - *Data archiving*: [dataverse](http://cran.rstudio.com/web/packages/dataverse/index.html) ([GitHub](https://github.com/iqss/dataverse-client-r)) provides access to Dataverse 4 APIs. [rfigshare](http://cran.rstudio.com/web/packages/rfigshare/index.html) ([GitHub](https://github.com/ropensci/rfigshare)) connects with [Figshare.com](https://figshare.com/). [dataone](https://cran.rstudio.com/src/contrib/Archive/dataone/) provides read/write access to data and metadata from the [DataONE network](https://www.dataone.org/) of Member Node data repositories. [dataone](http://cran.rstudio.com/web/packages/dataone/index.html) ([GitHub](https://github.com/DataONEorg/rdataone)) provides a client for [DataONE](https://www.dataone.org/) repositories.
  - *Google Drive/Google Documents*: [<span class="GitHub">driver</span>](https://github.com/noamross/driver/) (not on CRAN) is a thin client for the Google Drive API. The [<span class="Ohat">RGoogleDocs</span>](http://www.Omegahat.net/RGoogleDocs/) package is an example of using the RCurl and XML packages to quickly develop an interface to the Google Documents API. [<span class="Ohat">RGoogleStorage</span>](http://www.Omegahat.net/RGoogleStorage/) provides programmatic access to the Google Storage API. This allows R users to access and store data on Google’s storage. We can upload and download content, create, list and delete folders/buckets, and set access control permissions on objects and buckets.
  - *Google Sheets*: [googlesheets](http://cran.rstudio.com/web/packages/googlesheets/index.html) ([GitHub](https://github.com/jennybc/googlesheets)) can access private or public Google Sheets by title, key, or URL. Extract data or edit data. Create, delete, rename, copy, upload, or download spreadsheets and worksheets. [gsheet](http://cran.rstudio.com/web/packages/gsheet/index.html) ([GitHub](https://github.com/maxconway/gsheet)) can download Google Sheets using just the sharing link. Spreadsheets can be downloaded as a data frame, or as plain text to parse manually.
  - [imguR](http://cran.rstudio.com/web/packages/imguR/index.html) ([GitHub](https://github.com/cloudyr/imguR)) is a package to share plots using the image hosting service [Imgur.com](https://imgur.com/). knitr also has a function `imgur_upload()` to load images from literate programming documents.
  - [<span class="GitHub">rscribd</span>](https://github.com/cloudyr/rscribd/) (not on CRAN): API client for publishing documents to [Scribd](https://www.scribd.com/).

**Data Analysis and Processing Services**

  - *Crowdsourcing*: Amazon Mechanical Turk is a paid crowdsourcing platform that can be used to semi-automate tasks that are not easily automated. [MTurkR](http://cran.rstudio.com/web/packages/MTurkR/index.html) ([GitHub](https://github.com/cloudyr/MTurkR))) provides access to the Amazon Mechanical Turk Requester API. [<span class="GitHub">microworkers</span>](https://github.com/cloudyr/microworkers/) (not on CRAN) can distribute tasks and retrieve results for the Microworkers.com platform.
  - *Geospatial/Geolocation/Geocoding*: Several packages connect to geolocation/geocoding services. [rgeolocate](http://cran.rstudio.com/web/packages/rgeolocate/index.html) ([GitHub](https://github.com/ironholds/rgeolocate)) offers several online and offline tools. [<span class="GitHub">rydn</span>](https://github.com/trestletech/rydn/) (not on CRAN) is an interface to the Yahoo Developers network geolocation APIs, and [<span class="GitHub">ipapi</span>](https://github.com/hrbrmstr/ipapi/) can be used to geolocate IPv4/6 addresses and/or domain names using the <http://ip-api.com/> API. [threewords](http://cran.rstudio.com/web/packages/threewords/index.html) connects to the [What3Words API](http://what3words.com/), which represents every 3-meter by 3-meter square on earth as a three-word phrase. [opencage](http://cran.rstudio.com/web/packages/opencage/index.html) ([GitHub](https://github.com/ropensci/opencage)) provides access to to the [OpenCage](https://opencagedata.com/) geocoding service. [geoparser](http://cran.rstudio.com/web/packages/geoparser/index.html) ([GitHub](https://github.com/ropensci/geoparser)) interfaces with the [Geoparser.io](https://geoparser.io/) web service to identify place names from plain text. [<span class="GitHub">nominatim</span>](https://github.com/hrbrmstr/nominatim/) (not on CRAN) connects to the [OpenStreetMap Nominatim API](https://github.com/hrbrmstr/nominatim) for reverse geocoding. [<span class="GitHub">PostcodesioR</span>](https://github.com/ropensci/PostcodesioR/) (not on CRAN) provides post code lookup and geocoding for the United Kingdom. [geosapi](http://cran.rstudio.com/web/packages/geosapi/index.html) is an R client for the GeoSererver REST API, an open source implementation used widely for serving spatial data.
  - *Image Processing*: [<span class="GitHub">RoogleVision</span>](https://github.com/cloudyr/RoogleVision/) (not on CRAN) links to the Google Cloud Vision image recognition service.
  - *Machine Learning as a Service*: Several packages provide access to cloud-based machine learning services. [AzureML](http://cran.rstudio.com/web/packages/AzureML/index.html) links with the Microsoft Azure machine learning service. [bigml](http://cran.rstudio.com/web/packages/bigml/index.html) ([GitHub](https://github.com/bigmlcom/bigml-r)) connects to BigML. [OpenML](http://cran.rstudio.com/web/packages/OpenML/index.html) ([GitHub](https://github.com/openml/openml-r)) is the official client for [the OpenML API](https://www.openml.org/frontend/page/home). [ddeploy](http://cran.rstudio.com/web/packages/ddeploy/index.html) wraps the [Duke Analytics model deployment API](http://www.dukeanalytics.com/products/dukedeployR.php). [clarifai](http://cran.rstudio.com/web/packages/clarifai/index.html) ([GitHub](https://github.com/soodoku/clarifai)) is a [Clarifai.com](https://clarifai.com/) client that enables automated image description. [rLTP](http://cran.rstudio.com/web/packages/rLTP/index.html) ([GitHub](https://github.com/hetong007/rLTP)) accesses the [ltp-cloud service](https://www.ltp-cloud.com/). [languagelayeR](http://cran.rstudio.com/web/packages/languagelayeR/index.html) is a client for Languagelayer, a language detection API. [googlepredictionapi](https://code.google.com/archive/p/google-prediction-api-r-client/) (not on CRAN): is an R client for the [Google Prediction API](https://cloud.google.com/prediction/), a suite of cloud machine learning tools. [yhatr](http://cran.rstudio.com/web/packages/yhatr/index.html) lets you deploy, maintain, and invoke models via the [Yhat](https://www.yhat.com/) REST API. [datarobot](http://cran.rstudio.com/web/packages/datarobot/index.html) works with Data Robot’s predictive modeling platform. [mscsweblm4r](http://cran.rstudio.com/web/packages/mscsweblm4r/index.html) ([GitHub](https://github.com/philferriere/mscsweblm4r)) interfaces with the Microsoft Cognitive Services Web Language Model API and [mscstexta4r](http://cran.rstudio.com/web/packages/mscstexta4r/index.html) ([GitHub](https://github.com/philferriere/mscstexta4r)) uses the Microsoft Cognitive Services Text Analytics REST API. [rosetteApi](http://cran.rstudio.com/web/packages/rosetteApi/index.html) links to the [Rosette](https://developer.rosette.com/) text analysis API. [birdnik](http://cran.rstudio.com/web/packages/birdnik/index.html) ([GitHub](https://github.com/Ironholds/birdnik)) provides an interface to [Wordnik](https://www.wordnik.com/), an online dictionary. [googleLanguageR](http://cran.rstudio.com/web/packages/googleLanguageR/index.html) provides interfaces to Google’s Cloud Translation API, Natural Language API, Cloud Speech API, and the Cloud Text-to-Speech API.
  - *Machine Translation*: [translate](http://cran.rstudio.com/web/packages/translate/index.html) provides bindings for the Google Translate API v2 and [translateR](http://cran.rstudio.com/web/packages/translateR/index.html) provides bindings for both Google and Microsoft translation APIs. [<span class="GitHub">mstranslator</span>](https://github.com/chainsawriot/mstranslator/) \] provides an R wrapper for the Microsoft Translator API. [RYandexTranslate](http://cran.rstudio.com/web/packages/RYandexTranslate/index.html) ([GitHub](https://github.com/mukul13/RYandexTranslate)) connects to [Yandex Translate](https://translate.yandex.com/). [transcribeR](http://cran.rstudio.com/web/packages/transcribeR/index.html) provides automated audio transcription via the HP IDOL service.
  - *Document Processing*: [abbyyR](http://cran.rstudio.com/web/packages/abbyyR/index.html) [GitHub](https://github.com/soodoku/abbyyR) and [captr](http://cran.rstudio.com/web/packages/captr/index.html) ([GitHub](https://github.com/soodoku/captr)) connect to optical character recognition (OCR) APIs. [pdftables](http://cran.rstudio.com/web/packages/pdftables/index.html) ([GitHub](https://github.com/expersso/pdftables)) uses [the PDFTables.com webservice](https://pdftables.com/) to extract tables from PDFs.
  - *Mapping*: [osmar](http://cran.rstudio.com/web/packages/osmar/index.html) provides infrastructure to access OpenStreetMap data from different sources to work with the data in common R manner and to convert data into available infrastructure provided by existing R packages (e.g., into sp and igraph objects). [osrm](http://cran.rstudio.com/web/packages/osrm/index.html) ([GitHub](https://github.com/rCarto/osrm)) provides shortest paths and travel times from OpenStreetMap. [osmplotr](http://cran.rstudio.com/web/packages/osmplotr/index.html) ([GitHub](https://github.com/ropensci/osmplotr)) extracts customizable map images from OpenStreetMap. [RgoogleMaps](http://cran.rstudio.com/web/packages/RgoogleMaps/index.html) serves two purposes: it provides a comfortable R interface to query the Google server for static maps, and use the map as a background image to overlay plots within R. [<span class="Ohat">R2GoogleMaps</span>](http://www.Omegahat.net/R2GoogleMaps/) provides a mechanism to generate JavaScript code from R that displays data using Google Maps. [placement](http://cran.rstudio.com/web/packages/placement/index.html) ([GitHub](https://github.com/derekyves/placement)) provides drive time and geolocation services from Google Maps. [<span class="Ohat">RKMLDevice</span>](http://www.Omegahat.net/RKMLDevice/) allows to create R graphics in Keyhole Markup Language (KML) format in a manner that allows them to be displayed on Google Earth (or Google Maps), and [<span class="Ohat">RKML</span>](http://www.Omegahat.net/RKML/) provides users with high-level facilities to generate KML. [plotKML](http://cran.rstudio.com/web/packages/plotKML/index.html) can visualization spatial and spatio-temporal objects in Google Earth. [plotGoogleMaps](http://cran.rstudio.com/web/packages/plotGoogleMaps/index.html) pls SP or SPT (STDIF,STFDF) data as an HTML map mashup over Google Maps. [ggmap](http://cran.rstudio.com/web/packages/ggmap/index.html) allows for the easy visualization of spatial data and models on top of Google Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2. [mapsapi](http://cran.rstudio.com/web/packages/mapsapi/index.html) is an sf-compatible interface to Google Maps API. [leafletR](http://cran.rstudio.com/web/packages/leafletR/index.html): Allows you to display your spatial data on interactive web-maps using the open-source JavaScript library Leaflet. [<span class="GitHub">cartodb-r</span>](https://github.com/becarioprecario/cartodb-r/) (not on CRAN) provides an API interface to [Cartodb.com](https://carto.com/). [openadds](http://cran.rstudio.com/web/packages/openadds/index.html) ([GitHub](https://github.com/sckott/openadds)) is an [Openaddresses](https://openaddresses.io/) client, and [banR](http://cran.rstudio.com/web/packages/banR/index.html) provides access to the “Base Adresses Nationale” (BAN) API for French addresses.
  - *Online Surveys*: [qualtRics](http://cran.rstudio.com/web/packages/qualtRics/index.html) and [<span class="GitHub">qualtrics</span>](https://github.com/jbryer/qualtrics/) (not on CRAN) provide functions to interact with [Qualtrics](https://www.qualtrics.com/). [WufooR](http://cran.rstudio.com/web/packages/WufooR/index.html) ([GitHub](https://github.com/dmpe/wufoor)) can retrieve data from [Wufoo.com](https://www.wufoo.com/) forms. [redcapAPI](http://cran.rstudio.com/web/packages/redcapAPI/index.html) ([GitHub](https://github.com/nutterb/redcapAPI)) can provide access to data stored in a REDCap (Research Electronic Data CAPture) database, which is a web application for building and managing online surveys and databases developed at Vanderbilt University. [<span class="GitHub">formr</span>](https://github.com/rubenarslan/formr/) facilitates use of the [formr](https://formr.org/) survey framework, which is built on openCPU. [Rexperigen](http://cran.rstudio.com/web/packages/Rexperigen/index.html) is a client for the [Experigen experimental platform](http://becker.phonologist.org/experigen/).
  - *Visualization*: Plot.ly is a company that allows you to create visualizations in the web using R (and Python), which is accessible via [plotly](http://cran.rstudio.com/web/packages/plotly/index.html). [googleVis](http://cran.rstudio.com/web/packages/googleVis/index.html) provides an interface between R and the Google chart tools. The [<span class="Ohat">RUbigraph</span>](http://www.Omegahat.net/RUbigraph/) package provides an R interface to a Ubigraph server for drawing interactive, dynamic graphs. You can add and remove vertices/nodes and edges in a graph and change their attributes/characteristics such as shape, color, size. Interactive, Javascript-enabled graphics are an increasingly useful output format for data analysis. [ggvis](http://cran.rstudio.com/web/packages/ggvis/index.html) makes it easy to describe interactive web graphics in R. It fuses the ideas of ggplot2 and [shiny](http://cran.rstudio.com/web/packages/shiny/index.html), rendering graphics on the web with Vega. [d3Network](http://cran.rstudio.com/web/packages/d3Network/index.html) provides tools for creating D3 JavaScript network, tree, dendrogram, and Sankey graphs from R. [<span class="GitHub">clickme</span>](https://github.com/nachocab/clickme/) (not on CRAN) allows for interactive Javascript charts from R. [<span class="GitHub">animint</span>](https://github.com/tdhock/animint/) (not on CRAN) allows an interactive animation to be defined using a list of ggplots with clickSelects and showSelected aesthetics, then exported to CSV/JSON/D3/JavaScript for viewing in a web browser. [<span class="GitHub">rVega</span>](https://github.com/metagraf/rVega/) (not on CRAN) is an R wrapper for Vega.
  - *Other* :
      - [genderizeR](http://cran.rstudio.com/web/packages/genderizeR/index.html) ([GitHub](https://github.com/kalimu/genderizeR)) uses the [genderize.io](https://genderize.io/) API to predict gender from first names extracted from a text vector.
      - [rrefine](http://cran.rstudio.com/web/packages/rrefine/index.html) can import to and export from the [OpenRefine](http://openrefine.org/) data cleaning service.

**Social Media Clients**

  - [plusser](http://cran.rstudio.com/web/packages/plusser/index.html) has been designed to to facilitate the retrieval of Google+ profiles, pages and posts. It also provides search facilities. Currently a Google+ API key is required for accessing Google+ data.
  - [Rfacebook](http://cran.rstudio.com/web/packages/Rfacebook/index.html) and [facebook.S4](http://cran.rstudio.com/web/packages/facebook.S4/index.html) provide interfaces to the Facebook API.
  - The [<span class="Ohat">Rflickr</span>](http://www.Omegahat.net/Rflickr/) package provides an interface to the Flickr photo management and sharing application Web service. (not on CRAN)
  - [instaR](http://cran.rstudio.com/web/packages/instaR/index.html) ([GitHub](https://github.com/pablobarbera/instaR)) is a client for the [Instagram API](https://www.instagram.com/developer/).
  - [<span class="GitHub">Rlinkedin</span>](https://github.com/mpiccirilli/Rlinkedin/) (not on CRAN) is a client for the LinkedIn API. Auth is via OAuth.
  - [rpinterest](http://cran.rstudio.com/web/packages/rpinterest/index.html) connects to the [Pintrest](https://www.pinterest.com/) API.
  - [SocialMediaMineR](http://cran.rstudio.com/web/packages/SocialMediaMineR/index.html) is an analytic tool that returns information about the popularity of a URL on social media sites.
  - [tumblR](http://cran.rstudio.com/web/packages/tumblR/index.html) ([GitHub](https://github.com/klapaukh/tumblR)) is a client for the Tumblr API ( <https://www.tumblr.com/docs/en/api/v2>). Tumblr is a microblogging platform and social networking website <https://www.tumblr.com/>.
  - [vkR](http://cran.rstudio.com/web/packages/vkR/index.html) is a client for VK, a social networking site based in Russia.
  - [<span class="GitHub">meetupr</span>](https://github.com/rladies/meetupr/) is a client for the Meetup.com API.
  - *Twitter*: [twitteR](http://cran.rstudio.com/web/packages/twitteR/index.html) ([GitHub](https://github.com/geoffjentry/twitteR)) provides an interface to the Twitter web API. It claims to be deprecated in favor of [rtweet](http://cran.rstudio.com/web/packages/rtweet/index.html) ([GitHub](https://github.com/mkearney/rtweet)). [<span class="GitHub">RTwitterAPI</span>](https://github.com/joyofdata/RTwitterAPI/) (not on CRAN) is another Twitter client. [<span class="GitHub">twitterreport</span>](https://github.com/gvegayon/twitterreport/) (not on CRAN) focuses on report generation based on Twitter data. [streamR](http://cran.rstudio.com/web/packages/streamR/index.html) provides a series of functions that allow users to access Twitter’s filter, sample, and user streams, and to parse the output into data frames. OAuth authentication is supported. [tweet2r](http://cran.rstudio.com/web/packages/tweet2r/index.html) is an alternative implementation geared toward SQLite and postGIS databases. [graphTweets](http://cran.rstudio.com/web/packages/graphTweets/index.html) produces a network graph from a data.frame of tweets. [tweetscores](https://github.com/pablobarbera/twitter_ideology/tree/master/pkg/tweetscores) (not on CRAN) implements a political ideology scaling measure for specified Twitter users.

**Web Analytics Services**

  - *Google Trends*: [gtrendsR](http://cran.rstudio.com/web/packages/gtrendsR/index.html) offers functions to perform and display Google Trends queries. [<span class="Ohat">RGoogleTrends</span>](http://www.Omegahat.net/RGoogleTrends/) provides an alternative.
  - *Google Analytics*: [googleAnalyticsR](http://cran.rstudio.com/web/packages/googleAnalyticsR/index.html), [ganalytics](http://cran.rstudio.com/web/packages/ganalytics/index.html); [GAR](http://cran.rstudio.com/web/packages/GAR/index.html), and [RGA](http://cran.rstudio.com/web/packages/RGA/index.html) provide functions for accessing and retrieving data from the [Google Analytics APIs](https://developers.google.com/analytics/). The latter supports OAuth 2.0 authorization. [RGA](http://cran.rstudio.com/web/packages/RGA/index.html) provides a shiny app to explore data. [searchConsoleR](http://cran.rstudio.com/web/packages/searchConsoleR/index.html) links to the [Google Search Console](https://developers.google.com/webmaster-tools/) (formerly Webmaster Tools).
  - *Online Advertising*: [fbRads](http://cran.rstudio.com/web/packages/fbRads/index.html) can manage Facebook ads via the Facebook Marketing API. [<span class="GitHub">RDoubleClick</span>](https://github.com/WillemPaling/RDoubleClick/) (not on CRAN) can retrieve data from Google’s DoubleClick Campaign Manager Reporting API. [RSmartlyIO](http://cran.rstudio.com/web/packages/RSmartlyIO/index.html) ([GitHub](https://github.com/rstats-lab/RSmartlyIO)) loads Facebook and Instagram advertising data provided by [Smartly.io](https://app.smartly.io/).
  - *Other services*: [RSiteCatalyst](http://cran.rstudio.com/web/packages/RSiteCatalyst/index.html) has functions for accessing the Adobe Analytics (Omniture SiteCatalyst) Reporting API.
  - [RAdwords](http://cran.rstudio.com/web/packages/RAdwords/index.html) ([GitHub](https://github.com/jburkhardt/RAdwords)) is a package for loading Google Adwords data.
  - [webreadr](http://cran.rstudio.com/web/packages/webreadr/index.html) ([GitHub](https://github.com/Ironholds/webreadr)) can process various common forms of request log, including the Common and Combined Web Log formats and AWS logs.

**Web Services for R Package Development**

  - R-Hub <http://log.r-hub.io/> is a project to enable package builds across all architectures. [rhub](http://cran.rstudio.com/web/packages/rhub/index.html) is a package that interfaces with R-Hub to allow you to check a package on the platform.

**Other Web Services**

  - *Fitness Apps*: [fitbitScraper](http://cran.rstudio.com/web/packages/fitbitScraper/index.html) ([GitHub](https://github.com/corynissen/fitbitScraper)) retrieves Fitbit data. [RGoogleFit](http://cran.rstudio.com/web/packages/RGoogleFit/index.html) provides similar functionality for [Google Fit](https://developers.google.com/fit/rest/v1/reference/).

  - *Push Notifications*: [RPushbullet](http://cran.rstudio.com/web/packages/RPushbullet/index.html) provides an easy-to-use interface for the Pushbullet service which provides fast and efficient notifications between computers, phones and tablets. [pushoverr](http://cran.rstudio.com/web/packages/pushoverr/index.html) ([GitHub](https://github.com/briandconnelly/pushoverr)) can sending push notifications to mobile devices (iOS and Android) and desktop using [Pushover](https://pushover.net/). [notifyme](http://cran.rstudio.com/web/packages/notifyme/index.html) ([GitHub](https://github.com/epijim/notifyme)) can control Phillips Hue lighting.

  - *Reference/bibliography/citation management*: [RefManageR](http://cran.rstudio.com/web/packages/RefManageR/index.html) imports and manage BibTeX and BibLaTeX references with RefManager. [rorcid](http://cran.rstudio.com/web/packages/rorcid/index.html) ([GitHub](https://github.com/ropensci/rorcid)) is a programmatic interface the [Orcid.org](https://orcid.org/) API, which can be used for identifying scientific authors and their publications (e.g., by DOI). [rdatacite](http://cran.rstudio.com/web/packages/rdatacite/index.html) connects to [DataCite](https://www.datacite.org/), which manages DOIs and metadata for scholarly datasets. [scholar](http://cran.rstudio.com/web/packages/scholar/index.html) provides functions to extract citation data from Google Scholar. Convenience functions are also provided for comparing multiple scholars and predicting future h-index values. [mathpix](http://cran.rstudio.com/web/packages/mathpix/index.html) convert an image of a formula (typeset or handwritten) via Mathpix webservice to produce the LaTeX code.

  - *Literature*: [rplos](http://cran.rstudio.com/web/packages/rplos/index.html) is a programmatic interface to the Web Service methods provided by the Public Library of Science journals for search. [<span class="GitHub">rpubmed</span>](https://github.com/rOpenHealth/rpubmed/) (not on CRAN) provides tools for extracting and processing Pubmed and Pubmed Central records, and [europepmc](http://cran.rstudio.com/web/packages/europepmc/index.html) connects to the Europe PubMed Central service. [pubmed.mineR](http://cran.rstudio.com/web/packages/pubmed.mineR/index.html) is a package for text mining of [PubMed Abstracts](https://www.ncbi.nlm.nih.gov/pubmed) that supports fetching text and XML from PubMed. [jstor](http://cran.rstudio.com/web/packages/jstor/index.html) provides functions and helpers to import metadata, ngrams and full-texts from Data for Research service by JSTOR; [<span class="GitHub">JSTORr</span>](https://github.com/benmarwick/JSTORr/) does a similar thing. [aRxiv](http://cran.rstudio.com/web/packages/aRxiv/index.html) is a client for the arXiv API, a repository of electronic preprints for computer science, mathematics, physics, quantitative biology, quantitative finance, and statistics. [roadoi](http://cran.rstudio.com/web/packages/roadoi/index.html) provides an interface to the [Unpaywall API](https://unpaywall.org/products/api) for finding free full-text versions of academic papers. [rcoreoa](http://cran.rstudio.com/web/packages/rcoreoa/index.html) is an interface to the [CORE API](https://core.ac.uk/docs/), a search interface for open access scholarly articles. [rcrossref](http://cran.rstudio.com/web/packages/rcrossref/index.html) is an interface to Crossref’s API, [crminer](http://cran.rstudio.com/web/packages/crminer/index.html) extracts full text from scholarly articles retrieved via Crossref’s Text and Data Mining service; and [fulltext](http://cran.rstudio.com/web/packages/fulltext/index.html) is a general purpose package to search for, retrieve and extract full text from scholarly articles.

  - *Automated Metadata Harvesting*: [oai](http://cran.rstudio.com/web/packages/oai/index.html) and [OAIHarvester](http://cran.rstudio.com/web/packages/OAIHarvester/index.html) harvest metadata using the Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) standard. [<span class="GitHub">rresync</span>](https://github.com/ropenscilabs/rresync/) is a client for the [ResourceSync framework](http://www.openarchives.org/rs/1.1/resourcesync), a sort of replacement for OAI-PMH.

  - *Wikipedia*: [WikipediR](http://cran.rstudio.com/web/packages/WikipediR/index.html) ([GitHub](https://github.com/Ironholds/WikipediR)) is a wrapper for the MediaWiki API, aimed particularly at the Wikimedia ‘production’ wikis, such as Wikipedia. [<span class="GitHub">rwikidata</span>](https://github.com/chgrl/rwikidata/) and [WikidataR](http://cran.rstudio.com/web/packages/WikidataR/index.html) ([GitHub](https://github.com/Ironholds/WikidataR)) can request data from [Wikidata.org](https://www.wikidata.org/wiki/Wikidata:Main_Page), the free knowledgebase. [wikipediatrend](http://cran.rstudio.com/web/packages/wikipediatrend/index.html) ([GitHub](https://github.com/petermeissner/wikipediatrend)) provides access to Wikipedia page access statistics. [WikiSocio](http://cran.rstudio.com/web/packages/WikiSocio/index.html) can retrieve contributor lists and revision data. [WikidataQueryServiceR](http://cran.rstudio.com/web/packages/WikidataQueryServiceR/index.html) is a client for the [Wikidata Query Service](https://query.wikidata.org/).

  - [bigrquery](http://cran.rstudio.com/web/packages/bigrquery/index.html) ([GitHub](https://github.com/r-dbi/bigrquery)): An interface to Google’s bigquery.

  - [colourlovers](http://cran.rstudio.com/web/packages/colourlovers/index.html) ([GitHub](https://github.com/leeper/colourlovers)) extracts colors and multi-color patterns from [COLOURlovers](http://www.colourlovers.com/), for use in creating R graphics color palettes.

  - [cymruservices](http://cran.rstudio.com/web/packages/cymruservices/index.html) queries [Team Cymru](http://www.team-cymru.com/) web security services.

  - [datamart](http://cran.rstudio.com/web/packages/datamart/index.html): Provides an S4 infrastructure for unified handling of internal datasets and web based data sources. Examples include dbpedia, eurostat and sourceforge.

  - [discgolf](http://cran.rstudio.com/web/packages/discgolf/index.html) ([GitHub](https://github.com/sckott/discgolf)) provides a client to interact with the API for the [Discourse](https://www.discourse.org/) web forum platform. The API is for an installed instance of Discourse, not for the Discourse site itself.

  - [rdpla](http://cran.rstudio.com/web/packages/rdpla/index.html) ((GitHub)\[https://github.com/ropensci/rdpla\]) works with the [Digital Public Library of America](https://dp.la/) API.

  - [factualR](http://cran.rstudio.com/web/packages/factualR/index.html): Thin wrapper for the [Factual.com](https://www.factual.com/) server API.

  - [HIBPwned](http://cran.rstudio.com/web/packages/HIBPwned/index.html) is a client for [Have I Been Pwned](https://haveibeenpwned.com/).

  - [internetarchive](http://cran.rstudio.com/web/packages/internetarchive/index.html): API client for internet archive metadata.

  - [<span class="GitHub">irced</span>](https://github.com/hrbrmstr/irced/) (not on CRAN) is an IRC chat client.

  - [jSonarR](http://cran.rstudio.com/web/packages/jSonarR/index.html): Enables users to access MongoDB by running queries and returning their results in data.frames. jSonarR uses data processing and conversion capabilities in the jSonar Analytics Platform and the [JSON Studio Gateway](http://www.jsonar.com/), to convert JSON to a tabular format.

  - [LendingClub](http://cran.rstudio.com/web/packages/LendingClub/index.html) connects with the [LendingClub API](https://www.lendingclub.com/developers/api-overview).

  - [livechatR](http://cran.rstudio.com/web/packages/livechatR/index.html) is a client for the [LiveChat API](https://docs.livechatinc.com/rest-api/).

  - [lucr](http://cran.rstudio.com/web/packages/lucr/index.html) performs currency conversions using [Open Exchange Rates](https://openexchangerates.org/).

  - [<span class="GitHub">mockaRoo</span>](https://github.com/stephlocke/mockaRoo/) (not on CRAN) uses the [MockaRoo API](https://www.mockaroo.com/api/docs) to generate mock or fake data based on an input schema.

  - [pivotaltrackR](http://cran.rstudio.com/web/packages/pivotaltrackR/index.html) provides an interface to the API for [Pivotal Tracker](https://www.pivotaltracker.com/), an agile project management tool.

  - [randNames](http://cran.rstudio.com/web/packages/randNames/index.html) ([GitHub](https://github.com/karthik/randNames)) generates random names and personal identifying information using the <https://randomapi.com/> API.

  - [Rblpapi](http://cran.rstudio.com/web/packages/Rblpapi/index.html) ([GitHub](https://github.com/Rblp/Rblpapi)) is a client for Bloomberg Finance L.P. [ROpenFIGI](http://cran.rstudio.com/web/packages/ROpenFIGI/index.html) ([GitHub](https://github.com/HuangRicky/ROpenFIGI)) provides an interface to Bloomberg’s [OpenFIGI](https://openfigi.com/) API.

  - [rerddap](http://cran.rstudio.com/web/packages/rerddap/index.html): A generic R client to interact with any ERDDAP instance, which is a special case of OPeNDAP ( <https://en.wikipedia.org/wiki/OPeNDAP>), or *Open-source Project for a Network Data Access Protocol* . Allows user to swap out the base URL to use any ERDDAP instance.

  - [<span class="GitHub">ripplerestr</span>](https://github.com/hmalmedal/ripplerestr/) provides an interface to the [Ripple](https://ripple.com/) protocol for making financial transactions.

  - [refimpact](http://cran.rstudio.com/web/packages/refimpact/index.html) connects to [the UK Research Excellence Framework 2014 Impact Case Studies Database API](http://impact.ref.ac.uk/CaseStudies/).

  - [restimizeapi](http://cran.rstudio.com/web/packages/restimizeapi/index.html) provides an interface to trading website [estimize.com](https://www.estimize.com/).

  - [RForcecom](http://cran.rstudio.com/web/packages/RForcecom/index.html): RForcecom provides a connection to Force.com and Salesforce.com.

  - [<span class="GitHub">Rgoodreads</span>](https://github.com/dsidavis/Rgoodreads/) (not on CRAN) interacts with [Goodreads](https://www.goodreads.com/).

  - Two packages, [owmr](http://cran.rstudio.com/web/packages/owmr/index.html) and [ROpenWeatherMap](http://cran.rstudio.com/web/packages/ROpenWeatherMap/index.html), work with the [Open Weather Map API](https://openweathermap.org/api).

  - [RSauceLabs](http://cran.rstudio.com/web/packages/RSauceLabs/index.html) ([GitHub](https://johndharrison.github.io/RSauceLabs/)) connects to [SauceLabs](https://saucelabs.com/).

  - [RSocrata](http://cran.rstudio.com/web/packages/RSocrata/index.html) access data for Socrata open data portals. [soql](http://cran.rstudio.com/web/packages/soql/index.html) is a pipe-oriented set of tools for constructing Socrata queries.

  - [RStripe](http://cran.rstudio.com/web/packages/RStripe/index.html) provides an interface to [Stripe](https://stripe.com/), an online payment processor.

  - [RZabbix](http://cran.rstudio.com/web/packages/RZabbix/index.html) links with the [Zabbix network monitoring service API](https://www.zabbix.com/documentation/3.0/manual/api/reference).

  - [rwars](http://cran.rstudio.com/web/packages/rwars/index.html) retrieve and reformat data from the [Star Wars API (SWAPI)](https://swapi.co/).

  - [slackr](http://cran.rstudio.com/web/packages/slackr/index.html) ([GitHub](https://github.com/hrbrmstr/slackr)) is a client for Slack.com messaging platform.

  - [<span class="GitHub">SlideShaRe</span>](https://github.com/dmpe/SlideShaRe/) (not on CRAN) is a client for Slideshare.

  - [<span class="GitHub">stackr</span>](https://github.com/dgrtwo/stackr/) (not on CRAN): An unofficial wrapper for the read-only features of the [Stack Exchange API](https://api.stackexchange.com/).

  - [telegram](http://cran.rstudio.com/web/packages/telegram/index.html) ([GitHub](https://github.com/lbraglia/telegram)) connects with the Telegram Bot API.

  - [trelloR](http://cran.rstudio.com/web/packages/trelloR/index.html) ([GitHub](https://github.com/jchrom/trelloR)) connects to the [Trello API](https://developers.trello.com/).

  - [tuber](http://cran.rstudio.com/web/packages/tuber/index.html) is a YouTube API client and [tubern](http://cran.rstudio.com/web/packages/tubern/index.html) is a client for the YouTube Analytics and Reporting API

  - [ubeR](http://cran.rstudio.com/web/packages/ubeR/index.html) is an interface to the Uber API.

  - [udapi](http://cran.rstudio.com/web/packages/udapi/index.html) connects to Urban Dictionary.

  - [<span class="GitHub">useRsnap</span>](https://github.com/nealrichardson/useRsnap/) (not on CRAN) provides an interface to the API for [Usersnap](https://www.pivotaltracker.com/), a tool for collecting feedback from web application users.

  - [yummlyr](http://cran.rstudio.com/web/packages/yummlyr/index.html) ([GitHub](https://github.com/RomanTsegelskyi/yummlyr)) provides an interface to the [Yummly](https://developer.yummly.com/) recipe database.

  - [zendeskR](http://cran.rstudio.com/web/packages/zendeskR/index.html): This package provides a wrapper for the Zendesk API.

  - [ZillowR](http://cran.rstudio.com/web/packages/ZillowR/index.html) is a client for the Zillow real estate service.

  - [docuSignr](http://cran.rstudio.com/web/packages/docuSignr/index.html) provides an interface to the DocuSign [Rest API](https://developers.docusign.com/).

  - [giphyr](http://cran.rstudio.com/web/packages/giphyr/index.html) is an R interface to the [Giphy API](https://github.com/Giphy/GiphyAPI) for GIF’s

  - [duckduckr](http://cran.rstudio.com/web/packages/duckduckr/index.html) is an R interface [DuckDuckGo’s Instant Answer API](https://duckduckgo.com/api)

</div>

### CRAN packages:

  - [abbyyR](http://cran.rstudio.com/web/packages/abbyyR/index.html)
  - [ajv](http://cran.rstudio.com/web/packages/ajv/index.html)
  - [analogsea](http://cran.rstudio.com/web/packages/analogsea/index.html)
  - [aRxiv](http://cran.rstudio.com/web/packages/aRxiv/index.html)
  - [aws.polly](http://cran.rstudio.com/web/packages/aws.polly/index.html)
  - [aws.s3](http://cran.rstudio.com/web/packages/aws.s3/index.html)
  - [aws.signature](http://cran.rstudio.com/web/packages/aws.signature/index.html)
  - [aws.sns](http://cran.rstudio.com/web/packages/aws.sns/index.html)
  - [AzureML](http://cran.rstudio.com/web/packages/AzureML/index.html)
  - [backblazer](http://cran.rstudio.com/web/packages/backblazer/index.html)
  - [banR](http://cran.rstudio.com/web/packages/banR/index.html)
  - [bigml](http://cran.rstudio.com/web/packages/bigml/index.html)
  - [bigrquery](http://cran.rstudio.com/web/packages/bigrquery/index.html)
  - [birdnik](http://cran.rstudio.com/web/packages/birdnik/index.html)
  - [boilerpipeR](http://cran.rstudio.com/web/packages/boilerpipeR/index.html)
  - [boxr](http://cran.rstudio.com/web/packages/boxr/index.html)
  - [captr](http://cran.rstudio.com/web/packages/captr/index.html)
  - [clarifai](http://cran.rstudio.com/web/packages/clarifai/index.html)
  - [colourlovers](http://cran.rstudio.com/web/packages/colourlovers/index.html)
  - [crminer](http://cran.rstudio.com/web/packages/crminer/index.html)
  - [crplyr](http://cran.rstudio.com/web/packages/crplyr/index.html)
  - [crul](http://cran.rstudio.com/web/packages/crul/index.html) (core)
  - [crunch](http://cran.rstudio.com/web/packages/crunch/index.html)
  - [crunchy](http://cran.rstudio.com/web/packages/crunchy/index.html)
  - [curl](http://cran.rstudio.com/web/packages/curl/index.html) (core)
  - [cymruservices](http://cran.rstudio.com/web/packages/cymruservices/index.html)
  - [d3Network](http://cran.rstudio.com/web/packages/d3Network/index.html)
  - [datamart](http://cran.rstudio.com/web/packages/datamart/index.html)
  - [dataone](http://cran.rstudio.com/web/packages/dataone/index.html)
  - [datarobot](http://cran.rstudio.com/web/packages/datarobot/index.html)
  - [dataverse](http://cran.rstudio.com/web/packages/dataverse/index.html)
  - [ddeploy](http://cran.rstudio.com/web/packages/ddeploy/index.html)
  - [discgolf](http://cran.rstudio.com/web/packages/discgolf/index.html)
  - [docuSignr](http://cran.rstudio.com/web/packages/docuSignr/index.html)
  - [downloader](http://cran.rstudio.com/web/packages/downloader/index.html)
  - [duckduckr](http://cran.rstudio.com/web/packages/duckduckr/index.html)
  - [europepmc](http://cran.rstudio.com/web/packages/europepmc/index.html)
  - [facebook.S4](http://cran.rstudio.com/web/packages/facebook.S4/index.html)
  - [factualR](http://cran.rstudio.com/web/packages/factualR/index.html)
  - [FastRWeb](http://cran.rstudio.com/web/packages/FastRWeb/index.html)
  - [fauxpas](http://cran.rstudio.com/web/packages/fauxpas/index.html)
  - [fbRads](http://cran.rstudio.com/web/packages/fbRads/index.html)
  - [feedeR](http://cran.rstudio.com/web/packages/feedeR/index.html)
  - [fiery](http://cran.rstudio.com/web/packages/fiery/index.html)
  - [fitbitScraper](http://cran.rstudio.com/web/packages/fitbitScraper/index.html)
  - [fulltext](http://cran.rstudio.com/web/packages/fulltext/index.html)
  - [ganalytics](http://cran.rstudio.com/web/packages/ganalytics/index.html)
  - [GAR](http://cran.rstudio.com/web/packages/GAR/index.html)
  - [gdns](http://cran.rstudio.com/web/packages/gdns/index.html)
  - [genderizeR](http://cran.rstudio.com/web/packages/genderizeR/index.html)
  - [geoparser](http://cran.rstudio.com/web/packages/geoparser/index.html)
  - [geosapi](http://cran.rstudio.com/web/packages/geosapi/index.html)
  - [ggmap](http://cran.rstudio.com/web/packages/ggmap/index.html)
  - [ggvis](http://cran.rstudio.com/web/packages/ggvis/index.html)
  - [gh](http://cran.rstudio.com/web/packages/gh/index.html)
  - [giphyr](http://cran.rstudio.com/web/packages/giphyr/index.html)
  - [gistr](http://cran.rstudio.com/web/packages/gistr/index.html)
  - [git2r](http://cran.rstudio.com/web/packages/git2r/index.html)
  - [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html)
  - [gmailr](http://cran.rstudio.com/web/packages/gmailr/index.html)
  - [googleAnalyticsR](http://cran.rstudio.com/web/packages/googleAnalyticsR/index.html)
  - [googleCloudStorageR](http://cran.rstudio.com/web/packages/googleCloudStorageR/index.html)
  - [googleComputeEngineR](http://cran.rstudio.com/web/packages/googleComputeEngineR/index.html)
  - [googleLanguageR](http://cran.rstudio.com/web/packages/googleLanguageR/index.html)
  - [googlesheets](http://cran.rstudio.com/web/packages/googlesheets/index.html)
  - [googleVis](http://cran.rstudio.com/web/packages/googleVis/index.html)
  - [graphTweets](http://cran.rstudio.com/web/packages/graphTweets/index.html)
  - [gsheet](http://cran.rstudio.com/web/packages/gsheet/index.html)
  - [gtrendsR](http://cran.rstudio.com/web/packages/gtrendsR/index.html)
  - [HIBPwned](http://cran.rstudio.com/web/packages/HIBPwned/index.html)
  - [htm2txt](http://cran.rstudio.com/web/packages/htm2txt/index.html)
  - [htmltab](http://cran.rstudio.com/web/packages/htmltab/index.html)
  - [htmltidy](http://cran.rstudio.com/web/packages/htmltidy/index.html)
  - [htmltools](http://cran.rstudio.com/web/packages/htmltools/index.html)
  - [httpcache](http://cran.rstudio.com/web/packages/httpcache/index.html)
  - [httpcode](http://cran.rstudio.com/web/packages/httpcode/index.html)
  - [httping](http://cran.rstudio.com/web/packages/httping/index.html)
  - [httpRequest](http://cran.rstudio.com/web/packages/httpRequest/index.html)
  - [httptest](http://cran.rstudio.com/web/packages/httptest/index.html)
  - [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html)
  - [httr](http://cran.rstudio.com/web/packages/httr/index.html) (core)
  - [imguR](http://cran.rstudio.com/web/packages/imguR/index.html)
  - [instaR](http://cran.rstudio.com/web/packages/instaR/index.html)
  - [internetarchive](http://cran.rstudio.com/web/packages/internetarchive/index.html)
  - [iptools](http://cran.rstudio.com/web/packages/iptools/index.html)
  - [jqr](http://cran.rstudio.com/web/packages/jqr/index.html)
  - [js](http://cran.rstudio.com/web/packages/js/index.html)
  - [jSonarR](http://cran.rstudio.com/web/packages/jSonarR/index.html)
  - [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html) (core)
  - [jsonvalidate](http://cran.rstudio.com/web/packages/jsonvalidate/index.html)
  - [jstor](http://cran.rstudio.com/web/packages/jstor/index.html)
  - [jug](http://cran.rstudio.com/web/packages/jug/index.html)
  - [languagelayeR](http://cran.rstudio.com/web/packages/languagelayeR/index.html)
  - [leafletR](http://cran.rstudio.com/web/packages/leafletR/index.html)
  - [LendingClub](http://cran.rstudio.com/web/packages/LendingClub/index.html)
  - [livechatR](http://cran.rstudio.com/web/packages/livechatR/index.html)
  - [longurl](http://cran.rstudio.com/web/packages/longurl/index.html)
  - [lucr](http://cran.rstudio.com/web/packages/lucr/index.html)
  - [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html)
  - [mailR](http://cran.rstudio.com/web/packages/mailR/index.html)
  - [mapsapi](http://cran.rstudio.com/web/packages/mapsapi/index.html)
  - [mathpix](http://cran.rstudio.com/web/packages/mathpix/index.html)
  - [mime](http://cran.rstudio.com/web/packages/mime/index.html)
  - [mscstexta4r](http://cran.rstudio.com/web/packages/mscstexta4r/index.html)
  - [mscsweblm4r](http://cran.rstudio.com/web/packages/mscsweblm4r/index.html)
  - [MTurkR](http://cran.rstudio.com/web/packages/MTurkR/index.html)
  - [ndjson](http://cran.rstudio.com/web/packages/ndjson/index.html)
  - [notifyme](http://cran.rstudio.com/web/packages/notifyme/index.html)
  - [oai](http://cran.rstudio.com/web/packages/oai/index.html)
  - [OAIHarvester](http://cran.rstudio.com/web/packages/OAIHarvester/index.html)
  - [openadds](http://cran.rstudio.com/web/packages/openadds/index.html)
  - [opencage](http://cran.rstudio.com/web/packages/opencage/index.html)
  - [opencpu](http://cran.rstudio.com/web/packages/opencpu/index.html)
  - [OpenML](http://cran.rstudio.com/web/packages/OpenML/index.html)
  - [osmar](http://cran.rstudio.com/web/packages/osmar/index.html)
  - [osmplotr](http://cran.rstudio.com/web/packages/osmplotr/index.html)
  - [osrm](http://cran.rstudio.com/web/packages/osrm/index.html)
  - [owmr](http://cran.rstudio.com/web/packages/owmr/index.html)
  - [pdftables](http://cran.rstudio.com/web/packages/pdftables/index.html)
  - [pivotaltrackR](http://cran.rstudio.com/web/packages/pivotaltrackR/index.html)
  - [placement](http://cran.rstudio.com/web/packages/placement/index.html)
  - [plotGoogleMaps](http://cran.rstudio.com/web/packages/plotGoogleMaps/index.html)
  - [plotKML](http://cran.rstudio.com/web/packages/plotKML/index.html)
  - [plotly](http://cran.rstudio.com/web/packages/plotly/index.html)
  - [plumber](http://cran.rstudio.com/web/packages/plumber/index.html)
  - [plusser](http://cran.rstudio.com/web/packages/plusser/index.html)
  - [postlightmercury](http://cran.rstudio.com/web/packages/postlightmercury/index.html)
  - [pubmed.mineR](http://cran.rstudio.com/web/packages/pubmed.mineR/index.html)
  - [pushoverr](http://cran.rstudio.com/web/packages/pushoverr/index.html)
  - [qualtRics](http://cran.rstudio.com/web/packages/qualtRics/index.html)
  - [radiant](http://cran.rstudio.com/web/packages/radiant/index.html)
  - [RAdwords](http://cran.rstudio.com/web/packages/RAdwords/index.html)
  - [randNames](http://cran.rstudio.com/web/packages/randNames/index.html)
  - [rapiclient](http://cran.rstudio.com/web/packages/rapiclient/index.html)
  - [rapport](http://cran.rstudio.com/web/packages/rapport/index.html)
  - [Rblpapi](http://cran.rstudio.com/web/packages/Rblpapi/index.html)
  - [rcoreoa](http://cran.rstudio.com/web/packages/rcoreoa/index.html)
  - [Rcrawler](http://cran.rstudio.com/web/packages/Rcrawler/index.html)
  - [rcrossref](http://cran.rstudio.com/web/packages/rcrossref/index.html)
  - [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html)
  - [rdatacite](http://cran.rstudio.com/web/packages/rdatacite/index.html)
  - [rdpla](http://cran.rstudio.com/web/packages/rdpla/index.html)
  - [rdrop2](http://cran.rstudio.com/web/packages/rdrop2/index.html)
  - [redcapAPI](http://cran.rstudio.com/web/packages/redcapAPI/index.html)
  - [refimpact](http://cran.rstudio.com/web/packages/refimpact/index.html)
  - [RefManageR](http://cran.rstudio.com/web/packages/RefManageR/index.html)
  - [repmis](http://cran.rstudio.com/web/packages/repmis/index.html)
  - [reqres](http://cran.rstudio.com/web/packages/reqres/index.html)
  - [request](http://cran.rstudio.com/web/packages/request/index.html)
  - [rerddap](http://cran.rstudio.com/web/packages/rerddap/index.html)
  - [restfulr](http://cran.rstudio.com/web/packages/restfulr/index.html)
  - [restimizeapi](http://cran.rstudio.com/web/packages/restimizeapi/index.html)
  - [Rexperigen](http://cran.rstudio.com/web/packages/Rexperigen/index.html)
  - [Rfacebook](http://cran.rstudio.com/web/packages/Rfacebook/index.html)
  - [rfigshare](http://cran.rstudio.com/web/packages/rfigshare/index.html)
  - [RForcecom](http://cran.rstudio.com/web/packages/RForcecom/index.html)
  - [RGA](http://cran.rstudio.com/web/packages/RGA/index.html)
  - [rgeolocate](http://cran.rstudio.com/web/packages/rgeolocate/index.html)
  - [RGoogleFit](http://cran.rstudio.com/web/packages/RGoogleFit/index.html)
  - [RgoogleMaps](http://cran.rstudio.com/web/packages/RgoogleMaps/index.html)
  - [rhub](http://cran.rstudio.com/web/packages/rhub/index.html)
  - [rio](http://cran.rstudio.com/web/packages/rio/index.html)
  - [rjson](http://cran.rstudio.com/web/packages/rjson/index.html)
  - [rjsonapi](http://cran.rstudio.com/web/packages/rjsonapi/index.html)
  - [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html)
  - [rLTP](http://cran.rstudio.com/web/packages/rLTP/index.html)
  - [roadoi](http://cran.rstudio.com/web/packages/roadoi/index.html)
  - [ROAuth](http://cran.rstudio.com/web/packages/ROAuth/index.html)
  - [robotstxt](http://cran.rstudio.com/web/packages/robotstxt/index.html)
  - [Rook](http://cran.rstudio.com/web/packages/Rook/index.html)
  - [ROpenFIGI](http://cran.rstudio.com/web/packages/ROpenFIGI/index.html)
  - [ROpenWeatherMap](http://cran.rstudio.com/web/packages/ROpenWeatherMap/index.html)
  - [rorcid](http://cran.rstudio.com/web/packages/rorcid/index.html)
  - [rosetteApi](http://cran.rstudio.com/web/packages/rosetteApi/index.html)
  - [routr](http://cran.rstudio.com/web/packages/routr/index.html)
  - [rpinterest](http://cran.rstudio.com/web/packages/rpinterest/index.html)
  - [rplos](http://cran.rstudio.com/web/packages/rplos/index.html)
  - [RPushbullet](http://cran.rstudio.com/web/packages/RPushbullet/index.html)
  - [rrefine](http://cran.rstudio.com/web/packages/rrefine/index.html)
  - [RSauceLabs](http://cran.rstudio.com/web/packages/RSauceLabs/index.html)
  - [RSclient](http://cran.rstudio.com/web/packages/RSclient/index.html)
  - [rsdmx](http://cran.rstudio.com/web/packages/rsdmx/index.html)
  - [Rserve](http://cran.rstudio.com/web/packages/Rserve/index.html)
  - [RSiteCatalyst](http://cran.rstudio.com/web/packages/RSiteCatalyst/index.html)
  - [RSmartlyIO](http://cran.rstudio.com/web/packages/RSmartlyIO/index.html)
  - [RSocrata](http://cran.rstudio.com/web/packages/RSocrata/index.html)
  - [RStripe](http://cran.rstudio.com/web/packages/RStripe/index.html)
  - [rtweet](http://cran.rstudio.com/web/packages/rtweet/index.html)
  - [rvest](http://cran.rstudio.com/web/packages/rvest/index.html)
  - [rwars](http://cran.rstudio.com/web/packages/rwars/index.html)
  - [RYandexTranslate](http://cran.rstudio.com/web/packages/RYandexTranslate/index.html)
  - [RZabbix](http://cran.rstudio.com/web/packages/RZabbix/index.html)
  - [scholar](http://cran.rstudio.com/web/packages/scholar/index.html)
  - [scrapeR](http://cran.rstudio.com/web/packages/scrapeR/index.html)
  - [searchConsoleR](http://cran.rstudio.com/web/packages/searchConsoleR/index.html)
  - [securitytxt](http://cran.rstudio.com/web/packages/securitytxt/index.html)
  - [seleniumPipes](http://cran.rstudio.com/web/packages/seleniumPipes/index.html)
  - [sendmailR](http://cran.rstudio.com/web/packages/sendmailR/index.html)
  - [servr](http://cran.rstudio.com/web/packages/servr/index.html)
  - [shiny](http://cran.rstudio.com/web/packages/shiny/index.html) (core)
  - [slackr](http://cran.rstudio.com/web/packages/slackr/index.html)
  - [SocialMediaMineR](http://cran.rstudio.com/web/packages/SocialMediaMineR/index.html)
  - [soql](http://cran.rstudio.com/web/packages/soql/index.html)
  - [spiderbar](http://cran.rstudio.com/web/packages/spiderbar/index.html)
  - [streamR](http://cran.rstudio.com/web/packages/streamR/index.html)
  - [swagger](http://cran.rstudio.com/web/packages/swagger/index.html)
  - [telegram](http://cran.rstudio.com/web/packages/telegram/index.html)
  - [threewords](http://cran.rstudio.com/web/packages/threewords/index.html)
  - [tidyRSS](http://cran.rstudio.com/web/packages/tidyRSS/index.html)
  - [tm.plugin.webmining](http://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html)
  - [transcribeR](http://cran.rstudio.com/web/packages/transcribeR/index.html)
  - [translate](http://cran.rstudio.com/web/packages/translate/index.html)
  - [translateR](http://cran.rstudio.com/web/packages/translateR/index.html)
  - [trelloR](http://cran.rstudio.com/web/packages/trelloR/index.html)
  - [tuber](http://cran.rstudio.com/web/packages/tuber/index.html)
  - [tubern](http://cran.rstudio.com/web/packages/tubern/index.html)
  - [tumblR](http://cran.rstudio.com/web/packages/tumblR/index.html)
  - [tweet2r](http://cran.rstudio.com/web/packages/tweet2r/index.html)
  - [twitteR](http://cran.rstudio.com/web/packages/twitteR/index.html)
  - [uaparserjs](http://cran.rstudio.com/web/packages/uaparserjs/index.html)
  - [ubeR](http://cran.rstudio.com/web/packages/ubeR/index.html)
  - [udapi](http://cran.rstudio.com/web/packages/udapi/index.html)
  - [urlshorteneR](http://cran.rstudio.com/web/packages/urlshorteneR/index.html)
  - [urltools](http://cran.rstudio.com/web/packages/urltools/index.html)
  - [V8](http://cran.rstudio.com/web/packages/V8/index.html)
  - [validatejsonr](http://cran.rstudio.com/web/packages/validatejsonr/index.html)
  - [vcr](http://cran.rstudio.com/web/packages/vcr/index.html) (core)
  - [vkR](http://cran.rstudio.com/web/packages/vkR/index.html)
  - [W3CMarkupValidator](http://cran.rstudio.com/web/packages/W3CMarkupValidator/index.html)
  - [webmockr](http://cran.rstudio.com/web/packages/webmockr/index.html) (core)
  - [webreadr](http://cran.rstudio.com/web/packages/webreadr/index.html)
  - [webshot](http://cran.rstudio.com/web/packages/webshot/index.html)
  - [webutils](http://cran.rstudio.com/web/packages/webutils/index.html)
  - [whisker](http://cran.rstudio.com/web/packages/whisker/index.html)
  - [WikidataQueryServiceR](http://cran.rstudio.com/web/packages/WikidataQueryServiceR/index.html)
  - [WikidataR](http://cran.rstudio.com/web/packages/WikidataR/index.html)
  - [wikipediatrend](http://cran.rstudio.com/web/packages/wikipediatrend/index.html)
  - [WikipediR](http://cran.rstudio.com/web/packages/WikipediR/index.html)
  - [WikiSocio](http://cran.rstudio.com/web/packages/WikiSocio/index.html)
  - [WufooR](http://cran.rstudio.com/web/packages/WufooR/index.html)
  - [XML](http://cran.rstudio.com/web/packages/XML/index.html)
  - [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) (core)
  - [XML2R](http://cran.rstudio.com/web/packages/XML2R/index.html)
  - [xslt](http://cran.rstudio.com/web/packages/xslt/index.html)
  - [yhatr](http://cran.rstudio.com/web/packages/yhatr/index.html)
  - [yummlyr](http://cran.rstudio.com/web/packages/yummlyr/index.html)
  - [zendeskR](http://cran.rstudio.com/web/packages/zendeskR/index.html)
  - [ZillowR](http://cran.rstudio.com/web/packages/ZillowR/index.html)

### Related links:

  - [Open Data TaskView](https://github.com/ropensci/opendata)
