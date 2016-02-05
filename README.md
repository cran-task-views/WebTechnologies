CRAN Task View: Web Technologies and Services
---------------------------------------------

*Do not edit this README by hand. See [CONTRIBUTING.md](CONTRIBUTING.md).*

|-|-|
|**Maintainer:**|Thomas Leeper, Scott Chamberlain, Patrick Mair, Karthik Ram, Christopher Gandrud|
|**Contact:**|thosjleeper at gmail.com|
|**Version:**|2016-02-05|

This Task View contains information about to use R and the world wide web together. The base version of R does not ship with many tools for interacting with the web. Thankfully, there are an increasingly large number of tools for interacting with the web. This task view focuses on packages for obtaining web-based data and information, frameworks for building web-based R applications, and online services that can be accessed from R. A list of available packages and functions is presented below, grouped by the type of activity. The [Open Data Task View](https://github.com/ropensci/opendata) provides further discussion of online data sources that can be accessed from R.

If you have any comments or suggestions for additions or improvements for this Task View, go to GitHub and [submit an issue](https://github.com/ropensci/webservices/issues), or make some changes and [submit a pull request](https://github.com/ropensci/webservices/pulls). If you can't contribute on GitHub,

send Thomas an email (thosjleeper at gmail dot com)

. If you have an issue with one of the packages discussed below, please contact the maintainer of that package. If you know of a web service, API, data source, or other online resource that is not yet supported by an R package, consider adding it to [the package development to do list on GitHub](https://github.com/ropensci/webservices/wiki/ToDo).

Tools for Working with the Web from R
-------------------------------------

**Core Tools For HTTP Requests**

There are two packages that should cover most use cases of interacting with the web from R. [httr](http://cran.rstudio.com/web/packages/httr/index.html) provides a user-friendly interface for executing HTTP methods (GET, POST, PUT, HEAD, DELETE, etc.) and provides support for modern web authentication protocols (OAuth 1.0, OAuth 2.0). HTTP status codes are helpful for debugging HTTP calls. httr makes this easier using, for example, `stop_for_status()`, which gets the http status code from a response object, and stops the function if the call was not successful. (See also `warn_for_status()`.) Note that you can pass in additional libcurl options to the `config` parameter in http calls. [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html) is a lower-level package that provides a closer interface between R and the [libcurl C library](http://curl.haxx.se/libcurl/), but is less user-friendly. It may be useful for operations on web-based XML or to perform FTP operations. For more specific situations, the following resources may be useful:

-   [curl](http://cran.rstudio.com/web/packages/curl/index.html) is another libcurl client that provides the `curl()` function as an SSL-compatible replacement for base R's `url()` and support for http 2.0, ssl (https, ftps), gzip, deflate and more. For websites serving insecure HTTP (i.e. using the "http" not "https" prefix), most R functions can extract data directly, including `read.table` and `read.csv`; this also applies to functions in add-on packages such as `jsonlite::fromJSON` and `XML::parseXML`. [httpRequest](http://cran.rstudio.com/web/packages/httpRequest/index.html) is another low-level package for HTTP requests that implements the GET, POST and multipart POST verbs.
-   For dynamically generated webpages (i.e., those requiring user interaction to display results), [RSelenium](http://cran.rstudio.com/web/packages/RSelenium/index.html) ([GitHub](https://github.com/ropensci/RSelenium/)) can be used to automate those interactions and extract page contents. It provides a set of bindings for the Selenium 2.0 webdriver using the [JsonWireProtocol](http://code.google.com/p/selenium/wiki/JsonWireProtocol). It can also aid in automated application testing, load testing, and web scraping. [rdom](https://github.com/cpsievert/rdom) (not on CRAN) uses [phantomjs](http://phantomjs.org/) to access a webpage's Document Object Model (DOM).
-   Another, higher-level alternative package useful for webscraping is [rvest](http://cran.rstudio.com/web/packages/rvest/index.html) ([GitHub](https://github.com/hadley/rvest)), which is designed to work with [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html) to make it easy to express common web scraping tasks.
-   Many base R tools can be used to download web content, provided that the website does not use SSL (i.e., the URL does not have the "https" prefix). `download.file()` is a general purpose function that can be used to download a remote file. For SSL, the `download()` function in [downloader](http://cran.rstudio.com/web/packages/downloader/index.html) wraps `download.file()`, and takes all the same arguments.
-   Tabular data sets (e.g., txt, csv, etc.) can be input using `read.table()`, `read.csv()`, and friends, again assuming that the files are not hosted via SSL. An alternative is to use `httr::GET` (or `RCurl::getURL`) to first read the file into R as a character vector before parsing with `read.table(text=...)`, or you can download the file to a local directory. [rio](http://cran.rstudio.com/web/packages/rio/index.html) ([GitHub](https://www.github.com/leeper/rio)) provides an `import()` function that can read a number of common data formats directly from an https:// URL. The [repmis](http://cran.rstudio.com/web/packages/repmis/index.html) function `source_data()` can load and cache plain-text data from a URL (either http or https). That package also includes `source_Dropbox()` for downloading/caching plain-text data from non-public Dropbox folders and `source_XlsxData()` for downloading/caching Excel xlsx sheets.
-   *Authentication*: Using web resources can require authentication, either via API keys, OAuth, username:password combination, or via other means. Additionally, sometimes web resources that require authentication be in the header of an http call, which requires a little bit of extra work. API keys and username:password combos can be combined within a url for a call to a web resource (api key: http://api.foo.org/?key=yourkey; user/pass: http://username:password@api.foo.org), or can be specified via commands in [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html) or [httr](http://cran.rstudio.com/web/packages/httr/index.html). OAuth is the most complicated authentication process, and can be most easily done using [httr](http://cran.rstudio.com/web/packages/httr/index.html). See the 6 demos within [httr](http://cran.rstudio.com/web/packages/httr/index.html), three for OAuth 1.0 (linkedin, twitter, vimeo) and three for OAuth 2.0 (facebook, GitHub, google). [ROAuth](http://cran.rstudio.com/web/packages/ROAuth/index.html) is a package that provides a separate R interface to OAuth. OAuth is easier to to do in [httr](http://cran.rstudio.com/web/packages/httr/index.html), so start there. [googleAuthR](https://github.com/MarkEdmondson1234/googleAuthR) provides an OAuth 2.0 setup specifically for Google web services.

**Parsing Structured Web Data**

The vast majority of web-based data is structured as plain text, HTML, XML, or JSON (javascript object notation). Web service APIs increasingly rely on JSON, but XML is still prevalent in many applications. There are several packages for specifically working with these format. These functions can be used to interact directly with insecure webpages or can be used to parse locally stored or in-memory web files.

-   *XML/HTML*: There are two packages for working with XML: [XML](http://cran.rstudio.com/web/packages/XML/index.html) and [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) ([GitHub](https://github.com/hadley/xml2)). Both support general XML (and HTML) parsing, including XPath queries. The package [xml2](http://cran.rstudio.com/web/packages/xml2/index.html) is less fully featured, but more user friendly with respect to memory management, classes (e.g., XML node vs. node set vs. document), and namespaces. Of the two, only the [XML](http://cran.rstudio.com/web/packages/XML/index.html) supports *de novo* creation of XML nodes and documents. The [XML2R](http://cran.rstudio.com/web/packages/XML2R/index.html) ([GitHub](https://github.com/cpsievert/XML2R)) package is a collection of convenient functions for coercing XML into data frames. An alternative to [XML](http://cran.rstudio.com/web/packages/XML/index.html) is [selectr](http://sjp.co.nz/projects/selectr/), which parses CSS3 Selectors and translates them to XPath 1.0 expressions. [XML](http://cran.rstudio.com/web/packages/XML/index.html) package is often used for parsing xml and html, but [selectr](http://sjp.co.nz/projects/selectr/) translates CSS selectors to XPath, so can use the CSS selectors instead of XPath. The [selectorgadget browser extension](http://selectorgadget.com/) can be used to identify page elements. [RHTMLForms](http://www.Omegahat.org/RHTMLForms/) reads HTML documents and obtains a description of each of the forms it contains, along with the different elements and hidden fields. [scrapeR](http://cran.rstudio.com/web/packages/scrapeR/index.html) provides additional tools for scraping data from HTML and XML documents. [htmltab](http://cran.rstudio.com/src/contrib/Archive/htmltab/) extracts structured information from HTML tables, similar to `XML::readHTMLTable` of the [XML](http://cran.rstudio.com/web/packages/XML/index.html) package, but automatically expands row and column spans in the header and body cells, and users are given more control over the identification of header and body rows which will end up in the R table.
-   *JSON*: There are three packages for reading and writing JSON: [rjson](http://cran.rstudio.com/web/packages/rjson/index.html), [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html), and [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html). [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html) includes a different parser from [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html) called [yajl](https://lloyd.github.io/yajl/). We recommend using [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html). Check out the paper describing jsonlite by Jeroen Ooms [http://arxiv.org/abs/1403.2805](http://arxiv.org/abs/1403.2805). [tidyjson](http://cran.rstudio.com/web/packages/tidyjson/index.html) ([GitHub](https://github.com/sailthru/tidyjson)) converts JSON into a data.frame.

**Tools for Working with URLs**

-   The `httr::parse_url()` function can be used to extract portions of a URL. The `RCurl::URLencode()` and `utils::URLencode()` functions can be used to encode character strings for use in URLs. `utils::URLdecode()` decodes back to the original strings. [urltools](http://cran.rstudio.com/web/packages/urltools/index.html) ([GitHub](https://github.com/Ironholds/urltools)) can also handle URL encoding, decoding, parsing, and parameter extraction.
-   The [tldextract](https://github.com/jayjacobs/tldextract) package extract top level domains and subdomains from a host name. It's a port of [a Python library of the same name](https://github.com/john-kurkowski/tldextract).
-   [iptools](https://github.com/hrbrmstr/iptools) can facilitate working with IPv4 addresses, including for use in geolocation.
-   [urlshorteneR](http://cran.rstudio.com/web/packages/urlshorteneR/index.html) ([GitHub](https://github.com/dmpe/urlshorteneR)) offers URL expansion and analysis for Bit.ly, Goo.gl, and is.gd. [longurl](http://cran.rstudio.com/web/packages/longurl/index.html) uses the [longurl.org](http://longurl.org/) API to provide similar functionality.

**Tools for Working with Scraped Webpage Contents**

-   Several packages can be used for parsing HTML documents. [boilerpipeR](http://cran.rstudio.com/web/packages/boilerpipeR/index.html) provides generic extraction of main text content from HTML files; removal of ads, sidebars and headers using the boilerpipe Java library. [RTidyHTML](http://www.Omegahat.org/RTidyHTML/) interfaces to the libtidy library for correcting HTML documents that are not well-formed. This library corrects common errors in HTML documents. [W3CMarkupValidator](http://cran.rstudio.com/web/packages/W3CMarkupValidator/index.html) provides an R Interface to W3C Markup Validation Services for validating HTML documents.
-   For XML documents, the [XMLSchema](http://www.Omegahat.org/XMLSchema/) package provides facilities in R for reading XML schema documents and processing them to create definitions for R classes and functions for converting XML nodes to instances of those classes. It provides the framework for meta-computing with XML schema in R. [xslt](https://github.com/hrbrmstr/xslt) is a package providing an interface to the [xmlwrapp](http://vslavik.github.io/xmlwrapp/) an XML processing library that provides an XSLT engine for transforming XML data using a transform stylesheet. (It can be seen as a modern replacement for [Sxslt](http://www.Omegahat.org/Sxslt/), which is an interface to Dan Veillard's libxslt translator, and the [SXalan](http://www.Omegahat.org/SXalan/) package.) This may be useful for webscraping, as well as transforming XML markup into another human- or machine-readable format (e.g., HTML, JSON, plain text, etc.). [SSOAP](http://www.Omegahat.org/SSOAP/) provides a client-side SOAP (Simple Object Access Protocol) mechanism. It aims to provide a high-level interface to invoke SOAP methods provided by a SOAP server. [XMLRPC](http://www.Omegahat.org/XMLRPC/) provides an implementation of XML-RPC, a relatively simple remote procedure call mechanism that uses HTTP and XML. This can be used for communicating between processes on a single machine or for accessing Web services from within R.
-   [Rcompression](http://www.Omegahat.org/Rcompression/) (not on CRAN): Interface to zlib and bzip2 libraries for performing in-memory compression and decompression in R. This is useful when receiving or sending contents to remote servers, e.g. Web services, HTTP requests via RCurl.
-   [tm.plugin.webmining](http://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html): Extensible text retrieval framework for news feeds in XML (RSS, ATOM) and JSON formats. Currently, the following feeds are implemented: Google Blog Search, Google Finance, Google News, NYTimes Article Search, Reuters News Feed, Yahoo Finance and Yahoo Inplay.

**Other Useful Packages and Functions**

-   *Javascript*: [V8](http://cran.rstudio.com/web/packages/V8/index.html) ([GitHub](https://github.com/jeroenooms/v8)) is an R interface to Google's open source, high performance JavaScript engine. It can wrap Javascript libraries as well as NPM packages. The [SpiderMonkey](http://www.Omegahat.org/SpiderMonkey/) package provides another means of evaluating JavaScript code, creating JavaScript objects and calling JavaScript functions and methods from within R. This can work by embedding the JavaScript engine within an R session or by embedding R in an browser such as Firefox and being able to call R from JavaScript and call back to JavaScript from R.
-   *Email:*: [mailR](http://cran.rstudio.com/web/packages/mailR/index.html) is an interface to Apache Commons Email to send emails from within R. [sendmailR](http://cran.rstudio.com/web/packages/sendmailR/index.html) provides a simple SMTP client. [gmailr](http://cran.rstudio.com/web/packages/gmailr/index.html) provides access the Google's gmail.com RESTful API.
-   *Miscellaneous*: [webutils](http://cran.rstudio.com/web/packages/webutils/index.html) ([GitHub](https://github.com/jeroenooms/webutils)) contains various functions for developing web applications, including parsers for `application/x-www-form-urlencoded` as well as `multipart/form-data`. [mime](http://cran.rstudio.com/web/packages/mime/index.html) ([GitHub](https://github.com/yihui/mime)) guesses the MIME type for a file from its extension. [rsdmx](http://cran.rstudio.com/web/packages/rsdmx/index.html) ([GitHub](https://github.com/opensdmx/rsdmx/wiki)) provides tools to read data and metadata documents exchanged through the Statistical Data and Metadata Exchange (SDMX) framework. The package currently focuses on the SDMX XML standard format (SDMX-ML).

Web and Server Frameworks
-------------------------

-   [DeployR Open](http://deployr.revolutionanalytics.com/) is a server-based framework for integrating R into other applications via Web Services.
-   The [shiny](http://cran.rstudio.com/web/packages/shiny/index.html) package makes it easy to build interactive web applications with R.
-   [dull](https://github.com/nteetor/dull) (not on CRAN) is new, light weight web framework that uses magrittr-style syntax and is modeled after [expressjs](http://expressjs.com/).
-   [rcloud](https://github.com/att/rcloud) (not on CRAN) provides an iPython notebook-style web-based R interface.
-   The [Rook](http://cran.rstudio.com/web/packages/Rook/index.html) web server interface contains the specification and convenience software for building and running Rook applications.
-   The [opencpu](http://cran.rstudio.com/web/packages/opencpu/index.html) framework for embedded statistical computation and reproducible research exposes a web API interfacing R, LaTeX and Pandoc. This API is used for example to integrate statistical functionality into systems, share and execute scripts or reports on centralized servers, and build R based apps.
-   A package by [Yihui Xie](http://yihui.name/) called [servr](http://cran.rstudio.com/web/packages/servr/index.html) provides a simple HTTP server to serve files under a given directory based on the [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html) package.
-   [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html) provides a low-level socket and protocol support for handling HTTP and WebSocket requests directly within R. Another related package, perhaps which [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html) replaces, is websockets, also made by Joe Cheng.
-   [websockets](https://github.com/rstudio/R-Websockets): A simple HTML5 websocket interface for R, by Joe Cheng. Available in [CRAN archives](http://cran.rstudio.com/src/contrib/Archive/websockets/).
-   The [WADL](http://www.Omegahat.org/WADL/) package provides tools to process Web Application Description Language (WADL) documents and to programmatically generate R functions to interface to the REST methods described in those WADL documents. (not on CRAN)
-   The [RDCOMServer](http://www.Omegahat.org/RDCOMServer/) provides a mechanism to export R objects as (D)COM objects in Windows. It can be used along with the [RDCOMClient](http://www.Omegahat.org/RDCOMClient/) package which provides user-level access from R to other COM servers. (not on CRAN)
-   [rapporter.net](http://rapporter.net) provides an online environment (SaaS) to host and run [rapport](http://cran.rstudio.com/web/packages/rapport/index.html) statistical report templates in the cloud.
-   [radiant](http://cran.rstudio.com/web/packages/radiant/index.html) is Shiny-based GUI for R that runs in a browser from a server or local machine. Development version on [GitHub](https://github.com/vnijs/radiant).
-   [neocities](https://github.com/seankross/neocities) wraps the API for the [Neocities](https://neocities.org/) web hosting service. (not on CRAN)
-   The [Tiki](http://info.tiki.org/tiki-index.php) Wiki CMS/Groupware framework has an R plugin ([PluginR](https://doc.tiki.org/PluginR)) to run R code from wiki pages, and use data from their own collected web databases (trackers). A demo: [http://r.tiki.org](http://r.tiki.org/tiki-index.php). More info in a [useR!2013 presentation](http://ueb.vhir.org/2011+UseR).
-   The [MediaWiki](http://www.mediawiki.org) has an extension ([Extension:R](http://www.mediawiki.org/wiki/Extension:R)) to run R code from wiki pages, and use uploaded data. Links to demo pages (in German) can be found at the [category page for R scripts](http://mars.wiwi.hu-berlin.de/mediawiki/mmstat_de/index.php/Kategorie:R) at MM-Stat. A mailing list is available: [R-sig-mediawiki](https://stat.ethz.ch/mailman/listinfo/r-sig-mediawiki).
-   [whisker](http://cran.rstudio.com/web/packages/whisker/index.html): Implementation of logicless templating based on [Mustache](http://mustache.github.io/) in R. Mustache syntax is described in [http://mustache.github.io/mustache.5.html](http://mustache.github.io/mustache.5.html)
-   [CGIwithR](http://www.Omegahat.org/CGIwithR/) (not on CRAN) allows one to use R scripts as CGI programs for generating dynamic Web content. HTML forms and other mechanisms to submit dynamic requests can be used to provide input to R scripts via the Web to create content that is determined within that R script.
-   [jug](http://cran.rstudio.com/web/packages/jug/index.html) is a simple API-builder web framework, built around [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html).

Web Services
------------

**Cloud Computing and Storage**

-   Amazon Web Services is a popular, proprietary cloud service offering a suite of computing, storage, and infrastructure tools. *Simple Storage Service (S3)* is a commercial server that allows one to store content and retrieve it from any machine connected to the Internet. [RAmazonS3](http://www.Omegahat.org/RAmazonS3/) and [s3mpi](https://github.com/robertzk/s3mpi) (not on CRAN) provides basic infrastructure for communicating with S3. [AWS.tools](http://cran.rstudio.com/src/contrib/Archive/AWS.tools/) ([GitHub](https://github.com/armstrtw/AWS.tools)) interacts with S3 and EC2 using the AWS command line interface (an external system dependency). The CRAN version is archived. [awsConnect](https://github.com/lalas/awsConnect) (not on CRAN) is another package using the AWS Command Line Interface to control EC2 and S3, which is only available for Linux and Mac OS. *Elastic Cloud Compute (EC2)* is a cloud computing service. AWS.tools and [awsConnect](https://github.com/lalas/awsConnect) (not on CRAN) both use the AWS command line interface to control EC2. [segue](http://code.google.com/p/segue/) (not on CRAN) is another package for managing EC2 instances and S3 storage, which includes a parallel version of `lapply()` for the Elastic Map Reduce (EMR) engine called `emrlapply()`. It uses Hadoop Streaming on Amazon's EMR in order to get simple parallel computation. *DBREST*: [RAmazonDBREST](http://www.Omegahat.org/RAmazonDBREST/) provides an interface to Amazon's Simple DB API. [The cloudyr project](https://github.com/cloudyr/), which is currently under active development on GitHub, aims to provide a unified interface to the full Amazon Web Services suite without the need for external system dependencies. None of these packages are on CRAN.
-   *Cloud Storage*: [boxr](http://cran.r-project.org/whttp://cran.rstudio.com/web/packages/boxr) ([GitHub](https://github.com/brendan-R/boxr)) is a lightweight, high-level interface for the [box.com API](https://developers.box.com/docs/). [rDrop2](https://github.com/karthik/rdrop2) ([GitHub](https://github.com/karthik/rdrop2); not on CRAN) is a Dropbox interface that provides access to a full suite of file operations, including dir/copy/move/delete operations, account information (including quotas) and the ability to upload and download files from any Dropbox account.
-   *Docker*: [analogsea](https://github.com/sckott/analogsea) is a general purpose client for the Digital Ocean v2 API. In addition, the package includes functions to install various R tools including base R, RStudio server, and more. There's an improving interface to interact with docker on your remote droplets via this package.

**Document and Code Sharing**

-   *Code Sharing*: [gistr](http://cran.rstudio.com/web/packages/gistr/index.html) ([GitHub](https://github.com/ropensci/gistr)) works with GitHub gists ([gist.github.com](https://gist.github.com/)) from R, allowing you to create new gists, update gists with new files, rename files, delete files, get and delete gists, star and un-star gists, fork gists, open a gist in your default browser, get embed code for a gist, list gist commits, and get rate limit information when authenticated. [git2r](http://cran.rstudio.com/web/packages/git2r/index.html) provides bindings to the git version control system and [rgithub](https://github.com/cscheid/rgithub) (not on CRAN) provides access to the GitHub.com API, both of which can facilitate code or data sharing via GitHub. [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html) is a [GitLab](https://about.gitlab.com/) -specific client.
-   *Data archiving*: [dvn](http://cran.rstudio.com/web/packages/dvn/index.html) ([GitHub](https://github.com/ropensci/dvn)) provides access to The Dataverse Network API. [rfigshare](http://cran.rstudio.com/web/packages/rfigshare/index.html) ([GitHub](https://github.com/ropensci/rfigshare)) connects with [Figshare.com](http://figshare.com/). [dataone](http://cran.rstudio.com/src/contrib/Archive/dataone/) provides read/write access to data and metadata from the [DataONE network](https://www.dataone.org/) of Member Node data repositories.
-   *Google Drive/Google Documents*: The [RGoogleDocs](http://www.Omegahat.org/RGoogleDocs/) package is an example of using the RCurl and XML packages to quickly develop an interface to the Google Documents API. [RGoogleStorage](http://www.Omegahat.org/RGoogleStorage/) provides programmatic access to the Google Storage API. This allows R users to access and store data on Google's storage. We can upload and download content, create, list and delete folders/buckets, and set access control permissions on objects and buckets.
-   *Google Sheets*: [googlesheets](http://cran.rstudio.com/web/packages/googlesheets/index.html) ([GitHub](https://github.com/jennybc/googlesheets)) can access private or public Google Sheets by title, key, or URL. Extract data or edit data. Create, delete, rename, copy, upload, or download spreadsheets and worksheets. [gsheet](http://cran.rstudio.com/web/packages/gsheet/index.html) ([GitHub](https://github.com/maxconway/gsheet)) can download Google Sheets using just the sharing link. Spreadsheets can be downloaded as a data frame, or as plain text to parse manually.
-   [imguR](http://cran.rstudio.com/web/packages/imguR/index.html) ([GitHub](https://github.com/leeper/imguR)) is a package to share plots using the image hosting service [Imgur.com](http://www.imgur.com). knitr also has a function `imgur_upload()` to load images from literate programming documents.
-   [rscribd](https://github.com/leeper/rscribd) (not on CRAN): API client for publishing documents to [Scribd](http://www.scribd.com).

**Data Analysis and Processing Services**

-   *Crowdsourcing*: Amazon Mechanical Turk is a paid crowdsourcing platform that can be used to semi-automate tasks that are not easily automated. [MTurkR](http://cran.rstudio.com/web/packages/MTurkR/index.html) ([GitHub](https://www.github.com/leeper/MTurkR))) provides access to the Amazon Mechanical Turk Requester API. [microworkers](https://github.com/leeper/microworkers) (not on CRAN) can distribute tasks and retrieve results for the Microworkers.com platform.
-   [genderizeR](http://cran.rstudio.com/web/packages/genderizeR/index.html) ([GitHub](https://github.com/kalimu/genderizeR)) uses the [genderize.io](http://genderize.io) API to predict gender from first names extracted from a text vector.
-   *Geolocation/Geocoding*: Several packages connect to geolocation/geocoding services. [rgeolocate](http://cran.rstudio.com/web/packages/rgeolocate/index.html) ([GitHub](https://github.com/ironholds/rgeolocate)) offers several online and offline tools. [rydn](https://github.com/trestletech/rydn) (not on CRAN) is an interface to the Yahoo Developers network geolocation APIs, [geocodeHERE](http://cran.rstudio.com/web/packages/geocodeHERE/index.html) ([GitHub](https://github.com/corynissen/geocodeHERE)): Wrapper for Nokia's [HERE](http://here.com/) geocoding API, and [ipapi](https://github.com/hrbrmstr/ipapi) ([GitHub](https://github.com/hrbrmstr/ipapi)) can be used to geolocate IPv4/6 addresses and/or domain names using the [ip-api.com](http://ip-api.com/) API. [threewords](http://cran.rstudio.com/web/packages/threewords/index.html) connects to the [What3Words API](http://what3words.com/), which represents every 3-meter by 3-meter square on earth as a three-word phrase.
-   *Machine Learning as a Service*: Several packages provide access to cloud-based machine learning services. [AzureML](http://cran.rstudio.com/web/packages/AzureML/index.html) links with the Microsoft Azure machine learning service. [bigml](http://cran.rstudio.com/web/packages/bigml/index.html) ([GitHub](https://github.com/bigmlcom/bigml-r)) connects to BigML. [ddeploy](http://cran.rstudio.com/web/packages/ddeploy/index.html) wraps the [Duke Analytics model deployment API](http://www.dukeanalytics.com/products/dukedeployR.php). [indicoio](http://cran.rstudio.com/web/packages/indicoio/index.html) ([GitHub](https://github.com/redmode/indicoio)) connects to APIs at [http://indico.io](http://indico.io), with wrappers for Positive/Negative Sentiment Analysis, Political Sentiment Analysis, Image Feature Extraction, Facial Emotion Recognition, Facial Feature Extraction, and Language Detection. [clarifai](http://cran.rstudio.com/web/packages/clarifai/index.html) ([GitHub](http://github.com/soodoku/clarifai)) is a [Clarifai.com](http://clarifai.com) client that enables automated image description. [rLTP](http://cran.rstudio.com/web/packages/rLTP/index.html) ([GitHub](https://github.com/hetong007/rLTP)) accesses the [ltp-cloud service](http://www.ltp-cloud.com/). [googlepredictionapi](https://code.google.com/p/google-prediction-api-r-client/) (not on CRAN): is an R client for the [Google Prediction API](https://cloud.google.com/prediction/docs), a suite of cloud machine learning tools. Finally, [RDataCanvas](http://cran.rstudio.com/web/packages/RDataCanvas/index.html) ([GitHub](https://github.com/DataCanvasIO/RDataCanvas)) can write a module for [datacanvas.io](http://datacanvas.io), a big data analytics platform. [yhatr](http://cran.rstudio.com/web/packages/yhatr/index.html) lets you deploy, maintain, and invoke models via the [Yhat](https://www.yhathq.com/) REST API.
-   *Machine Translation*: [translate](http://cran.rstudio.com/web/packages/translate/index.html) provides bindings for the Google Translate API v2 and [translateR](http://cran.rstudio.com/web/packages/translateR/index.html) provides bindings for both Google and Microsoft translation APIs. [mstranslator](https://github.com/chainsawriot/mstranslator) ([GitHub](https://github.com/chainsawriot/mstranslator)) provides an R wrapper for the [Microsoft Translator API](https://msdn.microsoft.com/en-us/library/hh454949.aspx). [transcribeR](http://cran.rstudio.com/web/packages/transcribeR/index.html) provides automated audio transcription via the HP IDOL service. [abbyyR](https://github.com/soodoku/abbyyR) and [captr](http://cran.rstudio.com/web/packages/captr/index.html) ([GitHub](https://github.com/soodoku/captr)) connect to optical character recognition (OCR) APIs.
-   *Mapping*: [osmar](http://cran.rstudio.com/web/packages/osmar/index.html) provides infrastructure to access OpenStreetMap data from different sources to work with the data in common R manner and to convert data into available infrastructure provided by existing R packages (e.g., into sp and igraph objects). [RgoogleMaps](http://cran.rstudio.com/web/packages/RgoogleMaps/index.html) serves two purposes: it provides a comfortable R interface to query the Google server for static maps, and use the map as a background image to overlay plots within R. [R2GoogleMaps](http://www.Omegahat.org/R2GoogleMaps/) provides a mechanism to generate JavaScript code from R that displays data using Google Maps. [RKMLDevice](http://www.Omegahat.org/RKMLDevice/) allows to create R graphics in Keyhole Markup Language (KML) format in a manner that allows them to be displayed on Google Earth (or Google Maps), and [RKML](http://www.Omegahat.org/RKML/) provides users with high-level facilities to generate KML. [plotKML](http://cran.rstudio.com/web/packages/plotKML/index.html) can visualization spatial and spatio-temporal objects in Google Earth. [plotGoogleMaps](http://cran.rstudio.com/web/packages/plotGoogleMaps/index.html) pls SP or SPT (STDIF,STFDF) data as an HTML map mashup over Google Maps. [ggmap](http://cran.rstudio.com/web/packages/ggmap/index.html) allows for the easy visualization of spatial data and models on top of Google Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2. [leafletR](http://cran.rstudio.com/web/packages/leafletR/index.html): Allows you to display your spatial data on interactive web-maps using the open-source JavaScript library Leaflet. [CartoDB](https://github.com/becarioprecario/cartodb-r/tree/master/CartoDB) (not on CRAN) provides an API interface to [Cartodb.com](http://developers.cartodb.com/).
-   *Online Surveys*: [Rmonkey](http://cran.rstudio.com/web/packages/Rmonkey/index.html) ([GitHub](https://github.com/leeper/Rmonkey/)) provides programmatic access to [Survey Monkey](https://www.surveymonkey.com/) for creating simple surveys and retrieving survey results. [qualtrics](https://github.com/jbryer/qualtrics) (not on CRAN) provides functions to interact with [Qualtrics](http://www.qualtrics.com/). [WufooR](http://cran.rstudio.com/web/packages/WufooR/index.html) ([GitHub](https://github.com/dmpe/wufoor)) can retrieve data from [Wufoo.com](http://www.wufoo.com/) forms. [redcapAPI](http://cran.rstudio.com/web/packages/redcapAPI/index.html) ([GitHub](https://github.com/nutterb/redcapAPI)) can provide access to data stored in a REDCap (Research Electronic Data CAPture) database, which is a web application for building and managing online surveys and databases developed at Vanderbilt University. [formr](https://github.com/rubenarslan/formr) facilitates use of the [formr](https://formr.org/) survey framework, which is built on openCPU.
-   *Visualization*: Plot.ly is a company that allows you to create visualizations in the web using R (and Python). They have an R package in development [here](https://github.com/ropensci/plotly) (not on CRAN), as well as access to their services via [a REST API](https://plot.ly/API/). [googleVis](http://cran.rstudio.com/web/packages/googleVis/index.html) provides an interface between R and the Google chart tools. The [RUbigraph](http://www.Omegahat.org/RUbigraph/) package provides an R interface to a Ubigraph server for drawing interactive, dynamic graphs. You can add and remove vertices/nodes and edges in a graph and change their attributes/characteristics such as shape, color, size. Interactive, Javascript-enabled graphics are an increasingly useful output format for data analysis. [ggvis](http://cran.rstudio.com/web/packages/ggvis/index.html) makes it easy to describe interactive web graphics in R. It fuses the ideas of ggplot2 and [shiny](http://cran.rstudio.com/web/packages/shiny/index.html), rendering graphics on the web with Vega. [d3Network](http://cran.rstudio.com/web/packages/d3Network/index.html) provides tools for creating D3 JavaScript network, tree, dendrogram, and Sankey graphs from R. [rCharts](https://github.com/ramnathv/rCharts) (not on CRAN) and [clickme](https://github.com/nachocab/clickme) (not on CRAN) allow for interactive Javascript charts from R. [animint](https://github.com/tdhock/animint) (not on CRAN) allows an interactive animation to be defined using a list of ggplots with clickSelects and showSelected aesthetics, then exported to CSV/JSON/D3/JavaScript for viewing in a web browser. [rVega](https://github.com/metagraf/rVega) (not on CRAN) is an R wrapper for Vega.

**Social Media Clients**

-   [plusser](http://cran.rstudio.com/web/packages/plusser/index.html) has been designed to to facilitate the retrieval of Google+ profiles, pages and posts. It also provides search facilities. Currently a Google+ API key is required for accessing Google+ data.
-   [Rfacebook](http://cran.rstudio.com/web/packages/Rfacebook/index.html) provides an interface to the Facebook API.
-   The [Rflickr](http://www.Omegahat.org/Rflickr/) package provides an interface to the Flickr photo management and sharing application Web service. (not on CRAN)
-   [instaR](http://cran.rstudio.com/web/packages/instaR/index.html) ([GitHub](https://github.com/pablobarbera/instaR)) is a client for the [Instagram API](https://instagram.com/developer/).
-   [Rlinkedin](https://github.com/mpiccirilli/Rlinkedin) (not on CRAN) is a client for the LinkedIn API. Auth is via OAuth.
-   [SocialMediaMineR](http://cran.rstudio.com/web/packages/SocialMediaMineR/index.html) is an analytic tool that returns information about the popularity of a URL on social media sites.
-   [tumblR](http://cran.rstudio.com/web/packages/tumblR/index.html) ([GitHub](https://github.com/klapaukh/tumblR)) is a client for the Tumblr API ([https://www.tumblr.com/docs/en/api/v2](https://www.tumblr.com/docs/en/api/v2)). Tumblr is a microblogging platform and social networking website [https://www.tumblr.com](https://www.tumblr.com).
-   *Twitter*: [twitteR](http://cran.rstudio.com/web/packages/twitteR/index.html) provides an interface to the Twitter web API. [RTwitterAPI](https://github.com/joyofdata/RTwitterAPI) (not on CRAN) is yet another Twitter client. [twitterreport](https://github.com/gvegayon/twitterreport) (not on CRAN) focuses on report generation based on Twitter data. [streamR](http://cran.rstudio.com/web/packages/streamR/index.html) provides a series of functions that allow users to access Twitter's filter, sample, and user streams, and to parse the output into data frames. OAuth authentication is supported. [tweet2r](http://cran.rstudio.com/web/packages/tweet2r/index.html) is an alternative iplementation geared toward SQLite and postGIS databases. [tweetscores](https://github.com/pablobarbera/twitter_ideology/tree/master/pkg/tweetscores) (not on CRAN) implements a political ideology scaling measure for specified Twitter users.

**Web Analytics Services**

-   *Google Trends*: [GTrendsR](https://github.com/dvanclev/GTrendsR) (not on CRAN) offers functions to perform and display Google Trends queries. Another GitHub package ([rGtrends](https://github.com/emhart/rGtrends)) is now deprecated, but supported a previous version of Google Trends and may still be useful for developers. [RGoogleTrends](http://www.Omegahat.org/RGoogleTrends/) provides another alternative.
-   *Google Analytics*: [RGoogleAnalytics](http://cran.rstudio.com/web/packages/RGoogleAnalytics/index.html) ([GitHub](https://github.com/Tatvic/RGoogleAnalytics/issues)), [ganalytics](https://github.com/jdeboer/ganalytics) ([GitHub](https://github.com/jdeboer/ganalytics); not on CRAN), [GAR](http://cran.rstudio.com/web/packages/GAR/index.html) ([GitHub](https://github.com/andrewgeisler/GAR)), and [RGA](http://cran.rstudio.com/web/packages/RGA/index.html) provide functions for accessing and retrieving data from the [Google Analytics APIs](https://developers.google.com/analytics/). The latter supports OAuth 2.0 authorization. [RGA](http://cran.rstudio.com/web/packages/RGA/index.html) provides a shiny app to explore data. [searchConsoleR](https://github.com/MarkEdmondson1234/searchConsoleR) (not on CRAN) links to the [Google Search Console](https://developers.google.com/webmaster-tools/) (formerly Webmaster Tools).
-   *Other services*: [rgauges](http://cran.rstudio.com/web/packages/rgauges/index.html) provides functions to interact with the Gaug.es API. Gaug.es is a web analytics service, like Google analytics. You have to have a Gaug.es account to use this package. [RSiteCatalyst](http://cran.rstudio.com/web/packages/RSiteCatalyst/index.html) has functions for accessing the Adobe Analytics (Omniture SiteCatalyst) Reporting API.
-   [RAdwords](http://cran.rstudio.com/web/packages/RAdwords/index.html) ([GitHub](https://github.com/jburkhardt/RAdwords)) is a package for loading Google Adwords data.
-   [anametrix](http://cran.rstudio.com/web/packages/anametrix/index.html) is a bidirectional connector to the Anametrix API.
-   [webreadr](http://cran.rstudio.com/web/packages/webreadr/index.html) ([GitHub](https://github.com/Ironholds/webreadr)) can process various common forms of request log, including the Common and Combined Web Log formats and AWS logs.
-   [ApacheLogProcessor](http://cran.rstudio.com/web/packages/ApacheLogProcessor/index.html) ([GitHub](https://github.com/diogosmendonca/ApacheLogProcessor)) can process Apache Web Server log files.

**Other Web Services**

-   *Push Notifications*: [RPushbullet](http://cran.rstudio.com/web/packages/RPushbullet/index.html) provides an easy-to-use interface for the Pushbullet service which provides fast and efficient notifications between computers, phones and tablets. [pushoverr](http://cran.rstudio.com/web/packages/pushoverr/index.html) ([GitHub](https://github.com/briandconnelly/pushoverr)) can sending push notifications to mobile devices (iOS and Android) and desktop using [Pushover](https://pushover.net/).
-   *Reference/bibliography/citation management*: [RefManageR](http://cran.rstudio.com/web/packages/RefManageR/index.html) imports and manage BibTeX and BibLaTeX references with RefManager. [RMendeley](http://cran.rstudio.com/src/contrib/Archive/RMendeley/): Implementation of the Mendeley API in R. Archived on CRAN. It's been archived on CRAN temporarily until it is updated for the new Mendeley API. [rmetadata](https://github.com/ropensci/rmetadata) (not on CRAN) can get scholarly metadata from around the web. [rorcid](http://cran.rstudio.com/web/packages/rorcid/index.html) ([GitHub](https://github.com/ropensci/rorcid)) is a programmatic interface the [Orcid.org](http://orcid.org/) API, which can be used for identifying scientific authors and their publications (e.g., by DOI). [rplos](http://cran.rstudio.com/web/packages/rplos/index.html) is a programmatic interface to the Web Service methods provided by the Public Library of Science journals for search. [rpubmed](https://github.com/rOpenHealth/rpubmed) (not on CRAN) provides tools for extracting and processing Pubmed and Pubmed Central records. [scholar](http://cran.rstudio.com/web/packages/scholar/index.html) provides functions to extract citation data from Google Scholar. Convenience functions are also provided for comparing multiple scholars and predicting future h-index values. [pubmed.mineR](http://cran.rstudio.com/web/packages/pubmed.mineR/index.html) is a package for text mining of [PubMed Abstracts](http://www.ncbi.nlm.nih.gov/pubmed) that supports fetching text and XML from PubMed. [oai](http://cran.rstudio.com/web/packages/oai/index.html) ([GitHub](https://github.com/sckott/oai)) and [OAIHarvester](http://cran.rstudio.com/web/packages/OAIHarvester/index.html) harvest metadata using the Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) standard. [JSTORr](https://github.com/benmarwick/JSTORr) (Not on CRAN) provides simple text mining of journal articles from JSTOR's Data for Research service. [aRxiv](http://cran.rstudio.com/web/packages/aRxiv/index.html) ([GitHub](https://github.com/ropensci/aRxiv)) is a client for the arXiv API, a repository of electronic preprints for computer science, mathematics, physics, quantitative biology, quantitative finance, and statistics. [alm](http://cran.rstudio.com/web/packages/alm/index.html) is a wrapper to the almetrics API platform developed by PLoS.
-   *Wikipedia*: [WikipediR](http://cran.rstudio.com/web/packages/WikipediR/index.html) ([GitHub](https://github.com/Ironholds/WikipediR)) is a wrapper for the MediaWiki API, aimed particularly at the Wikimedia 'production' wikis, such as Wikipedia. [rwikidata](https://github.com/chgrl/rwikidata) and [WikidataR](https://github.com/Ironholds/WikidataR) (Not on CRAN) can request data from [Wikidata.org](https://www.wikidata.org/wiki/Wikidata:Main_Page), the free knowledgebase. [wikipediatrend](http://cran.rstudio.com/web/packages/wikipediatrend/index.html) ([GitHub](https://github.com/petermeissner/wikipediatrend)) provides access to Wikipedia page access statistics.
-   [bigrquery](http://cran.rstudio.com/web/packages/bigrquery/index.html) ([GitHub](https://github.com/hadley/bigrquery)): An interface to Google's bigquery.
-   [colourlovers](http://cran.rstudio.com/web/packages/colourlovers/index.html) ([GitHub](https://github.com/leeper/colourlovers)) extracts colors and multi-color patterns from [COLOURlovers](http://www.colourlovers.com/), for use in creating R graphics color palettes.
-   [cymruservices](http://cran.rstudio.com/web/packages/cymruservices/index.html) queries [Team Cymru](http://team-cymru.org) web security services.
-   [datamart](http://cran.rstudio.com/web/packages/datamart/index.html): Provides an S4 infrastructure for unified handling of internal datasets and web based data sources. Examples include dbpedia, eurostat and sourceforge.
-   [discgolf](https://github.com/sckott/discgolf) (not on CRAN): Provides a client to interact with the API for the [Discourse](http://www.discourse.org/) web forum platform. The API is for an installed instance of Discourse, not for the Discourse site itself.
-   [factualR](http://cran.rstudio.com/web/packages/factualR/index.html): Thin wrapper for the [Factual.com](http://factual.com/) server API.
-   [fitbitScraper](http://cran.rstudio.com/web/packages/fitbitScraper/index.html) ([GitHub](https://github.com/corynissen/fitbitScraper)) retrieves Fitbit data.
-   [GFusionTables](http://gfusiontables.lopatenko.com/) (not on CRAN): An interface to Google Fusion Tables. Google Fusion Tables is a data management system in the cloud. This package provides functions to browse Fusion Tables catalog, retrieve data from Gusion Tables dtd storage to R and to upload data from R to Fusion Tables
-   [infochimps](http://cran.rstudio.com/src/contrib/Archive/infochimps/) ([GitHub](https://github.com/drewconway/infochimps); archived) is an R wrapper for the infochimps.com API services.
-   [internetarchive](https://github.com/lmullen/internetarchive) ([GitHub](https://github.com/ropensci/internetarchive); not on CRAN): API client for internet archive metadata.
-   [jSonarR](http://cran.rstudio.com/web/packages/jSonarR/index.html): Enables users to access MongoDB by running queries and returning their results in data.frames. jSonarR uses data processing and conversion capabilities in the jSonar Analytics Platform and the [JSON Studio Gateway](http://www.jsonstudio.com), to convert JSON to a tabular format.
-   [lucr](http://cran.rstudio.com/web/packages/lucr/index.html) performs currency conversions using [Open Exchange Rates](https://openexchangerates.org/).
-   [randNames](http://cran.rstudio.com/web/packages/randNames/index.html) ([GitHub](https://github.com/karthik/randNames)) generates random names and personal identifying information using the [https://randomapi.com](https://randomapi.com) API.
-   [Rbitcoin](http://cran.rstudio.com/web/packages/Rbitcoin/index.html) allows both public and private API calls to interact with Bitcoin. [rbitcoinchartsapi](http://cran.rstudio.com/web/packages/rbitcoinchartsapi/index.html) is a package for the [BitCoinCharts.com](http://bitcoincharts.com/) API. From their website: "Bitcoincharts provides financial and technical data related to the Bitcoin network and this data can be accessed via a JSON application programming interface (API)." [RCryptsy](http://cran.rstudio.com/web/packages/RCryptsy/index.html) ([GitHub](https://github.com/ropensci/RCryptsy)) wraps the API for the [Cryptsy](http://www.cryptsy.com) crypto-currency trading platform.
-   [RBitly](http://cran.rstudio.com/web/packages/RBitly/index.html) ([GitHub](https://github.com/dmpe/rbitly)): An interface to the [bit.ly](http://bit.ly) link-shortening API.
-   [Rblpapi](https://github.com/armstrtw/Rblpapi) ([GitHub](https://github.com/armstrtw/Rblpapi)) is a client for Bloomberg Finance L.P.
-   [rerddap](https://github.com/ropensci/rerddap) ([GitHub](https://github.com/ropensci/rerddap); not on CRAN): A generic R client to interact with any ERDDAP instance, which is a special case of OPeNDAP ([https://en.wikipedia.org/wiki/OPeNDAP](https://en.wikipedia.org/wiki/OPeNDAP)), or *Open-source Project for a Network Data Access Protocol*. Allows user to swap out the base URL to use any ERDDAP instance.
-   [ripplerestr](https://github.com/hmalmedal/ripplerestr) provides an interface to the [Ripple](https://ripple.com/) protocol for making financial transactions.
-   [restimizeapi](http://cran.rstudio.com/web/packages/restimizeapi/index.html) provides an interface to trading website [estimize.com](http://www.estimize.com).
-   [Rgoodreads](https://github.com/dsidavis/Rgoodreads) (not on CRAN) interacts with [Goodreads](https://www.goodreads.com/).
-   [RLastFM](http://cran.rstudio.com/src/contrib/Archive/RLastFM/): A package to interface to the last.fm API. Archived on CRAN.
-   [RForcecom](http://cran.rstudio.com/web/packages/RForcecom/index.html): RForcecom provides a connection to Force.com and Salesforce.com.
-   [shopifyr](http://cran.rstudio.com/web/packages/shopifyr/index.html): An interface to the API of the E-commerce service Shopify [http://docs.shopify.com/api](http://docs.shopify.com/api).
-   [slackr](http://cran.rstudio.com/web/packages/slackr/index.html) ([GitHub](https://github.com/hrbrmstr/slackr)) is a client for Slack.com messaging platform.
-   [stackr](https://github.com/dgrtwo/stackr) (not on CRAN): An unofficial wrapper for the read-only features of the [Stack Exchange API](https://api.stackexchange.com/).
-   [telegram](http://cran.rstudio.com/web/packages/telegram/index.html) ([GitHub](http://github.com/lbraglia/telegram)) connects with the [Telegram Bot API](http://core.telegram.org/bots/api).
-   [tuber](https://github.com/soodoku/tuber) (not on CRAN): A YouTube API client.
-   [yummlyr](http://cran.rstudio.com/web/packages/yummlyr/index.html) ([GitHub](https://github.com/RomanTsegelskyi/yummlyr)) provides an interface to the [Yummly](https://developer.yummly.com/) recipe database.
-   [zendeskR](http://cran.rstudio.com/web/packages/zendeskR/index.html): This package provides a wrapper for the Zendesk API.

### CRAN packages:

-   [alm](http://cran.rstudio.com/web/packages/alm/index.html)
-   [anametrix](http://cran.rstudio.com/web/packages/anametrix/index.html)
-   [ApacheLogProcessor](http://cran.rstudio.com/web/packages/ApacheLogProcessor/index.html)
-   [aRxiv](http://cran.rstudio.com/web/packages/aRxiv/index.html)
-   [AzureML](http://cran.rstudio.com/web/packages/AzureML/index.html)
-   [bigml](http://cran.rstudio.com/web/packages/bigml/index.html)
-   [bigrquery](http://cran.rstudio.com/web/packages/bigrquery/index.html)
-   [boilerpipeR](http://cran.rstudio.com/web/packages/boilerpipeR/index.html)
-   [captr](http://cran.rstudio.com/web/packages/captr/index.html)
-   [clarifai](http://cran.rstudio.com/web/packages/clarifai/index.html)
-   [colourlovers](http://cran.rstudio.com/web/packages/colourlovers/index.html)
-   [curl](http://cran.rstudio.com/web/packages/curl/index.html)
-   [cymruservices](http://cran.rstudio.com/web/packages/cymruservices/index.html)
-   [d3Network](http://cran.rstudio.com/web/packages/d3Network/index.html)
-   [datamart](http://cran.rstudio.com/web/packages/datamart/index.html)
-   [ddeploy](http://cran.rstudio.com/web/packages/ddeploy/index.html)
-   [downloader](http://cran.rstudio.com/web/packages/downloader/index.html)
-   [dvn](http://cran.rstudio.com/web/packages/dvn/index.html)
-   [factualR](http://cran.rstudio.com/web/packages/factualR/index.html)
-   [fitbitScraper](http://cran.rstudio.com/web/packages/fitbitScraper/index.html)
-   [GAR](http://cran.rstudio.com/web/packages/GAR/index.html)
-   [genderizeR](http://cran.rstudio.com/web/packages/genderizeR/index.html)
-   [geocodeHERE](http://cran.rstudio.com/web/packages/geocodeHERE/index.html)
-   [ggmap](http://cran.rstudio.com/web/packages/ggmap/index.html)
-   [ggvis](http://cran.rstudio.com/web/packages/ggvis/index.html)
-   [gistr](http://cran.rstudio.com/web/packages/gistr/index.html)
-   [git2r](http://cran.rstudio.com/web/packages/git2r/index.html)
-   [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html)
-   [gmailr](http://cran.rstudio.com/web/packages/gmailr/index.html)
-   [googlesheets](http://cran.rstudio.com/web/packages/googlesheets/index.html)
-   [googleVis](http://cran.rstudio.com/web/packages/googleVis/index.html)
-   [gsheet](http://cran.rstudio.com/web/packages/gsheet/index.html)
-   [httpRequest](http://cran.rstudio.com/web/packages/httpRequest/index.html)
-   [httpuv](http://cran.rstudio.com/web/packages/httpuv/index.html)
-   [httr](http://cran.rstudio.com/web/packages/httr/index.html) (core)
-   [imguR](http://cran.rstudio.com/web/packages/imguR/index.html)
-   [indicoio](http://cran.rstudio.com/web/packages/indicoio/index.html)
-   [instaR](http://cran.rstudio.com/web/packages/instaR/index.html)
-   [jSonarR](http://cran.rstudio.com/web/packages/jSonarR/index.html)
-   [jsonlite](http://cran.rstudio.com/web/packages/jsonlite/index.html) (core)
-   [jug](http://cran.rstudio.com/web/packages/jug/index.html)
-   [leafletR](http://cran.rstudio.com/web/packages/leafletR/index.html)
-   [longurl](http://cran.rstudio.com/web/packages/longurl/index.html)
-   [lucr](http://cran.rstudio.com/web/packages/lucr/index.html)
-   [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html)
-   [mailR](http://cran.rstudio.com/web/packages/mailR/index.html)
-   [mime](http://cran.rstudio.com/web/packages/mime/index.html)
-   [MTurkR](http://cran.rstudio.com/web/packages/MTurkR/index.html)
-   [oai](http://cran.rstudio.com/web/packages/oai/index.html)
-   [OAIHarvester](http://cran.rstudio.com/web/packages/OAIHarvester/index.html)
-   [opencpu](http://cran.rstudio.com/web/packages/opencpu/index.html)
-   [osmar](http://cran.rstudio.com/web/packages/osmar/index.html)
-   [plotGoogleMaps](http://cran.rstudio.com/web/packages/plotGoogleMaps/index.html)
-   [plotKML](http://cran.rstudio.com/web/packages/plotKML/index.html)
-   [plusser](http://cran.rstudio.com/web/packages/plusser/index.html)
-   [pubmed.mineR](http://cran.rstudio.com/web/packages/pubmed.mineR/index.html)
-   [pushoverr](http://cran.rstudio.com/web/packages/pushoverr/index.html)
-   [radiant](http://cran.rstudio.com/web/packages/radiant/index.html)
-   [RAdwords](http://cran.rstudio.com/web/packages/RAdwords/index.html)
-   [randNames](http://cran.rstudio.com/web/packages/randNames/index.html)
-   [rapport](http://cran.rstudio.com/web/packages/rapport/index.html)
-   [Rbitcoin](http://cran.rstudio.com/web/packages/Rbitcoin/index.html)
-   [rbitcoinchartsapi](http://cran.rstudio.com/web/packages/rbitcoinchartsapi/index.html)
-   [RBitly](http://cran.rstudio.com/web/packages/RBitly/index.html)
-   [RCryptsy](http://cran.rstudio.com/web/packages/RCryptsy/index.html)
-   [RCurl](http://cran.rstudio.com/web/packages/RCurl/index.html) (core)
-   [RDataCanvas](http://cran.rstudio.com/web/packages/RDataCanvas/index.html)
-   [redcapAPI](http://cran.rstudio.com/web/packages/redcapAPI/index.html)
-   [RefManageR](http://cran.rstudio.com/web/packages/RefManageR/index.html)
-   [repmis](http://cran.rstudio.com/web/packages/repmis/index.html)
-   [restimizeapi](http://cran.rstudio.com/web/packages/restimizeapi/index.html)
-   [Rfacebook](http://cran.rstudio.com/web/packages/Rfacebook/index.html)
-   [rfigshare](http://cran.rstudio.com/web/packages/rfigshare/index.html)
-   [RForcecom](http://cran.rstudio.com/web/packages/RForcecom/index.html)
-   [RGA](http://cran.rstudio.com/web/packages/RGA/index.html)
-   [rgauges](http://cran.rstudio.com/web/packages/rgauges/index.html)
-   [rgeolocate](http://cran.rstudio.com/web/packages/rgeolocate/index.html)
-   [RGoogleAnalytics](http://cran.rstudio.com/web/packages/RGoogleAnalytics/index.html)
-   [RgoogleMaps](http://cran.rstudio.com/web/packages/RgoogleMaps/index.html)
-   [rio](http://cran.rstudio.com/web/packages/rio/index.html)
-   [rjson](http://cran.rstudio.com/web/packages/rjson/index.html)
-   [RJSONIO](http://cran.rstudio.com/web/packages/RJSONIO/index.html)
-   [rLTP](http://cran.rstudio.com/web/packages/rLTP/index.html)
-   [Rmonkey](http://cran.rstudio.com/web/packages/Rmonkey/index.html)
-   [ROAuth](http://cran.rstudio.com/web/packages/ROAuth/index.html)
-   [Rook](http://cran.rstudio.com/web/packages/Rook/index.html)
-   [rorcid](http://cran.rstudio.com/web/packages/rorcid/index.html)
-   [rplos](http://cran.rstudio.com/web/packages/rplos/index.html)
-   [RPushbullet](http://cran.rstudio.com/web/packages/RPushbullet/index.html)
-   [rsdmx](http://cran.rstudio.com/web/packages/rsdmx/index.html)
-   [RSelenium](http://cran.rstudio.com/web/packages/RSelenium/index.html)
-   [RSiteCatalyst](http://cran.rstudio.com/web/packages/RSiteCatalyst/index.html)
-   [rvest](http://cran.rstudio.com/web/packages/rvest/index.html)
-   [scholar](http://cran.rstudio.com/web/packages/scholar/index.html)
-   [scrapeR](http://cran.rstudio.com/web/packages/scrapeR/index.html)
-   [sendmailR](http://cran.rstudio.com/web/packages/sendmailR/index.html)
-   [servr](http://cran.rstudio.com/web/packages/servr/index.html)
-   [shiny](http://cran.rstudio.com/web/packages/shiny/index.html) (core)
-   [shopifyr](http://cran.rstudio.com/web/packages/shopifyr/index.html)
-   [slackr](http://cran.rstudio.com/web/packages/slackr/index.html)
-   [SocialMediaMineR](http://cran.rstudio.com/web/packages/SocialMediaMineR/index.html)
-   [streamR](http://cran.rstudio.com/web/packages/streamR/index.html)
-   [telegram](http://cran.rstudio.com/web/packages/telegram/index.html)
-   [threewords](http://cran.rstudio.com/web/packages/threewords/index.html)
-   [tidyjson](http://cran.rstudio.com/web/packages/tidyjson/index.html)
-   [tm.plugin.webmining](http://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html)
-   [transcribeR](http://cran.rstudio.com/web/packages/transcribeR/index.html)
-   [translate](http://cran.rstudio.com/web/packages/translate/index.html)
-   [translateR](http://cran.rstudio.com/web/packages/translateR/index.html)
-   [tumblR](http://cran.rstudio.com/web/packages/tumblR/index.html)
-   [tweet2r](http://cran.rstudio.com/web/packages/tweet2r/index.html)
-   [twitteR](http://cran.rstudio.com/web/packages/twitteR/index.html)
-   [urlshorteneR](http://cran.rstudio.com/web/packages/urlshorteneR/index.html)
-   [urltools](http://cran.rstudio.com/web/packages/urltools/index.html)
-   [V8](http://cran.rstudio.com/web/packages/V8/index.html)
-   [W3CMarkupValidator](http://cran.rstudio.com/web/packages/W3CMarkupValidator/index.html)
-   [webreadr](http://cran.rstudio.com/web/packages/webreadr/index.html)
-   [webutils](http://cran.rstudio.com/web/packages/webutils/index.html)
-   [whisker](http://cran.rstudio.com/web/packages/whisker/index.html)
-   [wikipediatrend](http://cran.rstudio.com/web/packages/wikipediatrend/index.html)
-   [WikipediR](http://cran.rstudio.com/web/packages/WikipediR/index.html)
-   [WufooR](http://cran.rstudio.com/web/packages/WufooR/index.html)
-   [XML](http://cran.rstudio.com/web/packages/XML/index.html) (core)
-   [xml2](http://cran.rstudio.com/web/packages/xml2/index.html)
-   [XML2R](http://cran.rstudio.com/web/packages/XML2R/index.html)
-   [yhatr](http://cran.rstudio.com/web/packages/yhatr/index.html)
-   [yummlyr](http://cran.rstudio.com/web/packages/yummlyr/index.html)
-   [zendeskR](http://cran.rstudio.com/web/packages/zendeskR/index.html)

### Related links:

-   [Open Data TaskView](https://github.com/ropensci/opendata)

