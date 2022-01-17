---
name: WebTechnologies
topic: Web Technologies and Services
maintainer: Mauricio Vargas Sepulveda
email: mavargas11@uc.cl
version: 2022-01-16
---

This Task View contains information about to use R and the world wide web
together. The base version of R does not ship with many tools for interacting
with the web. Thankfully, there are an increasingly large number of tools for
interacting with the web. This task view focuses on packages for obtaining web-
based data and information, frameworks for building web-based R applications,
and online services that can be accessed from R. A list of available packages
and functions is presented below, grouped by the type of activity. The
[rOpenSci Task View: Open Data](https://github.com/ropensci/opendata) provides
further discussion of online data sources that can be accessed from R.

If you have any comments or suggestions for additions or improvements for this
Task View, go to GitHub and [submit an issue](https://github.com/ropensci/
webservices/issues), or make some changes and [submit a pull request](https://
github.com/ropensci/webservices/pulls). If you can’t contribute on GitHub,
[send Mauricio an email](mailto:mavargas11@uc.cl). If you have an issue with
one of the packages discussed below, please contact the maintainer of that
package.

Before 2022, this task view was maintained by Scott Chamberlain, Thomas Leeper,
Patrick Mair, Karthik Ram and Christopher Gandrud. Thanks to all of them for
volunteering to improve CRAN\!

## Tools for Working with the Web from R

**Core Tools For HTTP Requests**

There are three main packages that should cover most use cases of interacting
with the web from R. [crul](https://cran.rstudio.com/web/packages/crul/
index.html) is an R6-based HTTP client that provides asynchronous HTTP
requests, a pagination helper, HTTP mocking via [webmockr](https://
cran.rstudio.com/web/packages/webmockr/index.html), and request caching for
unit tests via [vcr](https://cran.rstudio.com/web/packages/vcr/index.html).
crul targets R developers more so than end users. [httr](https://
cran.rstudio.com/web/packages/httr/index.html) provides more of a user facing
client for HTTP requests and differentiates from the former package in that it
provides support for OAuth. Note that you can pass in additional curl options
when you instantiate R6 classes in crul, and the `config` parameter in httr.
[curl](https://cran.rstudio.com/web/packages/curl/index.html) is a lower-level
package that provides a closer interface between R and the [libcurl C
library](https://curl.se/libcurl/), but is less user-friendly. curl underlies
both crul and httr. curl may be useful for operations on web-based XML or to
perform FTP operations (as crul and httr are focused primarily on HTTP).
`curl::curl()` is an SSL-compatible replacement for base R’s `url()` and has
support for http 2.0, SSL (https, ftps), gzip, deflate and more. For websites
serving insecure HTTP (i.e. using the “http” not “https” prefix), most R
functions can extract data directly, including `read.table` and `read.csv`;
this also applies to functions in add-on packages such as
`jsonlite::fromJSON()` and `XML::parseXML`. For more specific situations, the
following resources may be useful:

  - [RCurl](https://cran.rstudio.com/web/packages/RCurl/index.html) is another
    low level client for libcurl. Of the two low-level curl clients, we
    recommend using [curl](https://cran.rstudio.com/web/packages/curl/
    index.html). [httpRequest](https://cran.rstudio.com/web/packages/\
    httpRequest/index.html) is another low-level package for HTTP requests that
    implements the GET, POST and multipart POST verbs, but we do not recommend
    its use.
  - [request](https://cran.rstudio.com/web/packages/request/index.html)
    provides a high-level package that is useful for developing other API client
    packages. [httping](https://cran.rstudio.com/web/packages/httping/
    index.html) provides simplified tools to ping and time HTTP requests, around
    [httr](https://cran.rstudio.com/web/packages/httr/index.html) calls.
    [httpcache](https://cran.rstudio.com/web/packages/httpcache/index.html)
    provides a mechanism for caching HTTP requests.
  - For dynamically generated webpages (i.e., those requiring user interaction
    to display results), [RSelenium](https://cran.rstudio.com/web/packages/
    RSelenium/index.html) can be used to automate those interactions and extract
    page contents. It provides a set of bindings for the Selenium 2.0 webdriver
    using the [JsonWireProtocol](https://github.com/seleniumhq/selenium-google-
    code-issue-archive). It can also aid in automated application testing, load
    testing, and web scraping. [seleniumPipes](https://cran.rstudio.com/web/
    packages/seleniumPipes/index.html) ([GitHub](https://github.com/
    johndharrison/seleniumPipes) ) provides a “pipe”-oriented interface to the
    same. An alternative to the former two packages is [splashr](https://
    cran.rstudio.com/web/packages/splashr/index.html) that vouches to be a
    lightweight altnernative. [<span class="GitHub">rdom</span>](https://
    github.com/cpsievert/rdom/) (not on CRAN) uses [phantomjs](https://
    phantomjs.org/) to access a webpage’s Document Object Model (DOM).
  - For capturing static content of web pages [postlightmercury](https://
    cran.rstudio.com/web/packages/postlightmercury/index.html) is a client for
    the web service [Mercury](https://mercury.postlight.com/) that turns web
    pages into structured and clean text.
  - Another, higher-level alternative package useful for webscraping is
    [rvest](https://cran.rstudio.com/web/packages/rvest/index.html), which is
    designed to work with [magrittr](https://cran.rstudio.com/web/packages/
    magrittr/index.html) to make it easy to express common web scraping tasks.
  - Many base R tools can be used to download web content, provided that the
    website does not use SSL (i.e., the URL does not have the “https” prefix).
    `download.file()` is a general purpose function that can be used to download
    a remote file. For SSL, the `download()` function in [downloader](https://
    cran.rstudio.com/web/packages/downloader/index.html) wraps
    `download.file()`, and takes all the same arguments.
  - Tabular data sets (e.g., txt, csv, etc.) can be input using `read.table()`,
    `read.csv()`, and friends, again assuming that the files are not hosted via
    SSL. An alternative is to use `httr::GET` (or `RCurl::getURL`) to first read
    the file into R as a character vector before parsing with
    `read.table(text=...)`, or you can download the file to a local directory.
    [rio](https://cran.rstudio.com/web/packages/rio/index.html)
    ([GitHub](https://github.com/leeper/rio) ) provides an `import()` function
    that can read a number of common data formats directly from an https://
    URL. The [repmis](https://cran.rstudio.com/web/packages/repmis/index.html)
    function `source_data()` can load and cache plain-text data from a URL
    (either http or https). That package also includes `source_Dropbox()` for
    downloading/caching plain-text data from non-public Dropbox folders and
    `source_XlsxData()` for downloading/caching Excel xlsx sheets.
  - *Authentication*: Using web resources can require authentication, either
    via API keys, OAuth, username:password combination, or via other means.
    Additionally, sometimes web resources that require authentication be in the
    header of an http call, which requires a little bit of extra work. API keys
    and username:password combos can be combined within a url for a call to a
    web resource, or can be specified via commands in [RCurl](https://
    cran.rstudio.com/web/packages/RCurl/index.html) or [httr](https://
    cran.rstudio.com/web/packages/httr/index.html). OAuth is the most
    complicated authentication process, and can be most easily done using
    [httr](https://cran.rstudio.com/web/packages/httr/index.html). See the 6
    demos within [httr](https://cran.rstudio.com/web/packages/httr/index.html),
    three for OAuth 1.0 (linkedin, twitter, vimeo) and three for OAuth 2.0
    (facebook, GitHub, google). [ROAuth](https://cran.rstudio.com/web/packages/
    ROAuth/index.html) is a package that provides a separate R interface to
    OAuth. OAuth is easier to to do in [httr](https://cran.rstudio.com/web/
    packages/httr/index.html), so start there. [googleAuthR](https://
    cran.rstudio.com/web/packages/googleAuthR/index.html) provides an OAuth 2.0
    setup specifically for Google web services, and [AzureAuth](https://
    cran.rstudio.com/web/packages/AzureAuth/index.html) provides similar
    functionality for Azure Active Directory.

**Handling HTTP Errors/Codes**

  - [fauxpas](https://cran.rstudio.com/web/packages/fauxpas/index.html) brings
    a set of Ruby or Python like R6 classes for each individual HTTP status
    code, allowing simple and verbose messages, with a choice of using messages,
    warnings, or stops.
  - [httpcode](https://cran.rstudio.com/web/packages/httpcode/index.html) is a
    simple package to help a user/package find HTTP status codes and associated
    messages by name or number.

**Parsing Structured Web Data**

The vast majority of web-based data is structured as plain text, HTML, XML, or
JSON (javascript object notation). Web service APIs increasingly rely on JSON,
but XML is still prevalent in many applications. There are several packages for
specifically working with these format. These functions can be used to interact
directly with insecure web pages or can be used to parse locally stored or in-
memory web files.

  - *XML*: There are two packages for working with XML: [XML](https://
    cran.rstudio.com/web/packages/XML/index.html) and [xml2](https://
    cran.rstudio.com/web/packages/xml2/index.html) ([GitHub](https://github.com/
    r-lib/xml2) ). Both support general XML (and HTML) parsing, including XPath
    queries. The package [xml2](https://cran.rstudio.com/web/packages/xml2/
    index.html) is less fully featured, but more user friendly with respect to
    memory management, classes (e.g., XML node vs. node set vs. document), and
    namespaces. Of the two, only the [XML](https://cran.rstudio.com/web/
    packages/XML/index.html) supports *de novo* creation of XML nodes and
    documents. The [XML2R](https://cran.rstudio.com/web/packages/XML2R/
    index.html)([GitHub](https://github.com/cpsievert/XML2R)) package is a
    collection of convenient functions for coercing XML into data frames. An
    alternative to [XML](https://cran.rstudio.com/web/packages/XML/index.html)
    is [selectr](https://sjp.co.nz/projects/selectr/), which parses CSS3
    Selectors and translates them to XPath 1.0 expressions. [XML](https://
    cran.rstudio.com/web/packages/XML/index.html) package is often used for
    parsing xml and html, but selectr translates CSS selectors to XPath, so can
    use the CSS selectors instead of XPath.
  - *HTML*: All of the tools that work with XML also work for HTML, though HTML
    is - in practice - more prone to be malformed. Some tools are designed
    specifically to work with HTML. `xml2::read_html()` is a good first function
    to use for importing HTML. [htmltools](https://cran.rstudio.com/web/
    packages/htmltools/index.html) provides functions to create HTML elements.
    The [selectorgadget browser extension](https://selectorgadget.com/) can be
    used to identify page elements. [<span class="Ohat">RHTMLForms</
    span>](http://www.Omegahat.net/RHTMLForms/) reads HTML documents and
    obtains a description of each of the forms it contains, along with the
    different elements and hidden fields. [scrapeR](https://cran.rstudio.com/
    web/packages/scrapeR/index.html) provides additional tools for scraping
    data from HTML documents.
    [htmltidy](https://cran.rstudio.com/web/packages/htmltidy/index.html)
    ([GitHub](https://github.com/hrbrmstr/htmltidy) ) provides tools to “tidy”
    messy HTML documents. [htm2txt](https://cran.rstudio.com/web/packages/
    htm2txt/index.html) uses regex to converts html documents to plain text by
    removing all html tags. [Rcrawler](https://cran.rstudio.com/web/packages/
    Rcrawler/index.html) does crawling and scraping of web pages.
  - *JSON*: There are several packages for reading and writing JSON:
    [rjson](https://cran.rstudio.com/web/packages/rjson/index.html),
    [RJSONIO](https://cran.rstudio.com/web/packages/RJSONIO/index.html), and
    [jsonlite](https://cran.rstudio.com/web/packages/jsonlite/index.html).
    [jsonlite](https://cran.rstudio.com/web/packages/jsonlite/index.html)
    includes a different parser from [RJSONIO](https://cran.rstudio.com/web/
    packages/RJSONIO/index.html) called [yajl](https://lloyd.github.io/yajl/) .
    We recommend using [jsonlite](https://cran.rstudio.com/web/packages/
    jsonlite/index.html). Check out the paper describing jsonlite by Jeroen
    Ooms <https://arxiv.org/abs/1403.2805>. [jqr](https://cran.rstudio.com/web/packages/jqr/index.html) provides bindings for the fast JSON library,
    [jq](http://stedolan.github.io/jq/). [jsonvalidate](https://
    cran.rstudio.com/web/packages/jsonvalidate/index.html) ([GitHub](https://github.com/ropensci/jsonvalidate) ) validates JSON against a schema using
    the “is-my-json-valid” Javascript library; [ajv](https://cran.rstudio.com/
    web/packages/ajv/index.html) does the same using the ajv Javascript
    library. [ndjson](https://cran.rstudio.com/web/packages/ndjson/index.html)
    ([GitHub](https://gitlab.com/hrbrmstr/ndjson) ) supports the “ndjson”
    format.
  - *RSS/Atom*: [feedeR](https://cran.rstudio.com/web/packages/feedeR/
    index.html) can be used to parse RSS or Atom feeds. [tidyRSS](https://
    cran.rstudio.com/web/packages/tidyRSS/index.html) parses RSS, Atom XML/JSON
    and geoRSS into a tidy data.frame.
  - [swagger](https://cran.rstudio.com/web/packages/swagger/index.html) can be
    used to automatically generate functions for working with an web service API
    that provides documentation in [Swagger.io](https://swagger.io/) format.

**Tools for Working with URLs**

  - The `httr::parse_url()` function can be used to extract portions of a URL.
    The `RCurl::URLencode()` and `utils::URLencode()` functions can be used to
    encode character strings for use in URLs. `utils::URLdecode()` decodes back
    to the original strings. [urltools](https://cran.rstudio.com/web/packages/
    urltools/index.html) ([GitHub](https://github.com/Ironholds/urltools) ) can
    also handle URL encoding, decoding, parsing, and parameter extraction.
  - [iptools](https://cran.rstudio.com/web/packages/iptools/index.html) can
    facilitate working with IPv4 addresses, including for use in geolocation. A
    similar package [ipaddress](https://cran.rstudio.com/web/packages/ipaddress/
      index.html), handles IPv4 and IPv6 addresses and networks.
  - [urlshorteneR](https://cran.rstudio.com/web/packages/urlshorteneR/
    index.html) offers URL expansion and analysis for Bit.ly, Goo.gl, and is.gd.
    [longurl](https://cran.rstudio.com/web/packages/longurl/index.html) uses the
    longurl.org API to provide similar functionality.
  - [gdns](https://cran.rstudio.com/web/packages/gdns/index.html) provides
    access to Google’s secure HTTP-based DNS resolution service.

**Tools for Working with Scraped Webpage Contents**

  - Several packages can be used for parsing HTML documents.
  [boilerpipeR](https://cran.rstudio.com/web/packages/boilerpipeR/index.html)
  provides generic extraction of main text content from HTML files; removal of
  ads, sidebars and headers using the boilerpipe Java library. [<span
  class="Ohat">RTidyHTML</span>](http://www.Omegahat.net/RTidyHTML/) interfaces
  to the libtidy library for correcting HTML documents that are not well-
  formed. This library corrects common errors in HTML documents.
  [W3CMarkupValidator](https://cran.rstudio.com/web/packages/W3CMarkupValidator/
  index.html) provides an R Interface to W3C Markup Validation Services for
  validating HTML documents.
  - For XML documents, the [<span class="Ohat">XMLSchema</span>](http://
    www.Omegahat.net/XMLSchema/) package provides facilities in R for reading
    XML schema documents and processing them to create definitions for R
    classes and functions for converting XML nodes to instances of those
    classes. It provides the framework for meta-computing with XML schema in R.
    [xslt](https://cran.rstudio.com/web/packages/xslt/index.html) is an
    extension for the [xml2](https://cran.rstudio.com/web/packages/xml2/index.html) package to transform XML documents by applying an xslt style-
    sheet. (It can be seen as a modern replacement for [<span
    class="Ohat">Sxslt</span>](http://www.Omegahat.net/Sxslt/), which is an
    interface to Dan Veillard’s libxslt translator, and the [<span
    class="Ohat">SXalan</span>](http://www.Omegahat.net/SXalan/) package.) This
    may be useful for webscraping, as well as transforming XML markup into
    another human- or machine-readable format (e.g., HTML, JSON, plain text,
    etc.). [<span class="Ohat">SSOAP</span>](http://www.Omegahat.net/SSOAP/)
    provides a client-side SOAP (Simple Object Access Protocol) mechanism.
    Beware, SSOAP itself may not install, and/or its dependencies. The best bet
    is to get the web service maintainers to switch to REST. [<span
    class="Ohat">XMLRPC</span>](http://www.Omegahat.net/XMLRPC/) provides an
    implementation of XML-RPC, a relatively simple remote procedure call
    mechanism that uses HTTP and XML. This can be used for
    communicating between processes on a single machine or for accessing Web
    services from within R.
  - [<span class="Ohat">Rcompression</span>](http://www.Omegahat.net/
    Rcompression/) (not on CRAN): Interface to zlib and bzip2 libraries for
    performing in-memory compression and decompression in R. This is useful when
    receiving or sending contents to remote servers, e.g. Web services, HTTP
    requests via RCurl.
  - [tm.plugin.webmining](https://cran.rstudio.com/web/packages/
    tm.plugin.webmining/index.html): Extensible text retrieval framework for
    news feeds in XML (RSS, ATOM) and JSON formats. Currently, the following
    feeds are implemented: Google Blog Search, Google Finance, Google News,
    NYTimes Article Search, Reuters News Feed, Yahoo Finance and Yahoo Inplay.
  - [webshot](https://cran.rstudio.com/web/packages/webshot/index.html) uses
    [PhantomJS](https://phantomjs.org/) to provide screenshots of web pages
    without a browser. It can be useful for testing websites (such as Shiny
    applications).

**Security**

  - [securitytxt](https://cran.rstudio.com/web/packages/securitytxt/index.html)
    identifies and parses web Security policy files.

**Other Useful Packages and Functions**

  - *Javascript*: [V8](https://cran.rstudio.com/web/packages/V8/index.html) is
    an R interface to Google’s open source, high performance JavaScript engine.
    It can wrap Javascript libraries as well as NPM packages. The [<span
    class="Ohat">SpiderMonkey</span>](http://www.Omegahat.net/SpiderMonkey/)
    package provides another means of evaluating JavaScript code, creating
    JavaScript objects and calling JavaScript functions and methods from within
    R. This can work by embedding the JavaScript engine within an R session or
    by embedding R in an browser such as Firefox and being able to call R from
    JavaScript and call back to JavaScript from R. The [js](https://
    cran.rstudio.com/web/packages/js/index.html) package wraps [V8](https://
    cran.rstudio.com/web/packages/V8/index.html) and validates, reformats,
    optimizes and analyzes JavaScript code.
  - *Email:*: [mailR](https://cran.rstudio.com/web/packages/mailR/index.html)
    is an interface to Apache Commons Email to send emails from within R.
    [sendmailR](https://cran.rstudio.com/web/packages/sendmailR/index.html)
    provides a simple SMTP client. [gmailr](https://cran.rstudio.com/web/
    packages/gmailr/index.html) provides access the Google’s gmail.com RESTful
    API.
    [Microsoft365R](https://cran.rstudio.com/web/packages/Microsoft365R/
    index.html) provides a client for Microsoft’s Outlook email service, both
    personal (outlook.com) and as part of the Microsoft 365 (formerly known as
    Office 365) suite.
  - *Mocking:*: [webmockr](https://cran.rstudio.com/web/packages/webmockr/
    index.html) is a library for stubbing and setting expectations on HTTP
    requests. It is inspired from Rubys `webmock`. This package only helps mock
    HTTP requests, and returns nothing when requests match expectations.
    webmockr integrates with the HTTP packages [crul](https://cran.rstudio.com/web/packages/crul/index.html) and [httr](https://cran.rstudio.com/web/packages/httr/index.html). See *Testing* for mocking with returned
    responses.
  - *Testing:*: [vcr](https://cran.rstudio.com/web/packages/vcr/index.html)
    provides an interface to easily cache HTTP requests in R package test suites
    (but can be used outside of testing use cases as well). vcr relies on
    [webmockr](https://cran.rstudio.com/web/packages/webmockr/index.html) to do
    the HTTP request mocking. vcr integrates with the HTTP packages
    [crul](https://cran.rstudio.com/web/packages/crul/index.html) and
    [httr](https://cran.rstudio.com/web/packages/httr/index.html).
    [httptest](https://cran.rstudio.com/web/packages/httptest/index.html)
    provides a framework for testing packages that communicate with HTTP APIs,
    offering tools for mocking APIs, for recording real API responses for use
    as mocks, and for making assertions about HTTP requests, all without
    requiring a live connection to the API server at runtime. httptest only
    works with httr.
  - *Miscellaneous*: [webutils](https://cran.rstudio.com/web/packages/webutils/
    index.html) contains various functions for developing web applications,
    including parsers for `application/x-www-form-urlencoded` as well as
    `multipart/form-data`. [mime](https://cran.rstudio.com/web/packages/mime/
    index.html) ([GitHub](https://github.com/yihui/mime) ) guesses the MIME type
    for a file from its extension. [rsdmx](https://cran.rstudio.com/web/
    packages/
    rsdmx/index.html) provides tools to read data and metadata documents
    exchanged through the Statistical Data and Metadata Exchange (SDMX)
    framework. The package currently focuses on the SDMX XML standard format
    (SDMX-ML). [robotstxt](https://cran.rstudio.com/web/packages/robotstxt/
    index.html) provides functions and classes for parsing robots.txt files and
    checking access permissions; [spiderbar](https://cran.rstudio.com/web/
    packages/spiderbar/index.html) does the same. [uaparserjs](https://
    cran.rstudio.com/web/packages/uaparserjs/index.html) ([GitHub](https://
    github.com/hrbrmstr/uaparserjs) ) uses the javascript [“ua-parser”
    library](https://github.com/ua-parser) to parse User-Agent HTTP headers.
    [rapiclient](https://cran.rstudio.com/web/packages/rapiclient/index.html) is
    a client for consuming APIs that follow the [Open API format](https://
    www.openapis.org/). [restfulr](https://cran.rstudio.com/web/packages/
    restfulr/index.html) models a RESTful service as if it were a nested R list.

## Web and Server Frameworks

  - [Model Operationalization](https://docs.microsoft.com/en-us/machine-
    learning-server/what-is-operationalization) (previously DeployR) is a Microsoft product that provides support for deploying R and Python models and code to a server as a web service to later consume.
  - The [shiny](https://cran.rstudio.com/web/packages/shiny/index.html) package
    makes it easy to build interactive web applications with R.
  - [dash](https://cran.rstudio.com/web/packages/dash/index.html) is a web
    framework which is available for Python, R and Julia, with components
    written in React.js.
  - Other web frameworks include: [fiery](https://cran.rstudio.com/web/packages/
    fiery/index.html) that is meant to be more flexible but less easy to use
    than shiny ([reqres](https://cran.rstudio.com/web/packages/reqres/
    index.html) and [routr](https://cran.rstudio.com/web/packages/routr/
    index.html) are utilities used by fiery that provide HTTP request and
    response classes, and HTTP routing, respectively); [<span
    class="GitHub">rcloud</span>](https://github.com/att/rcloud/) provides an
    iPython notebook-style web-based R interface; and [Rook](https://
    cran.rstudio.com/web/packages/Rook/index.html), which contains the
    specification and convenience software for building and running Rook
    applications.
  - The [opencpu](https://cran.rstudio.com/web/packages/opencpu/index.html)
    framework for embedded statistical computation and reproducible research exposes a web API interfacing R, LaTeX and Pandoc. This API is used for example to integrate statistical functionality into systems, share and execute scripts or reports on centralized servers, and build R based apps.
  - Several general purpose server/client frameworks for R exist.
    [Rserve](https://cran.rstudio.com/web/packages/Rserve/index.html) and
    [RSclient](https://cran.rstudio.com/web/packages/RSclient/index.html)
    provide server and client functionality for TCP/IP or local socket
    interfaces. [httpuv](https://cran.rstudio.com/web/packages/httpuv/
    index.html) provides a low-level socket and protocol support for handling
    HTTP and WebSocket requests directly within R. Another related package,
    perhaps which [httpuv](https://cran.rstudio.com/web/packages/httpuv/
    index.html) replaces, is [websockets](https://cran.rstudio.com/src/contrib/
    Archive/websockets/). [servr](https://cran.rstudio.com/web/packages/servr/
    index.html) provides a simple HTTP server to serve files under a given
    directory based on httpuv.
  - Several packages offer functionality for turning R code into a web API.
    [FastRWeb](https://cran.rstudio.com/web/packages/FastRWeb/index.html)
    provides some basic infrastructure for this. [plumber](https://
    cran.rstudio.com/web/packages/plumber/index.html) allows you to create a REST API by decorating existing R source code.
  - The [<span class="Ohat">WADL</span>](http://www.Omegahat.net/WADL/) package
    provides tools to process Web Application Description Language (WADL) documents and to programmatically generate R functions to interface to the REST methods described in those WADL documents. (not on CRAN)
  - The [<span class="Ohat">RDCOMServer</span>](http://www.Omegahat.net/
    RDCOMServer/) provides a mechanism to export R objects as (D)COM objects in Windows. It can be used along with the [<span class="Ohat">RDCOMClient</span>](http://www.Omegahat.net/RDCOMClient/) package which provides user-level access from R to other COM servers. (not on CRAN)
  - [rapporter.net](http://rapporter.net/welcome/en) provides an online
    environment (SaaS) to host and run [rapport](https://cran.rstudio.com/web/packages/rapport/index.html) statistical report templates in the cloud.
  - [radiant](https://cran.rstudio.com/web/packages/radiant/index.html)
    ([GitHub](https://github.com/radiant-rstats/radiant) ) is Shiny-based GUI for R that runs in a browser from a server or local machine.
  - The [Tiki](https://info.tiki.org/tiki-index.php) Wiki CMS/Groupware
    framework has an R plugin ([PluginR](https://doc.tiki.org/PluginR) ) to run R code from wiki pages, and use data from their own collected web databases (trackers). A demo: <https://r.tiki.org/tiki-index.php> .
  - The [MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) has an extension
    ([Extension:R](https://www.mediawiki.org/wiki/Extension:R) ) to run R code from wiki pages, and use uploaded data. A mailing list used to be available: R-sig-mediawiki.
  - [whisker](https://cran.rstudio.com/web/packages/whisker/index.html):
    Implementation of logicless templating based on [Mustache](http://mustache.github.io/) in R. Mustache syntax is described in <http://mustache.github.io/mustache.5.html>
  - [<span class="Ohat">CGIwithR</span>](http://www.Omegahat.net/CGIwithR/)
    (not on CRAN) allows one to use R scripts as CGI programs for generating
    dynamic Web content. HTML forms and other mechanisms to submit dynamic
    requests can be used to provide input to R scripts via the Web to create
    content that is determined within that R script.

## Web Services

**Cloud Computing and Storage**

  - [The cloudyr project](https://cloudyr.github.io/) aims to provide
    interfaces to popular Amazon, Azure and Google cloud services without the need for external system dependencies.
  - Amazon Web Services is a popular, proprietary cloud service offering a
    suite of computing, storage, and infrastructure tools. [aws.signature](https://cran.rstudio.com/web/packages/aws.signature/index.html) provides functionality for generating AWS API request signatures.
      - *Elastic Cloud Compute (EC2)* is a cloud computing service. [<span
        class="Gcode">segue</span>](https://code.google.com/p/segue/) (not on CRAN) is a package for managing EC2 instances and S3 storage, which includes a parallel version of `lapply()` for the Elastic Map Reduce (EMR) engine called `emrlapply()`. It uses Hadoop Streaming on Amazon’s EMR in order to get simple parallel computation.
      - *DBREST*: [<span class="Ohat">RAmazonDBREST</span>](http://
        www.Omegahat.net/RAmazonDBREST/) provides an interface to Amazon’s Simple DB API.
      - [paws](https://cran.rstudio.com/web/packages/paws/index.html)
        ([GitHub](https://github.com/paws-r/paws) ) is an interface to nearly all AWS APIs, including compute, storage, databases, and machine learning. It also requires no external system dependencies.
  - Azure and Microsoft 365 are Microsoft’s cloud computing services. The Azure
    platform provides Paas, SaaS and IaaS and supports many different tools and
    frameworks, including both Microsoft-specific and third-party systems;
    while Microsoft 365 is a unified framework for accessing cloud data from
    Microsoft’s Office services, Windows and Dynamics. The [AzureR package
    family](https://github.com/Azure/AzureR) aims to provide a suite of
    lightweight, powerful tools for working with Azure in R. The packages
    listed below are part of the family, and are also mirrored at the cloudyr
    project.
      - *Azure Active Directory (AAD)* is a centralized directory and identity
        service. [AzureAuth](https://cran.rstudio.com/web/packages/AzureAuth/
        index.html) is an R client for AAD; use this to obtain OAuth tokens for
        authenticating with other Azure services, including Resource Manager
        and storage (see next).
      - *Microsoft Graph* is the API framework for the Microsoft 365 platform,
        including Azure Active Directory and Office. [AzureGraph](https://
        cran.rstudio.com/web/packages/AzureGraph/index.html) is a low-level
        extensible R6-based interface to Graph. [Microsoft365R](https://
        cran.rstudio.com/web/packages/Microsoft365R/index.html) is an interface
        to the Office part of Microsoft 365, including OneDrive and SharePoint
        Online.
      - *Azure Resource Manager (ARM)* is a service for deploying other Azure
        services. [AzureRMR](https://cran.rstudio.com/web/packages/AzureRMR/
        index.html) is an R interface to ARM, and allows managing
        subscriptions, resource groups, resources and templates. It exposes a
        general R6 class framework that can extended to provide extra
        functionality for specific services (see next).
      - *Azure Storage Accounts* are a general-purpose data storage facility.
        Different types of storage are available: file, blob, table, Data Lake,
        and more. [AzureStor](https://cran.rstudio.com/web/packages/AzureStor/
        index.html) provides an R interface to storage. Features include
        clients for file, blob and Data Lake Gen2 storage, parallelized file
        transfers, and an interface to Microsoft’s cross-platform AzCopy
        command line utility. Also supplied is an ARM interface, to allow
        creation and managing of storage accounts. [AzureTableStor](https://
        cran.rstudio.com/web/packages/AzureTableStor/index.html) and
        [AzureQstor](https://cran.rstudio.com/web/packages/AzureQstor/
        index.html) extend AzureStor to provide interfaces to table storage and
        queue storage respectively
      - [AzureVM](https://cran.rstudio.com/web/packages/AzureVM/index.html) is
        a package for creating and managing virtual machines in Azure. It
        includes templates for a wide variety of common VM specifications and
        operating systems, including Windows, Ubuntu, Debian and RHEL.
      - [AzureContainers](https://cran.rstudio.com/web/packages/AzureContainers/
        index.html) provides a unified facility for working with containers in
        Azure. Specifically, it includes R interfaces to *Azure Container
        Instances (ACI)*, *Azure Docker Registry (ACR)* and *Azure Kubernetes
        Service (AKS)*. Create Docker images and push them to an ACR
        repository; spin up ACI containers; deploy Kubernetes services in AKS.
      - *Azure Data Explorer*, also known as *Kusto*, is a fast, scalable
        data exploration and analytics service. [AzureKusto](https://
        cran.rstudio.com/web/packages/AzureKusto/index.html) is an R interface
        to ADE/Kusto. It includes a dplyr client interface similar to that
        provided by dbplyr for SQL databases, a DBI client interface, and an
        ARM interface for deploying and managing Kusto clusters and databases.
      - *Azure Cosmos DB* is a multi-model NoSQL database service, previously
        known as Document DB. [AzureCosmosR](https://cran.rstudio.com/web/
        packages/AzureCosmosR/index.html) is an interface to the core/SQL API
        for Cosmos DB. It also includes simple bridges to the table storage and
        MongoDB APIs.
      - *Azure Computer Vision* and *Azure Custom Vision* are AI services for
        image recognition and analysis. Computer Vision is a pre-trained
        service for handling commonly-encountered tasks, while Custom Vision
        allows you to train your own image recognition model on a custom
        dataset. [AzureVision](https://cran.rstudio.com/web/packages/
        AzureVision/index.html) provides an interface to both these services.
  - [googleComputeEngineR](https://cran.rstudio.com/web/packages/
    googleComputeEngineR/index.html) interacts with the Google Compute Engine API, and lets you create, start and stop instances in the Google Cloud.
  - *Cloud Storage*: [googleCloudStorageR](https://cran.rstudio.com/web/
    packages/googleCloudStorageR/index.html) interfaces with Google Cloud
    Storage. [boxr](https://cran.rstudio.com/web/packages/boxr/index.html)
    ([GitHub](https://github.com/r-box/boxr) ) is a lightweight, high-level
    interface for the [box.com API](https://developer.box.com/reference/) .
    [rdrop2](https://cran.rstudio.com/web/packages/rdrop2/index.html) is a
    Dropbox interface that provides access to a full suite of file operations,
    including dir/copy/move/delete operations, account information (including
    quotas) and the ability to upload and download files from any Dropbox
    account.
  - *Docker*: [analogsea](https://cran.rstudio.com/web/packages/analogsea/
    index.html) is a general purpose client for the Digital Ocean v2 API. In
    addition, the package includes functions to install various R tools
    including base R, RStudio server, and more. There’s an improving interface
    to interact with docker on your remote droplets via this package.
  - [crunch](https://cran.rstudio.com/web/packages/crunch/index.html)
    [GitHub](https://github.com/Crunch-io/rcrunch) provides an interface to the
    [crunch.io](https://crunch.io/) storage and analytics platform.
    [crunchy](https://cran.rstudio.com/web/packages/crunchy/index.html)
    [GitHub](https://github.com/Crunch-io/crunchy) facilitates making Shiny
    apps on Crunch.
  - [rrefine](https://cran.rstudio.com/web/packages/rrefine/index.html)
    provides a client for the [OpenRefine](https://openrefine.org/) (formerly Google Refine) data cleaning service.

**Document and Code Sharing**

  - *Code Sharing*: [gistr](https://cran.rstudio.com/web/packages/gistr/
    index.html) ([GitHub](https://github.com/ropensci/gistr) ) works with
    GitHub gists ([gist.github.com](https://gist.github.com/discover) ) from R,
    allowing you to create new gists, update gists with new files, rename
    files, delete files, get and delete gists, star and un-star gists, fork
    gists, open a gist in your default browser, get embed code for a gist, list
    gist commits, and get rate limit information when authenticated.
    [git2r](https://cran.rstudio.com/web/packages/git2r/index.html) provides
    bindings to the git version control system and [gh](https://
    cran.rstudio.com/web/packages/gh/index.html) is a client for the GitHub
    API. [gitlabr](https://cran.rstudio.com/web/packages/gitlabr/index.html) is
    a [GitLab](https://about.gitlab.com/) -specific client.
  - *Data archiving*: [dataverse](https://cran.rstudio.com/web/packages/
    dataverse/index.html) ([GitHub](https://github.com/iqss/dataverse-client-r)
    ) provides access to Dataverse 4 APIs. [rfigshare](https://cran.rstudio.com/
    web/packages/rfigshare/index.html) ([GitHub](https://github.com/ropensci/
    rfigshare) ) connects with [Figshare.com](https://figshare.com/) .
    [dataone](https://cran.rstudio.com/web/packages/dataone/index.html)
    ([GitHub](https://github.com/DataONEorg/rdataone) ) provides a client for
    [DataONE](https://www.dataone.org/) repositories.
  - *Google Drive/Google Documents*: The [<span class="Ohat">RGoogleDocs</
    span>](http://www.Omegahat.net/RGoogleDocs/) package is an example of using
    the RCurl and XML packages to quickly develop an interface to the Google
    Documents API. [<span class="Ohat">RGoogleStorage</span>](http://
    www.Omegahat.net/RGoogleStorage/) provides programmatic access to the
    Google Storage API. This allows R users to access and store data on
    Google’s storage. We can upload and download content, create, list and
    delete folders/buckets, and set access control permissions on objects and
    buckets.
  - *Google Sheets*: [googlesheets](https://cran.rstudio.com/web/packages/
    googlesheets/index.html) ([GitHub](https://github.com/jennybc/googlesheets)
    ) can access private or public Google Sheets by title, key, or URL. Extract
    data or edit data. Create, delete, rename, copy, upload, or download
    spreadsheets and worksheets. [gsheet](https://cran.rstudio.com/web/packages/
    gsheet/index.html) ([GitHub](https://github.com/maxconway/gsheet) ) can
    download Google Sheets using just the sharing link. Spreadsheets can be
    downloaded as a data frame, or as plain text to parse manually.
  - [imguR](https://cran.rstudio.com/web/packages/imguR/index.html)   
    ([GitHub](https://github.com/cloudyr/imguR) ) is a package to share plots
    using the image hosting service [Imgur.com](https://imgur.com/). knitr
    also has a function `imgur_upload()` to load images from literate
    programming documents.
  - *Teams*, *SharePoint* and *OneDrive*: [Microsoft365R](https://
    cran.rstudio.com/web/packages/Microsoft365R/index.html) provides an
    interface to these services, which form part of the Microsoft 365 (formerly
    known as Office 365) suite.

**Data Analysis and Processing Services**

  - *Geospatial/Geolocation/Geocoding*: Several packages connect to geolocation/
    geocoding services. [rgeolocate](https://cran.rstudio.com/web/packages/
    rgeolocate/index.html) ([GitHub](https://github.com/ironholds/rgeolocate) )
    offers several online and offline tools. [<span class="GitHub">rydn</
    span>](https://github.com/trestletech/rydn/) (not on CRAN) is an interface
    to the Yahoo Developers network geolocation APIs, and [<span
    class="GitHub">ipapi</span>](https://github.com/hrbrmstr/ipapi/) can be
    used to geolocate IPv4/6 addresses and/or domain names using the <http://ip-
    api.com/> API. [opencage](https://cran.rstudio.com/web/packages/opencage/
    index.html) ([GitHub](https://github.com/ropensci/opencage) ) provides
    access to to the [OpenCage](https://opencagedata.com/) geocoding service.
    [<span class="GitHub">nominatim</span>](https://github.com/hrbrmstr/
    nominatim/) (not on CRAN) connects to the [OpenStreetMap Nominatim
    API](https://github.com/hrbrmstr/nominatim) for reverse geocoding. [<span
    class="GitHub">PostcodesioR</span>](https://github.com/ropensci/
    PostcodesioR/) (not on CRAN) provides post code lookup and geocoding for
    the United Kingdom. [geosapi](https://cran.rstudio.com/web/packages/geosapi/
    index.html) is an R client for the [GeoServer](http://geoserver.org/) REST
    API, an open source implementation used widely for serving spatial data.
    [geonapi](https://cran.rstudio.com/web/packages/geonapi/index.html)
    provides an interface to the [GeoNetwork](https://geonetwork-opensource.org/
    ) legacy API, an opensource catalogue for managing geographic metadata.
    [ows4R](https://cran.rstudio.com/web/packages/ows4R/index.html) is a new R
    client for the [OGC](https://www.ogc.org/standards/) standard Web-Services,
    such Web Feature Service (WFS) for data and Catalogue Service (CSW) for
    metadata.
  - *Machine Learning as a Service*: Several packages provide access to cloud-
    based machine learning services. [OpenML](https://cran.rstudio.com/web/
    packages/OpenML/index.html) ([GitHub](https://github.com/openml/openml-r) )
    is the official client for [the OpenML API](https://www.openml.org/frontend/
    page/home). [clarifai](https://cran.rstudio.com/web/packages/clarifai/
    index.html) ([GitHub](https://github.com/soodoku/clarifai) ) is a
    [Clarifai.com](https://www.clarifai.com/) client that enables automated
    image description. [rLTP](https://cran.rstudio.com/web/packages/rLTP/
    index.html) ([GitHub](https://github.com/hetong007/rLTP) ) accesses the
    [ltp-cloud service](https://www.ltp-cloud.com/). [languagelayeR](https://
    cran.rstudio.com/web/packages/languagelayeR/index.html) is a client for
    Languagelayer, a language detection API. [googlepredictionapi](https://
    code.google.com/archive/p/google-prediction-api-r-client/) (not on CRAN):
    is an R client for the [Google Prediction API](https://cloud.google.com/ai-
    platform), a suite of cloud machine learning tools. [yhatr](https://
    cran.rstudio.com/web/packages/yhatr/index.html) lets you deploy, maintain,
    and invoke models via the Yhat REST API. [datarobot](https://
    cran.rstudio.com/web/packages/datarobot/index.html) works with Data Robot’s
    predictive modeling platform. [mscsweblm4r](https://cran.rstudio.com/web/
    packages/mscsweblm4r/index.html) ([GitHub](https://github.com/philferriere/
    mscsweblm4r) ) interfaces with the Microsoft Cognitive Services Web
    Language Model API and [mscstexta4r](https://cran.rstudio.com/web/packages/
    mscstexta4r/index.html) ([GitHub](https://github.com/philferriere/
    mscstexta4r) ) uses the Microsoft Cognitive Services Text Analytics REST
    API. [rosetteApi](https://cran.rstudio.com/web/packages/rosetteApi/
    index.html) links to the [Rosette](https://developer.rosette.com/) text
    analysis API. [googleLanguageR](https://cran.rstudio.com/web/packages/
    googleLanguageR/index.html) provides interfaces to Google’s Cloud
    Translation API, Natural Language API, Cloud Speech API, and the Cloud Text-
    to-Speech API. [AzureVision](https://cran.rstudio.com/web/packages/
    AzureVision/index.html) provides interfaces to the Azure Computer Vision
    and Custom Vision image recognition services.
  - *Machine Translation*: [translate](https://cran.rstudio.com/web/packages/
    translate/index.html) provides bindings for the Google Translate API v2 and
    [translateR](https://cran.rstudio.com/web/packages/translateR/index.html)
    provides bindings for both Google and Microsoft translation APIs.
    [RYandexTranslate](https://cran.rstudio.com/web/packages/RYandexTranslate/
    index.html) ([GitHub](https://github.com/mukul13/RYandexTranslate) )
    connects to Yandex Translate. [transcribeR](https://cran.rstudio.com/web/
    packages/transcribeR/index.html) provides automated audio transcription via
    the HP IDOL service.
  - *Document Processing*: [abbyyR](https://cran.rstudio.com/web/packages/
    abbyyR/index.html) [GitHub](https://github.com/soodoku/abbyyR) and
    [captr](https://cran.rstudio.com/web/packages/captr/index.html)
    ([GitHub](https://github.com/soodoku/captr) ) connect to optical character
    recognition (OCR) APIs. [pdftables](https://cran.rstudio.com/web/packages/
    pdftables/index.html) ([GitHub](https://github.com/expersso/pdftables) )
    uses [the PDFTables.com webservice](https://pdftables.com/) to extract
    tables from PDFs.
  - *Mapping*: [osmar](https://cran.rstudio.com/web/packages/osmar/index.html)
    provides infrastructure to access OpenStreetMap data from different sources
    to work with the data in common R manner and to convert data into available
    infrastructure provided by existing R packages (e.g., into sp and igraph
    objects). [osrm](https://cran.rstudio.com/web/packages/osrm/index.html)
    provides shortest paths and travel times from OpenStreetMap.
    [osmplotr](https://cran.rstudio.com/web/packages/osmplotr/index.html)
    ([GitHub](https://github.com/ropensci/osmplotr) ) extracts customizable map
    images from OpenStreetMap. [RgoogleMaps](https://cran.rstudio.com/web/
    packages/RgoogleMaps/index.html) serves two purposes: it provides a
    comfortable R interface to query the Google server for static maps, and use
    the map as a background image to overlay plots within R. [<span
    class="Ohat">R2GoogleMaps</span>](http://www.Omegahat.net/R2GoogleMaps/)
    provides a mechanism to generate JavaScript code from R that displays data
    using Google Maps. [<span class="Ohat">RKMLDevice</span>](http://
    www.Omegahat.net/RKMLDevice/) allows to create R graphics in Keyhole Markup
    Language (KML) format in a manner that allows them to be displayed on
    Google Earth (or Google Maps), and [<span class="Ohat">RKML</span>](http://
    www.Omegahat.net/RKML/) provides users with high-level facilities to
    generate KML. [plotKML](https://cran.rstudio.com/web/packages/plotKML/
    index.html) can visualization spatial and spatio-temporal objects in Google
    Earth. [ggmap](https://cran.rstudio.com/web/packages/ggmap/index.html)
    allows for the easy visualization of spatial data and models on top of
    Google Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2.
    [mapsapi](https://cran.rstudio.com/web/packages/mapsapi/index.html) is an
    sf-compatible interface to Google Maps API. [leafletR](https://
    cran.rstudio.com/web/packages/leafletR/index.html): Allows you to display
    your spatial data on interactive web-maps using the open-source JavaScript
    library Leaflet. [openadds](https://cran.rstudio.com/web/packages/openadds/
    index.html) ([GitHub](https://github.com/sckott/openadds) ) is an
    [Openaddresses](https://openaddresses.io/) client, and [banR](https://
    cran.rstudio.com/web/packages/banR/index.html) provides access to the “Base Adresses Nationale” (BAN) API for French addresses.
  - *Online Surveys*: [qualtRics](https://cran.rstudio.com/web/packages/
    qualtRics/index.html) provide functions to interact with [Qualtrics](https:/
    /www.qualtrics.com/). [WufooR](https://cran.rstudio.com/web/packages/
    WufooR/index.html) ([GitHub](https://github.com/dmpe/wufoor) ) can retrieve
    data from [Wufoo.com](https://www.wufoo.com/) forms. [redcapAPI](https://
    cran.rstudio.com/web/packages/redcapAPI/index.html) ([GitHub](https://
    github.com/nutterb/redcapAPI) ) can provide access to data stored in a
    REDCap (Research Electronic Data CAPture) database, which is a web
    application for building and managing online surveys and databases
    developed at Vanderbilt University. [<span class="GitHub">formr</
    span>](https://github.com/rubenarslan/formr/) facilitates use of the
    [formr](https://formr.org/) survey framework, which is built on openCPU.
    [Rexperigen](https://cran.rstudio.com/web/packages/Rexperigen/index.html)
    is a client for the [Experigen experimental platform](https://
    becker.phonologist.org/experigen/) .
  - *Visualization*: Plot.ly is a company that allows you to create
    visualizations in the web using R (and Python), which is accessible via
    [plotly](https://cran.rstudio.com/web/packages/plotly/index.html).
    [googleVis](https://cran.rstudio.com/web/packages/googleVis/index.html)
    provides an interface between R and the Google chart tools. The [<span
    class="Ohat">RUbigraph</span>](http://www.Omegahat.net/RUbigraph/) package
    provides an R interface to a Ubigraph server for drawing interactive,
    dynamic graphs. You can add and remove vertices/nodes and edges in a graph
    and change their attributes/characteristics such as shape, color, size.
  - *Other* :
      - [rrefine](https://cran.rstudio.com/web/packages/rrefine/index.html) can
        import to and export from the [OpenRefine](https://openrefine.org/) data cleaning service.

**Social Media Clients**

  - [Rfacebook](https://cran.rstudio.com/web/packages/Rfacebook/index.html)   
    provide an interface to the Facebook API.
  - The [<span class="Ohat">Rflickr</span>](http://www.Omegahat.net/Rflickr/)   
    package provides an interface to the Flickr photo management and sharing
    application Web service. (not on CRAN)
  - [instaR](https://cran.rstudio.com/web/packages/instaR/index.html)
    ([GitHub](https://github.com/pablobarbera/instaR) ) is a client for the [Instagram API](https://www.instagram.com/developer/) .
  - [Rlinkedin](https://cran.rstudio.com/web/packages/Rlinkedin/index.html) is
    a client for the LinkedIn API. Auth is via OAuth.
  - [rpinterest](https://cran.rstudio.com/web/packages/rpinterest/index.html)
    connects to the [Pintrest](https://www.pinterest.com/) API.
  - [vkR](https://cran.rstudio.com/web/packages/vkR/index.html) is a client for
    VK, a social networking site based in Russia.
  - [<span class="GitHub">meetupr</span>](https://github.com/rladies/meetupr/)
    is a client for the Meetup.com API.
  - *Twitter*: [twitteR](https://cran.rstudio.com/web/packages/twitteR/
    index.html) ([GitHub](https://github.com/geoffjentry/twitteR) ) provides an
    interface to the Twitter web API. It claims to be deprecated in favor of
    [rtweet](https://cran.rstudio.com/web/packages/rtweet/index.html)
    ([GitHub](https://github.com/ropensci/rtweet) ). [<span
    class="GitHub">twitterreport</span>](https://github.com/gvegayon/
    twitterreport/) (not on CRAN) focuses on report generation based on Twitter
    data. [streamR](https://cran.rstudio.com/web/packages/streamR/index.html)
    provides a series of functions that allow users to access Twitter’s filter,
    sample, and user streams, and to parse the output into data frames. OAuth
    authentication is supported. [tweet2r](https://cran.rstudio.com/web/
    packages/tweet2r/index.html) is an alternative implementation geared toward
    SQLite and postGIS databases. [graphTweets](https://cran.rstudio.com/web/
    packages/graphTweets/index.html) produces a network graph from a data.frame
    of tweets. [tweetscores](https://github.com/pablobarbera/twitter_ideology/
    tree/master/pkg/tweetscores) (not on CRAN) implements a political ideology
    scaling measure for specified Twitter users.
  - [brandwatchR](https://cran.rstudio.com/web/packages/brandwatchR/index.html)
    is a package to retrieve a data from the Brandwatch social listening API.
    Both raw text and aggregate statistics are available, as well as project
    and query management functions.
  - [hackeRnews](https://cran.rstudio.com/web/packages/hackeRnews/index.html)
    ([GitHub](https://github.com/szymanskir/hackeRnews) ) is a client for the
    [Official Hacker News API](https://github.com/HackerNews/API) .

**Web Analytics Services**

  - *Google Trends*: [gtrendsR](https://cran.rstudio.com/web/packages/gtrendsR/
    index.html) offers functions to perform and display Google Trends queries.
    [<span class="Ohat">RGoogleTrends</span>](http://www.Omegahat.net/
    RGoogleTrends/) provides an alternative.
  - *Google Analytics*: [googleAnalyticsR](https://cran.rstudio.com/web/
    packages/googleAnalyticsR/index.html), [ganalytics](https://
    cran.rstudio.com/web/packages/ganalytics/index.html), and [RGA](https://
    cran.rstudio.com/web/packages/RGA/index.html) provide functions for
    accessing and retrieving data from the [Google Analytics APIs](https://
    developers.google.com/analytics/). The latter supports OAuth 2.0
    authorization. [RGA](https://cran.rstudio.com/web/packages/RGA/index.html)
    provides a shiny app to explore data. [searchConsoleR](https://
    cran.rstudio.com/web/packages/searchConsoleR/index.html) links to the
    [Google Search Console](https://developers.google.com/webmaster-tools/)
    (formerly Webmaster Tools).
  - *Online Advertising*: [fbRads](https://cran.rstudio.com/web/packages/fbRads/
    index.html) can manage Facebook ads via the Facebook Marketing API. [<span
    class="GitHub">RDoubleClick</span>](https://github.com/WillemPaling/
    RDoubleClick/) (not on CRAN) can retrieve data from Google’s DoubleClick
    Campaign Manager Reporting API. [RSmartlyIO](https://cran.rstudio.com/web/
    packages/RSmartlyIO/index.html) ([GitHub](https://github.com/rstats-lab/
    RSmartlyIO) ) loads Facebook and Instagram advertising data provided by
    [Smartly.io](https://app.smartly.io/) .
  - *Other services*: [RSiteCatalyst](https://cran.rstudio.com/web/packages/
    RSiteCatalyst/index.html) has functions for accessing the Adobe Analytics
    (Omniture SiteCatalyst) Reporting API.
  - [RAdwords](https://cran.rstudio.com/web/packages/RAdwords/index.html)
    ([GitHub](https://github.com/jburkhardt/RAdwords) ) is a package for
    loading Google Adwords data.
  - [webreadr](https://cran.rstudio.com/web/packages/webreadr/index.html)
    ([GitHub](https://github.com/Ironholds/webreadr) ) can process various
    common forms of request log, including the Common and Combined Web Log
    formats and AWS logs.

**Web Services for R Package Development**

  - R-Hub <http://log.r-hub.io/> is a project to enable package builds across
    all architectures. [rhub](https://cran.rstudio.com/web/packages/rhub/
    index.html) is a package that interfaces with R-Hub to allow you to check a
    package on the platform.

**Other Web Services**

  - *Push Notifications*: [RPushbullet](https://cran.rstudio.com/web/packages/  
    RPushbullet/index.html) provides an easy-to-use interface for the
    Pushbullet service which provides fast and efficient notifications between
    computers, phones and tablets. [pushoverr](https://cran.rstudio.com/web/
    packages/pushoverr/index.html) ([GitHub](https://github.com/briandconnelly/
    pushoverr) ) can sending push notifications to mobile devices (iOS and
    Android) and desktop using [Pushover](https://pushover.net/) .
    [notifyme](https://cran.rstudio.com/web/packages/notifyme/index.html)
    ([GitHub](https://github.com/epijim/notifyme) ) can control Phillips Hue
    lighting.

  - *Reference/bibliography/citation management*: [rorcid](https://
    cran.rstudio.com/web/packages/rorcid/index.html) ([GitHub](https://
    github.com/ropensci/rorcid) ) is a programmatic interface the
    [Orcid.org](https://orcid.org/) API, which can be used for identifying
    scientific authors and their publications (e.g., by DOI).
    [rdatacite](https://cran.rstudio.com/web/packages/rdatacite/index.html)
    connects to [DataCite](https://datacite.org/), which manages DOIs and
    metadata for scholarly datasets. [scholar](https://cran.rstudio.com/web/
    packages/scholar/index.html) provides functions to extract citation data
    from Google Scholar. [rscopus](https://cran.rstudio.com/web/packages/
    rscopus/index.html) provides functions to extract citation data from
    Elsevier Scopus APIs. Convenience functions are also provided for comparing
    multiple scholars and predicting future h-index values. [mathpix](https://
    cran.rstudio.com/web/packages/mathpix/index.html) convert an image of a
    formula (typeset or handwritten) via Mathpix webservice to produce the
    LaTeX code. [zen4R](https://cran.rstudio.com/web/packages/zen4R/index.html)
    provides an Interface to [Zenodo](https://zenodo.org/) REST API, including
    management of depositions, attribution of DOIs by ‘Zenodo’ and upload of
    files.

  - *Literature*: [rplos](https://cran.rstudio.com/web/packages/rplos/
    index.html) is a programmatic interface to the Web Service methods provided
    by the Public Library of Science journals for search. [europepmc](https://
    cran.rstudio.com/web/packages/europepmc/index.html) connects to the Europe
    PubMed Central service. [pubmed.mineR](https://cran.rstudio.com/web/
    packages/pubmed.mineR/index.html) is a package for text mining of [PubMed
    Abstracts](https://pubmed.ncbi.nlm.nih.gov/) that supports fetching text
    and XML from PubMed. [jstor](https://cran.rstudio.com/web/packages/jstor/
    index.html) provides functions and helpers to import metadata, ngrams and
    full-texts from Data for Research service by JSTOR. [aRxiv](https://
    cran.rstudio.com/web/packages/aRxiv/index.html) is a client for the arXiv
    API, a repository of electronic preprints for computer science,
    mathematics, physics, quantitative biology, quantitative finance, and
    statistics. [roadoi](https://cran.rstudio.com/web/packages/roadoi/
    index.html) provides an interface to the [Unpaywall API](https://
    unpaywall.org/products/api) for finding free full-text versions of academic
    papers. [rcoreoa](https://cran.rstudio.com/web/packages/rcoreoa/index.html)
    is an interface to the [CORE API](https://core.ac.uk/docs/), a search
    interface for open access scholarly articles. [rcrossref](https://
    cran.rstudio.com/web/packages/rcrossref/index.html) is an interface to
    Crossref’s API, [crminer](https://cran.rstudio.com/web/packages/crminer/
    index.html) extracts full text from scholarly articles retrieved via
    Crossref’s Text and Data Mining service; [fulltext](https://
    cran.rstudio.com/web/packages/fulltext/index.html) is a general purpose
    package to search for, retrieve and extract full text from scholarly
    articles; and [rromeo](https://cran.rstudio.com/web/packages/rromeo/
    index.html) ([GitHub](https://github.com/ropensci/rromeo) ) is an interface
    to the SHERPA/RoMEO API, a database of scientific journal archival policies
    regarding pre-, post-print, and accepted manuscript.

  - *Automated Metadata Harvesting*: [oai](https://cran.rstudio.com/web/
    packages/oai/index.html) and [OAIHarvester](https://cran.rstudio.com/web/
    packages/OAIHarvester/index.html) harvest metadata using the Open Archives
    Initiative Protocol for Metadata Harvesting (OAI-PMH) standard.

  - *Wikipedia*: [WikipediR](https://cran.rstudio.com/web/packages/WikipediR/
    index.html) ([GitHub](https://github.com/Ironholds/WikipediR) ) is a
    wrapper for the MediaWiki API, aimed particularly at the Wikimedia
    ‘production’ wikis, such as Wikipedia. [WikidataR](https://cran.rstudio.com/
    web/packages/WikidataR/index.html) ([GitHub](https://github.com/Ironholds/
    WikidataR) ) can request data from [Wikidata.org](https://www.wikidata.org/
    wiki/Wikidata:Main_Page), the free knowledgebase. [wikipediatrend](https://
    cran.rstudio.com/web/packages/wikipediatrend/index.html) ([GitHub](https://
    github.com/petermeissner/wikipediatrend) ) provides access to Wikipedia
    page access statistics. [WikidataQueryServiceR](https://cran.rstudio.com/
    web/packages/WikidataQueryServiceR/index.html) is a client for the
    [Wikidata Query Service](https://query.wikidata.org/) .

  - [bigrquery](https://cran.rstudio.com/web/packages/bigrquery/index.html)   
    ([GitHub](https://github.com/r-dbi/bigrquery) ): An interface to Google’s
    bigquery.

  - [discgolf](https://cran.rstudio.com/web/packages/discgolf/index.html)
    ([GitHub](https://github.com/sckott/discgolf) ) provides a client to
    interact with the API for the [Discourse](https://www.discourse.org/) web
    forum platform. The API is for an installed instance of Discourse, not for
    the Discourse site itself.

  - [<span class="GitHub">mockaRoo</span>](https://github.com/stephlocke/
    mockaRoo/) (not on CRAN) uses the [MockaRoo API](https://www.mockaroo.com/
    api/docs) to generate mock or fake data based on an input schema.

  - [randNames](https://cran.rstudio.com/web/packages/randNames/index.html)
    ([GitHub](https://github.com/karthik/randNames) ) generates random names
    and personal identifying information using the <https://randomapi.com/> API.

  - [rerddap](https://cran.rstudio.com/web/packages/rerddap/index.html): A
    generic R client to interact with any ERDDAP instance, which is a special
    case of OPeNDAP ( <https://en.wikipedia.org/wiki/OPeNDAP> ), or *Open-
    source Project for a Network Data Access Protocol*. Allows user to swap
    out the base URL to use any ERDDAP instance.

  - [RStripe](https://cran.rstudio.com/web/packages/RStripe/index.html)
    provides an interface to [Stripe](https://stripe.com/), an online payment
    processor.

  - [slackr](https://cran.rstudio.com/web/packages/slackr/index.html) is a
    client for Slack.com messaging platform.

  - [<span class="GitHub">stackr</span>](https://github.com/dgrtwo/stackr/)
    (not on CRAN): An unofficial wrapper for the read-only features of the
    [Stack Exchange API](https://api.stackexchange.com/) .

  - [<span class="GitHub">useRsnap</span>](https://github.com/nealrichardson/
    useRsnap/) (not on CRAN) provides an interface to the API for
    [Usersnap](https://www.pivotaltracker.com/), a tool for collecting
    feedback from web application users.

  - [duckduckr](https://cran.rstudio.com/web/packages/duckduckr/index.html) is
    an R interface [DuckDuckGo’s Instant Answer API](https://duckduckgo.com/api)

### CRAN packages:

  - [abbyyR](https://cran.rstudio.com/web/packages/abbyyR/index.html)
  - [ajv](https://cran.rstudio.com/web/packages/ajv/index.html)
  - [analogsea](https://cran.rstudio.com/web/packages/analogsea/index.html)
  - [aRxiv](https://cran.rstudio.com/web/packages/aRxiv/index.html)
  - [aws.signature](https://cran.rstudio.com/web/packages/aws.signature/
    index.html)
  - [AzureAuth](https://cran.rstudio.com/web/packages/AzureAuth/index.html)
  - [AzureContainers](https://cran.rstudio.com/web/packages/AzureContainers/
    index.html)
  - [AzureCosmosR](https://cran.rstudio.com/web/packages/AzureCosmosR/
    index.html)
  - [AzureGraph](https://cran.rstudio.com/web/packages/AzureGraph/index.html)
  - [AzureKusto](https://cran.rstudio.com/web/packages/AzureKusto/index.html)
  - [AzureQstor](https://cran.rstudio.com/web/packages/AzureQstor/index.html)
  - [AzureRMR](https://cran.rstudio.com/web/packages/AzureRMR/index.html)
  - [AzureStor](https://cran.rstudio.com/web/packages/AzureStor/index.html)
  - [AzureTableStor](https://cran.rstudio.com/web/packages/AzureTableStor/
    index.html)
  - [AzureVision](https://cran.rstudio.com/web/packages/AzureVision/index.html)
  - [AzureVM](https://cran.rstudio.com/web/packages/AzureVM/index.html)
  - [banR](https://cran.rstudio.com/web/packages/banR/index.html)
  - [bigrquery](https://cran.rstudio.com/web/packages/bigrquery/index.html)
  - [boilerpipeR](https://cran.rstudio.com/web/packages/boilerpipeR/index.html)
  - [boxr](https://cran.rstudio.com/web/packages/boxr/index.html)
  - [brandwatchR](https://cran.rstudio.com/web/packages/brandwatchR/index.html)
  - [captr](https://cran.rstudio.com/web/packages/captr/index.html)
  - [clarifai](https://cran.rstudio.com/web/packages/clarifai/index.html)
  - [crminer](https://cran.rstudio.com/web/packages/crminer/index.html)
  - [crul](https://cran.rstudio.com/web/packages/crul/index.html) (core)
  - [crunch](https://cran.rstudio.com/web/packages/crunch/index.html)
  - [crunchy](https://cran.rstudio.com/web/packages/crunchy/index.html)
  - [curl](https://cran.rstudio.com/web/packages/curl/index.html) (core)
  - [dash](https://cran.rstudio.com/web/packages/dash/index.html)
  - [dataone](https://cran.rstudio.com/web/packages/dataone/index.html)
  - [datarobot](https://cran.rstudio.com/web/packages/datarobot/index.html)
  - [dataverse](https://cran.rstudio.com/web/packages/dataverse/index.html)
  - [discgolf](https://cran.rstudio.com/web/packages/discgolf/index.html)
  - [downloader](https://cran.rstudio.com/web/packages/downloader/index.html)
  - [duckduckr](https://cran.rstudio.com/web/packages/duckduckr/index.html)
  - [europepmc](https://cran.rstudio.com/web/packages/europepmc/index.html)
  - [FastRWeb](https://cran.rstudio.com/web/packages/FastRWeb/index.html)
  - [fauxpas](https://cran.rstudio.com/web/packages/fauxpas/index.html)
  - [fbRads](https://cran.rstudio.com/web/packages/fbRads/index.html)
  - [feedeR](https://cran.rstudio.com/web/packages/feedeR/index.html)
  - [fiery](https://cran.rstudio.com/web/packages/fiery/index.html)
  - [fulltext](https://cran.rstudio.com/web/packages/fulltext/index.html)
  - [ganalytics](https://cran.rstudio.com/web/packages/ganalytics/index.html)
  - [gdns](https://cran.rstudio.com/web/packages/gdns/index.html)
  - [geonapi](https://cran.rstudio.com/web/packages/geonapi/index.html)
  - [geosapi](https://cran.rstudio.com/web/packages/geosapi/index.html)
  - [ggmap](https://cran.rstudio.com/web/packages/ggmap/index.html)
  - [gh](https://cran.rstudio.com/web/packages/gh/index.html)
  - [gistr](https://cran.rstudio.com/web/packages/gistr/index.html)
  - [git2r](https://cran.rstudio.com/web/packages/git2r/index.html)
  - [gitlabr](https://cran.rstudio.com/web/packages/gitlabr/index.html)
  - [gmailr](https://cran.rstudio.com/web/packages/gmailr/index.html)
  - [googleAnalyticsR](https://cran.rstudio.com/web/packages/googleAnalyticsR/
    index.html)
  - [googleAuthR](https://cran.rstudio.com/web/packages/googleAuthR/index.html)
  - [googleCloudStorageR](https://cran.rstudio.com/web/packages/
    googleCloudStorageR/index.html)
  - [googleComputeEngineR](https://cran.rstudio.com/web/packages/
    googleComputeEngineR/index.html)
  - [googleLanguageR](https://cran.rstudio.com/web/packages/googleLanguageR/
    index.html)
  - [googlesheets](https://cran.rstudio.com/web/packages/googlesheets/
    index.html)
  - [googleVis](https://cran.rstudio.com/web/packages/googleVis/index.html)
  - [graphTweets](https://cran.rstudio.com/web/packages/graphTweets/index.html)
  - [gsheet](https://cran.rstudio.com/web/packages/gsheet/index.html)
  - [gtrendsR](https://cran.rstudio.com/web/packages/gtrendsR/index.html)
  - [hackeRnews](https://cran.rstudio.com/web/packages/hackeRnews/index.html)
  - [htm2txt](https://cran.rstudio.com/web/packages/htm2txt/index.html)
  - [htmltidy](https://cran.rstudio.com/web/packages/htmltidy/index.html)
  - [htmltools](https://cran.rstudio.com/web/packages/htmltools/index.html)
  - [httpcache](https://cran.rstudio.com/web/packages/httpcache/index.html)
  - [httpcode](https://cran.rstudio.com/web/packages/httpcode/index.html)
  - [httping](https://cran.rstudio.com/web/packages/httping/index.html)
  - [httpRequest](https://cran.rstudio.com/web/packages/httpRequest/index.html)
  - [httptest](https://cran.rstudio.com/web/packages/httptest/index.html)
  - [httpuv](https://cran.rstudio.com/web/packages/httpuv/index.html)
  - [httr](https://cran.rstudio.com/web/packages/httr/index.html) (core)
  - [imguR](https://cran.rstudio.com/web/packages/imguR/index.html)
  - [instaR](https://cran.rstudio.com/web/packages/instaR/index.html)
  - [ipaddress](https://cran.rstudio.com/web/packages/ipaddress/index.html)
  - [iptools](https://cran.rstudio.com/web/packages/iptools/index.html)
  - [jqr](https://cran.rstudio.com/web/packages/jqr/index.html)
  - [js](https://cran.rstudio.com/web/packages/js/index.html)
  - [jsonlite](https://cran.rstudio.com/web/packages/jsonlite/index.html) (core)
  - [jsonvalidate](https://cran.rstudio.com/web/packages/jsonvalidate/index.html)
  - [jstor](https://cran.rstudio.com/web/packages/jstor/index.html)
  - [languagelayeR](https://cran.rstudio.com/web/packages/languagelayeR/index.html)
  - [leafletR](https://cran.rstudio.com/web/packages/leafletR/index.html)
  - [longurl](https://cran.rstudio.com/web/packages/longurl/index.html)
  - [magrittr](https://cran.rstudio.com/web/packages/magrittr/index.html)
  - [mailR](https://cran.rstudio.com/web/packages/mailR/index.html)
  - [mapsapi](https://cran.rstudio.com/web/packages/mapsapi/index.html)
  - [mathpix](https://cran.rstudio.com/web/packages/mathpix/index.html)
  - [Microsoft365R](https://cran.rstudio.com/web/packages/Microsoft365R/
    index.html)
  - [mime](https://cran.rstudio.com/web/packages/mime/index.html)
  - [mscstexta4r](https://cran.rstudio.com/web/packages/mscstexta4r/index.html)
  - [mscsweblm4r](https://cran.rstudio.com/web/packages/mscsweblm4r/index.html)
  - [ndjson](https://cran.rstudio.com/web/packages/ndjson/index.html)
  - [notifyme](https://cran.rstudio.com/web/packages/notifyme/index.html)
  - [oai](https://cran.rstudio.com/web/packages/oai/index.html)
  - [OAIHarvester](https://cran.rstudio.com/web/packages/OAIHarvester/
    index.html)
  - [openadds](https://cran.rstudio.com/web/packages/openadds/index.html)
  - [opencage](https://cran.rstudio.com/web/packages/opencage/index.html)
  - [opencpu](https://cran.rstudio.com/web/packages/opencpu/index.html)
  - [OpenML](https://cran.rstudio.com/web/packages/OpenML/index.html)
  - [osmar](https://cran.rstudio.com/web/packages/osmar/index.html)
  - [osmplotr](https://cran.rstudio.com/web/packages/osmplotr/index.html)
  - [osrm](https://cran.rstudio.com/web/packages/osrm/index.html)
  - [ows4R](https://cran.rstudio.com/web/packages/ows4R/index.html)
  - [paws](https://cran.rstudio.com/web/packages/paws/index.html)
  - [pdftables](https://cran.rstudio.com/web/packages/pdftables/index.html)
  - [plotKML](https://cran.rstudio.com/web/packages/plotKML/index.html)
  - [plotly](https://cran.rstudio.com/web/packages/plotly/index.html)
  - [plumber](https://cran.rstudio.com/web/packages/plumber/index.html)
  - [postlightmercury](https://cran.rstudio.com/web/packages/postlightmercury/
    index.html)
  - [pubmed.mineR](https://cran.rstudio.com/web/packages/pubmed.mineR/
    index.html)
  - [pushoverr](https://cran.rstudio.com/web/packages/pushoverr/index.html)
  - [qualtRics](https://cran.rstudio.com/web/packages/qualtRics/index.html)
  - [radiant](https://cran.rstudio.com/web/packages/radiant/index.html)
  - [RAdwords](https://cran.rstudio.com/web/packages/RAdwords/index.html)
  - [randNames](https://cran.rstudio.com/web/packages/randNames/index.html)
  - [rapiclient](https://cran.rstudio.com/web/packages/rapiclient/index.html)
  - [rapport](https://cran.rstudio.com/web/packages/rapport/index.html)
  - [rcoreoa](https://cran.rstudio.com/web/packages/rcoreoa/index.html)
  - [Rcrawler](https://cran.rstudio.com/web/packages/Rcrawler/index.html)
  - [rcrossref](https://cran.rstudio.com/web/packages/rcrossref/index.html)
  - [RCurl](https://cran.rstudio.com/web/packages/RCurl/index.html)
  - [rdatacite](https://cran.rstudio.com/web/packages/rdatacite/index.html)
  - [rdrop2](https://cran.rstudio.com/web/packages/rdrop2/index.html)
  - [redcapAPI](https://cran.rstudio.com/web/packages/redcapAPI/index.html)
  - [repmis](https://cran.rstudio.com/web/packages/repmis/index.html)
  - [reqres](https://cran.rstudio.com/web/packages/reqres/index.html)
  - [request](https://cran.rstudio.com/web/packages/request/index.html)
  - [rerddap](https://cran.rstudio.com/web/packages/rerddap/index.html)
  - [restfulr](https://cran.rstudio.com/web/packages/restfulr/index.html)
  - [Rexperigen](https://cran.rstudio.com/web/packages/Rexperigen/index.html)
  - [Rfacebook](https://cran.rstudio.com/web/packages/Rfacebook/index.html)
  - [rfigshare](https://cran.rstudio.com/web/packages/rfigshare/index.html)
  - [RGA](https://cran.rstudio.com/web/packages/RGA/index.html)
  - [rgeolocate](https://cran.rstudio.com/web/packages/rgeolocate/index.html)
  - [RgoogleMaps](https://cran.rstudio.com/web/packages/RgoogleMaps/index.html)
  - [rhub](https://cran.rstudio.com/web/packages/rhub/index.html)
  - [rio](https://cran.rstudio.com/web/packages/rio/index.html)
  - [rjson](https://cran.rstudio.com/web/packages/rjson/index.html)
  - [RJSONIO](https://cran.rstudio.com/web/packages/RJSONIO/index.html)
  - [Rlinkedin](https://cran.rstudio.com/web/packages/Rlinkedin/index.html)
  - [rLTP](https://cran.rstudio.com/web/packages/rLTP/index.html)
  - [roadoi](https://cran.rstudio.com/web/packages/roadoi/index.html)
  - [ROAuth](https://cran.rstudio.com/web/packages/ROAuth/index.html)
  - [robotstxt](https://cran.rstudio.com/web/packages/robotstxt/index.html)
  - [Rook](https://cran.rstudio.com/web/packages/Rook/index.html)
  - [rorcid](https://cran.rstudio.com/web/packages/rorcid/index.html)
  - [rosetteApi](https://cran.rstudio.com/web/packages/rosetteApi/index.html)
  - [routr](https://cran.rstudio.com/web/packages/routr/index.html)
  - [rpinterest](https://cran.rstudio.com/web/packages/rpinterest/index.html)
  - [rplos](https://cran.rstudio.com/web/packages/rplos/index.html)
  - [RPushbullet](https://cran.rstudio.com/web/packages/RPushbullet/index.html)
  - [rrefine](https://cran.rstudio.com/web/packages/rrefine/index.html)
  - [rromeo](https://cran.rstudio.com/web/packages/rromeo/index.html)
  - [RSclient](https://cran.rstudio.com/web/packages/RSclient/index.html)
  - [rscopus](https://cran.rstudio.com/web/packages/rscopus/index.html)
  - [rsdmx](https://cran.rstudio.com/web/packages/rsdmx/index.html)
  - [RSelenium](https://cran.rstudio.com/web/packages/RSelenium/index.html)
  - [Rserve](https://cran.rstudio.com/web/packages/Rserve/index.html)
  - [RSiteCatalyst](https://cran.rstudio.com/web/packages/RSiteCatalyst/
    index.html)
  - [RSmartlyIO](https://cran.rstudio.com/web/packages/RSmartlyIO/index.html)
  - [RStripe](https://cran.rstudio.com/web/packages/RStripe/index.html)
  - [rtweet](https://cran.rstudio.com/web/packages/rtweet/index.html)
  - [rvest](https://cran.rstudio.com/web/packages/rvest/index.html)
  - [RYandexTranslate](https://cran.rstudio.com/web/packages/RYandexTranslate/
    index.html)
  - [scholar](https://cran.rstudio.com/web/packages/scholar/index.html)
  - [scrapeR](https://cran.rstudio.com/web/packages/scrapeR/index.html)
  - [searchConsoleR](https://cran.rstudio.com/web/packages/searchConsoleR/
    index.html)
  - [securitytxt](https://cran.rstudio.com/web/packages/securitytxt/index.html)
  - [seleniumPipes](https://cran.rstudio.com/web/packages/seleniumPipes/
    index.html)
  - [sendmailR](https://cran.rstudio.com/web/packages/sendmailR/index.html)
  - [servr](https://cran.rstudio.com/web/packages/servr/index.html)
  - [shiny](https://cran.rstudio.com/web/packages/shiny/index.html) (core)
  - [slackr](https://cran.rstudio.com/web/packages/slackr/index.html)
  - [spiderbar](https://cran.rstudio.com/web/packages/spiderbar/index.html)
  - [splashr](https://cran.rstudio.com/web/packages/splashr/index.html)
  - [streamR](https://cran.rstudio.com/web/packages/streamR/index.html)
  - [swagger](https://cran.rstudio.com/web/packages/swagger/index.html)
  - [tidyRSS](https://cran.rstudio.com/web/packages/tidyRSS/index.html)
  - [tm.plugin.webmining](https://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html)
  - [transcribeR](https://cran.rstudio.com/web/packages/transcribeR/index.html)
  - [translate](https://cran.rstudio.com/web/packages/translate/index.html)
  - [translateR](https://cran.rstudio.com/web/packages/translateR/index.html)
  - [tweet2r](https://cran.rstudio.com/web/packages/tweet2r/index.html)
  - [twitteR](https://cran.rstudio.com/web/packages/twitteR/index.html)
  - [uaparserjs](https://cran.rstudio.com/web/packages/uaparserjs/index.html)
  - [urlshorteneR](https://cran.rstudio.com/web/packages/urlshorteneR/index.html)
  - [urltools](https://cran.rstudio.com/web/packages/urltools/index.html)
  - [V8](https://cran.rstudio.com/web/packages/V8/index.html)
  - [vcr](https://cran.rstudio.com/web/packages/vcr/index.html) (core)
  - [vkR](https://cran.rstudio.com/web/packages/vkR/index.html)
  - [W3CMarkupValidator](https://cran.rstudio.com/web/packages/W3CMarkupValidator/index.html)
  - [webmockr](https://cran.rstudio.com/web/packages/webmockr/index.html) (core)
  - [webreadr](https://cran.rstudio.com/web/packages/webreadr/index.html)
  - [webshot](https://cran.rstudio.com/web/packages/webshot/index.html)
  - [webutils](https://cran.rstudio.com/web/packages/webutils/index.html)
  - [whisker](https://cran.rstudio.com/web/packages/whisker/index.html)
  - [WikidataQueryServiceR](https://cran.rstudio.com/web/packages/WikidataQueryServiceR/index.html)
  - [WikidataR](https://cran.rstudio.com/web/packages/WikidataR/index.html)
  - [wikipediatrend](https://cran.rstudio.com/web/packages/wikipediatrend/index.html)
  - [WikipediR](https://cran.rstudio.com/web/packages/WikipediR/index.html)
  - [WufooR](https://cran.rstudio.com/web/packages/WufooR/index.html)
  - [XML](https://cran.rstudio.com/web/packages/XML/index.html)
  - [xml2](https://cran.rstudio.com/web/packages/xml2/index.html) (core)
  - [XML2R](https://cran.rstudio.com/web/packages/XML2R/index.html)
  - [xslt](https://cran.rstudio.com/web/packages/xslt/index.html)
  - [yhatr](https://cran.rstudio.com/web/packages/yhatr/index.html)
  - [zen4R](https://cran.rstudio.com/web/packages/zen4R/index.html)

### Related links:

  - [rOpenSci Task View: Open Data](https://github.com/ropensci/opendata)
