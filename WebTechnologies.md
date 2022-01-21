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
with the web from R. `r pkg("crul")` is an R6-based HTTP client that provides asynchronous HTTP
requests, a pagination helper, HTTP mocking via `r pkg("webmockr")`, and request caching for
unit tests via `r pkg("vcr")`.
crul targets R developers more so than end users. `r pkg("httr")` provides more of a user facing
client for HTTP requests and differentiates from the former package in that it
provides support for OAuth. Note that you can pass in additional curl options
when you instantiate R6 classes in crul, and the `config` parameter in httr.
`r pkg("curl")` is a lower-level
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

  - `r pkg("RCurl")` is another
    low level client for libcurl. Of the two low-level curl clients, we
    recommend using `r pkg("curl")`. `r pkg("httpRequest")` is another low-level package for HTTP requests that
    implements the GET, POST and multipart POST verbs, but we do not recommend
    its use.
  - `r pkg("request")`
    provides a high-level package that is useful for developing other API client
    packages. `r pkg("httping")` provides simplified tools to ping and time HTTP requests, around
    `r pkg("httr")` calls.
    `r pkg("httpcache")`
    provides a mechanism for caching HTTP requests.
  - For dynamically generated webpages (i.e., those requiring user interaction
    to display results), `r pkg("RSelenium")` can be used to automate those interactions and extract
    page contents. It provides a set of bindings for the Selenium 2.0 webdriver
    using the `r pkg("JsonWireProtocol")`. It can also aid in automated application testing, load
    testing, and web scraping. `r pkg("seleniumPipes")` provides a “pipe”-oriented interface to the
    same. An alternative to the former two packages is `r pkg("splashr")` that vouches to be a
    lightweight altnernative. [<span class="GitHub">rdom</span>](https://
    github.com/cpsievert/rdom/) (not on CRAN) uses `r pkg("phantomjs")` to access a webpage’s Document Object Model (DOM).
  - For capturing static content of web pages `r pkg("postlightmercury")` is a client for
    the web service `r pkg("Mercury")` that turns web
    pages into structured and clean text.
  - Another, higher-level alternative package useful for webscraping is
    `r pkg("rvest")`, which is
    designed to work with `r pkg("magrittr")` to make it easy to express common web scraping tasks.
  - Many base R tools can be used to download web content, provided that the
    website does not use SSL (i.e., the URL does not have the “https” prefix).
    `download.file()` is a general purpose function that can be used to download
    a remote file. For SSL, the `download()` function in `r pkg("downloader")` wraps
    `download.file()`, and takes all the same arguments.
  - Tabular data sets (e.g., txt, csv, etc.) can be input using `read.table()`,
    `read.csv()`, and friends, again assuming that the files are not hosted via
    SSL. An alternative is to use `httr::GET` (or `RCurl::getURL`) to first read
    the file into R as a character vector before parsing with
    `read.table(text=...)`, or you can download the file to a local directory.
    `r pkg("rio")`
    provides an `import()` function
    that can read a number of common data formats directly from an https://
    URL. The `r pkg("repmis")`
    function `source_data()` can load and cache plain-text data from a URL
    (either http or https). That package also includes `source_Dropbox()` for
    downloading/caching plain-text data from non-public Dropbox folders and
    `source_XlsxData()` for downloading/caching Excel xlsx sheets.
  - *Authentication*: Using web resources can require authentication, either
    via API keys, OAuth, username:password combination, or via other means.
    Additionally, sometimes web resources that require authentication be in the
    header of an http call, which requires a little bit of extra work. API keys
    and username:password combos can be combined within a url for a call to a
    web resource, or can be specified via commands in `r pkg("RCurl")` or `r pkg("httr")`. OAuth is the most
    complicated authentication process, and can be most easily done using
    `r pkg("httr")`. See the 6
    demos within `r pkg("httr")`,
    three for OAuth 1.0 (linkedin, twitter, vimeo) and three for OAuth 2.0
    (facebook, GitHub, google). `r pkg("ROAuth")` is a package that provides a separate R interface to
    OAuth. OAuth is easier to to do in `r pkg("httr")`, so start there. `r pkg("googleAuthR")` provides an OAuth 2.0
    setup specifically for Google web services, and `r pkg("AzureAuth")` provides similar
    functionality for Azure Active Directory.

**Handling HTTP Errors/Codes**

  - `r pkg("fauxpas")` brings
    a set of Ruby or Python like R6 classes for each individual HTTP status
    code, allowing simple and verbose messages, with a choice of using messages,
    warnings, or stops.
  - `r pkg("httpcode")` is a
    simple package to help a user/package find HTTP status codes and associated
    messages by name or number.

**Parsing Structured Web Data**

The vast majority of web-based data is structured as plain text, HTML, XML, or
JSON (javascript object notation). Web service APIs increasingly rely on JSON,
but XML is still prevalent in many applications. There are several packages for
specifically working with these format. These functions can be used to interact
directly with insecure web pages or can be used to parse locally stored or in-
memory web files.

  - *XML*: There are two packages for working with XML: `r pkg("XML")` and `r pkg("xml2")` ( ). Both support general XML (and HTML) parsing, including XPath
    queries. The package `r pkg("xml2")` is less fully featured, but more user friendly with respect to
    memory management, classes (e.g., XML node vs. node set vs. document), and
    namespaces. Of the two, only the `r pkg("XML")` supports *de novo* creation of XML nodes and
    documents. The `r pkg("XML2R")`package is a
    collection of convenient functions for coercing XML into data frames. An
    alternative to `r pkg("XML")`
    is `r pkg("selectr")`, which parses CSS3
    Selectors and translates them to XPath 1.0 expressions. `r pkg("XML")` package is often used for
    parsing xml and html, but selectr translates CSS selectors to XPath, so can
    use the CSS selectors instead of XPath.
  - *HTML*: All of the tools that work with XML also work for HTML, though HTML
    is - in practice - more prone to be malformed. Some tools are designed
    specifically to work with HTML. `xml2::read_html()` is a good first function
    to use for importing HTML. `r pkg("htmltools")` provides functions to create HTML elements.
    The [selectorgadget browser extension](https://selectorgadget.com/) can be
    used to identify page elements. [<span class="Ohat">RHTMLForms</
    span>](http://www.Omegahat.net/RHTMLForms/) reads HTML documents and
    obtains a description of each of the forms it contains, along with the
    different elements and hidden fields. `r pkg("scrapeR")` provides additional tools for scraping
    data from HTML documents.
    `r pkg("htmltidy")`
    provides tools to “tidy”
    messy HTML documents. `r pkg("htm2txt")` uses regex to converts html documents to plain text by
    removing all html tags. `r pkg("Rcrawler")` does crawling and scraping of web pages.
  - *JSON*: There are several packages for reading and writing JSON:
    `r pkg("rjson")`,
    `r pkg("RJSONIO")`, and
    `r pkg("jsonlite")`.
    `r pkg("jsonlite")`
    includes a different parser from `r pkg("RJSONIO")` called `r pkg("yajl")` .
    We recommend using `r pkg("jsonlite")`. Check out the paper describing jsonlite by Jeroen
    Ooms <https://arxiv.org/abs/1403.2805>. `r pkg("jqr")` provides bindings for the fast JSON library,
    `r pkg("jq")`. `r pkg("jsonvalidate")` validates JSON against a schema using
    the “is-my-json-valid” Javascript library; `r pkg("ajv")` does the same using the ajv Javascript
    library. `r pkg("ndjson")`
    supports the “ndjson”
    format.
  - *RSS/Atom*: `r pkg("feedeR")` can be used to parse RSS or Atom feeds. `r pkg("tidyRSS")` parses RSS, Atom XML/JSON
    and geoRSS into a tidy data.frame.
  - `r pkg("swagger")` can be
    used to automatically generate functions for working with an web service API
    that provides documentation in [Swagger.io](https://swagger.io/) format.

**Tools for Working with URLs**

  - The `httr::parse_url()` function can be used to extract portions of a URL.
    The `RCurl::URLencode()` and `utils::URLencode()` functions can be used to
    encode character strings for use in URLs. `utils::URLdecode()` decodes back
    to the original strings. `r pkg("urltools")` can
    also handle URL encoding, decoding, parsing, and parameter extraction.
  - `r pkg("iptools")` can
    facilitate working with IPv4 addresses, including for use in geolocation. A
    similar package `r pkg("ipaddress")`, handles IPv4 and IPv6 addresses and networks.
  - `r pkg("urlshorteneR")` offers URL expansion and analysis for Bit.ly, Goo.gl, and is.gd.
    `r pkg("longurl")` uses the
    longurl.org API to provide similar functionality.
  - `r pkg("gdns")` provides
    access to Google’s secure HTTP-based DNS resolution service.

**Tools for Working with Scraped Webpage Contents**

  - Several packages can be used for parsing HTML documents.
  `r pkg("boilerpipeR")`
  provides generic extraction of main text content from HTML files; removal of
  ads, sidebars and headers using the boilerpipe Java library. [<span
  class="Ohat">RTidyHTML</span>](http://www.Omegahat.net/RTidyHTML/) interfaces
  to the libtidy library for correcting HTML documents that are not well-
  formed. This library corrects common errors in HTML documents.
  `r pkg("W3CMarkupValidator")` provides an R Interface to W3C Markup Validation Services for
  validating HTML documents.
  - For XML documents, the [<span class="Ohat">XMLSchema</span>](http://
    www.Omegahat.net/XMLSchema/) package provides facilities in R for reading
    XML schema documents and processing them to create definitions for R
    classes and functions for converting XML nodes to instances of those
    classes. It provides the framework for meta-computing with XML schema in R.
    `r pkg("xslt")` is an
    extension for the `r pkg("xml2")` package to transform XML documents by applying an xslt style-
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
  - `r pkg("webshot")` uses
    `r pkg("PhantomJS")` to provide screenshots of web pages
    without a browser. It can be useful for testing websites (such as Shiny
    applications).

**Security**

  - `r pkg("securitytxt")`
    identifies and parses web Security policy files.

**Other Useful Packages and Functions**

  - *Javascript*: `r pkg("V8")` is
    an R interface to Google’s open source, high performance JavaScript engine.
    It can wrap Javascript libraries as well as NPM packages. The [<span
    class="Ohat">SpiderMonkey</span>](http://www.Omegahat.net/SpiderMonkey/)
    package provides another means of evaluating JavaScript code, creating
    JavaScript objects and calling JavaScript functions and methods from within
    R. This can work by embedding the JavaScript engine within an R session or
    by embedding R in an browser such as Firefox and being able to call R from
    JavaScript and call back to JavaScript from R. The `r pkg("js")` package wraps `r pkg("V8")` and validates, reformats,
    optimizes and analyzes JavaScript code.
  - *Email:*: `r pkg("mailR")`
    is an interface to Apache Commons Email to send emails from within R.
    `r pkg("sendmailR")`
    provides a simple SMTP client. `r pkg("gmailr")` provides access the Google’s gmail.com RESTful
    API.
    `r pkg("Microsoft365R")` provides a client for Microsoft’s Outlook email service, both
    personal (outlook.com) and as part of the Microsoft 365 (formerly known as
    Office 365) suite.
  - *Mocking:*: `r pkg("webmockr")` is a library for stubbing and setting expectations on HTTP
    requests. It is inspired from Rubys `webmock`. This package only helps mock
    HTTP requests, and returns nothing when requests match expectations.
    webmockr integrates with the HTTP packages `r pkg("crul")` and `r pkg("httr")`. See *Testing* for mocking with returned
    responses.
  - *Testing:*: `r pkg("vcr")`
    provides an interface to easily cache HTTP requests in R package test suites
    (but can be used outside of testing use cases as well). vcr relies on
    `r pkg("webmockr")` to do
    the HTTP request mocking. vcr integrates with the HTTP packages
    `r pkg("crul")` and
    `r pkg("httr")`.
    `r pkg("httptest")`
    provides a framework for testing packages that communicate with HTTP APIs,
    offering tools for mocking APIs, for recording real API responses for use
    as mocks, and for making assertions about HTTP requests, all without
    requiring a live connection to the API server at runtime. httptest only
    works with httr.
  - *Miscellaneous*: `r pkg("webutils")` contains various functions for developing web applications,
    including parsers for `application/x-www-form-urlencoded` as well as
    `multipart/form-data`. `r pkg("mime")` guesses the MIME type
    for a file from its extension. `r pkg("rsdmx")` provides tools to read data and metadata documents
    exchanged through the Statistical Data and Metadata Exchange (SDMX)
    framework. The package currently focuses on the SDMX XML standard format
    (SDMX-ML). `r pkg("robotstxt")` provides functions and classes for parsing robots.txt files and
    checking access permissions; `r pkg("spiderbar")` does the same. `r pkg("uaparserjs")` uses the javascript [“ua-parser”
    library](https://github.com/ua-parser) to parse User-Agent HTTP headers.
    `r pkg("rapiclient")` is
    a client for consuming APIs that follow the [Open API format](https://
    www.openapis.org/). `r pkg("restfulr")` models a RESTful service as if it were a nested R list.

## Web and Server Frameworks

  - [Model Operationalization](https://docs.microsoft.com/en-us/machine-
    learning-server/what-is-operationalization) (previously DeployR) is a Microsoft product that provides support for deploying R and Python models and code to a server as a web service to later consume.
  - The `r pkg("shiny")` package
    makes it easy to build interactive web applications with R.
  - `r pkg("dash")` is a web
    framework which is available for Python, R and Julia, with components
    written in React.js.
  - Other web frameworks include: `r pkg("fiery")` that is meant to be more flexible but less easy to use
    than shiny (`r pkg("reqres")` and `r pkg("routr")` are utilities used by fiery that provide HTTP request and
    response classes, and HTTP routing, respectively); [<span
    class="GitHub">rcloud</span>](https://github.com/att/rcloud/) provides an
    iPython notebook-style web-based R interface; and `r pkg("Rook")`, which contains the
    specification and convenience software for building and running Rook
    applications.
  - The `r pkg("opencpu")`
    framework for embedded statistical computation and reproducible research exposes a web API interfacing R, LaTeX and Pandoc. This API is used for example to integrate statistical functionality into systems, share and execute scripts or reports on centralized servers, and build R based apps.
  - Several general purpose server/client frameworks for R exist.
    `r pkg("Rserve")` and
    `r pkg("RSclient")`
    provide server and client functionality for TCP/IP or local socket
    interfaces. `r pkg("httpuv")` provides a low-level socket and protocol support for handling
    HTTP and WebSocket requests directly within R. Another related package,
    perhaps which `r pkg("httpuv")` replaces, is `r pkg("websockets")`. `r pkg("servr")` provides a simple HTTP server to serve files under a given
    directory based on httpuv.
  - Several packages offer functionality for turning R code into a web API.
    `r pkg("FastRWeb")`
    provides some basic infrastructure for this. `r pkg("plumber")` allows you to create a REST API by decorating existing R source code. `r pkg("beakr")` provides an R version of functionality found in python Flask and javascript Express.js.
  - The [<span class="Ohat">WADL</span>](http://www.Omegahat.net/WADL/) package
    provides tools to process Web Application Description Language (WADL) documents and to programmatically generate R functions to interface to the REST methods described in those WADL documents. (not on CRAN)
  - The [<span class="Ohat">RDCOMServer</span>](http://www.Omegahat.net/
    RDCOMServer/) provides a mechanism to export R objects as (D)COM objects in Windows. It can be used along with the [<span class="Ohat">RDCOMClient</span>](http://www.Omegahat.net/RDCOMClient/) package which provides user-level access from R to other COM servers. (not on CRAN)
  - [rapporter.net](http://rapporter.net/welcome/en) provides an online
    environment (SaaS) to host and run `r pkg("rapport")` statistical report templates in the cloud.
  - `r pkg("radiant")`
    is Shiny-based GUI for R that runs in a browser from a server or local machine.
  - The `r pkg("Tiki")` Wiki CMS/Groupware
    framework has an R plugin (`r pkg("PluginR")` ) to run R code from wiki pages, and use data from their own collected web databases (trackers). A demo: <https://r.tiki.org/tiki-index.php> .
  - The `r pkg("MediaWiki")` has an extension
    ([Extension:R](https://www.mediawiki.org/wiki/Extension:R) ) to run R code from wiki pages, and use uploaded data. A mailing list used to be available: R-sig-mediawiki.
  - `r pkg("whisker")`:
    Implementation of logicless templating based on `r pkg("Mustache")` in R. Mustache syntax is described in <http://mustache.github.io/mustache.5.html>
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
      - `r pkg("paws")`
        is an interface to nearly all AWS APIs, including compute, storage, databases, and machine learning. It also requires no external system dependencies.
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
        service. `r pkg("AzureAuth")` is an R client for AAD; use this to obtain OAuth tokens for
        authenticating with other Azure services, including Resource Manager
        and storage (see next).
      - *Microsoft Graph* is the API framework for the Microsoft 365 platform,
        including Azure Active Directory and Office. `r pkg("AzureGraph")` is a low-level
        extensible R6-based interface to Graph. `r pkg("Microsoft365R")` is an interface
        to the Office part of Microsoft 365, including OneDrive and SharePoint
        Online.
      - *Azure Resource Manager (ARM)* is a service for deploying other Azure
        services. `r pkg("AzureRMR")` is an R interface to ARM, and allows managing
        subscriptions, resource groups, resources and templates. It exposes a
        general R6 class framework that can extended to provide extra
        functionality for specific services (see next).
      - *Azure Storage Accounts* are a general-purpose data storage facility.
        Different types of storage are available: file, blob, table, Data Lake,
        and more. `r pkg("AzureStor")` provides an R interface to storage. Features include
        clients for file, blob and Data Lake Gen2 storage, parallelized file
        transfers, and an interface to Microsoft’s cross-platform AzCopy
        command line utility. Also supplied is an ARM interface, to allow
        creation and managing of storage accounts. `r pkg("AzureTableStor")` and
        `r pkg("AzureQstor")` extend AzureStor to provide interfaces to table storage and
        queue storage respectively
      - `r pkg("AzureVM")` is
        a package for creating and managing virtual machines in Azure. It
        includes templates for a wide variety of common VM specifications and
        operating systems, including Windows, Ubuntu, Debian and RHEL.
      - `r pkg("AzureContainers")` provides a unified facility for working with containers in
        Azure. Specifically, it includes R interfaces to *Azure Container
        Instances (ACI)*, *Azure Docker Registry (ACR)* and *Azure Kubernetes
        Service (AKS)*. Create Docker images and push them to an ACR
        repository; spin up ACI containers; deploy Kubernetes services in AKS.
      - *Azure Data Explorer*, also known as *Kusto*, is a fast, scalable
        data exploration and analytics service. `r pkg("AzureKusto")` is an R interface
        to ADE/Kusto. It includes a dplyr client interface similar to that
        provided by dbplyr for SQL databases, a DBI client interface, and an
        ARM interface for deploying and managing Kusto clusters and databases.
      - *Azure Cosmos DB* is a multi-model NoSQL database service, previously
        known as Document DB. `r pkg("AzureCosmosR")` is an interface to the core/SQL API
        for Cosmos DB. It also includes simple bridges to the table storage and
        MongoDB APIs.
      - *Azure Computer Vision* and *Azure Custom Vision* are AI services for
        image recognition and analysis. Computer Vision is a pre-trained
        service for handling commonly-encountered tasks, while Custom Vision
        allows you to train your own image recognition model on a custom
        dataset. `r pkg("AzureVision")` provides an interface to both these services.
  - `r pkg("googleComputeEngineR")` interacts with the Google Compute Engine API, and lets you create, start and stop instances in the Google Cloud.
  - *Cloud Storage*: `r pkg("googleCloudStorageR")` interfaces with Google Cloud
    Storage. `r pkg("boxr")`
    is a lightweight, high-level
    interface for the [box.com API](https://developer.box.com/reference/) .
    `r pkg("rdrop2")` is a
    Dropbox interface that provides access to a full suite of file operations,
    including dir/copy/move/delete operations, account information (including
    quotas) and the ability to upload and download files from any Dropbox
    account.
  - *Docker*: `r pkg("analogsea")` is a general purpose client for the Digital Ocean v2 API. In
    addition, the package includes functions to install various R tools
    including base R, RStudio server, and more. There’s an improving interface
    to interact with docker on your remote droplets via this package.
  - `r pkg("crunch")`
     provides an interface to the
    [crunch.io](https://crunch.io/) storage and analytics platform.
    `r pkg("crunchy")`
     facilitates making Shiny
    apps on Crunch.
  - `r pkg("rrefine")`
    provides a client for the `r pkg("OpenRefine")` (formerly Google Refine) data cleaning service.

**Document and Code Sharing**

  - *Code Sharing*: `r pkg("gistr")` works with
    GitHub gists ([gist.github.com](https://gist.github.com/discover) ) from R,
    allowing you to create new gists, update gists with new files, rename
    files, delete files, get and delete gists, star and un-star gists, fork
    gists, open a gist in your default browser, get embed code for a gist, list
    gist commits, and get rate limit information when authenticated.
    `r pkg("git2r")` provides
    bindings to the git version control system and `r pkg("gh")` is a client for the GitHub
    API. `r pkg("gitlabr")` is
    a `r pkg("GitLab")` -specific client.
  - *Data archiving*: `r pkg("dataverse")` (
    ) provides access to Dataverse 4 APIs. `r pkg("rfigshare")` connects with [Figshare.com](https://figshare.com/) .
    `r pkg("dataone")`
    provides a client for
    `r pkg("DataONE")` repositories.
  - *Google Drive/Google Documents*: The [<span class="Ohat">RGoogleDocs</
    span>](http://www.Omegahat.net/RGoogleDocs/) package is an example of using
    the RCurl and XML packages to quickly develop an interface to the Google
    Documents API. [<span class="Ohat">RGoogleStorage</span>](http://
    www.Omegahat.net/RGoogleStorage/) provides programmatic access to the
    Google Storage API. This allows R users to access and store data on
    Google’s storage. We can upload and download content, create, list and
    delete folders/buckets, and set access control permissions on objects and
    buckets.
  - *Google Sheets*: `r pkg("googlesheets")` (
    ) can access private or public Google Sheets by title, key, or URL. Extract
    data or edit data. Create, delete, rename, copy, upload, or download
    spreadsheets and worksheets. `r pkg("gsheet")` can
    download Google Sheets using just the sharing link. Spreadsheets can be
    downloaded as a data frame, or as plain text to parse manually.
  - `r pkg("imguR")`
    is a package to share plots
    using the image hosting service [Imgur.com](https://imgur.com/). knitr
    also has a function `imgur_upload()` to load images from literate
    programming documents.
  - *Teams*, *SharePoint* and *OneDrive*: `r pkg("Microsoft365R")` provides an
    interface to these services, which form part of the Microsoft 365 (formerly
    known as Office 365) suite.

**Data Analysis and Processing Services**

  - *Geospatial/Geolocation/Geocoding*: Several packages connect to geolocation/
    geocoding services. `r pkg("rgeolocate")` ( )
    offers several online and offline tools. [<span class="GitHub">rydn</
    span>](https://github.com/trestletech/rydn/) (not on CRAN) is an interface
    to the Yahoo Developers network geolocation APIs, and [<span
    class="GitHub">ipapi</span>](https://github.com/hrbrmstr/ipapi/) can be
    used to geolocate IPv4/6 addresses and/or domain names using the <http://ip-
    api.com/> API. `r pkg("opencage")` provides
    access to to the `r pkg("OpenCage")` geocoding service.
    [<span class="GitHub">nominatim</span>](https://github.com/hrbrmstr/
    nominatim/) (not on CRAN) connects to the [OpenStreetMap Nominatim
    API](https://github.com/hrbrmstr/nominatim) for reverse geocoding. [<span
    class="GitHub">PostcodesioR</span>](https://github.com/ropensci/
    PostcodesioR/) (not on CRAN) provides post code lookup and geocoding for
    the United Kingdom. `r pkg("geosapi")` is an R client for the `r pkg("GeoServer")` REST
    API, an open source implementation used widely for serving spatial data.
    `r pkg("geonapi")`
    provides an interface to the `r pkg("GeoNetwork")` legacy API, an opensource catalogue for managing geographic metadata.
    `r pkg("ows4R")` is a new R
    client for the `r pkg("OGC")` standard Web-Services,
    such Web Feature Service (WFS) for data and Catalogue Service (CSW) for
    metadata.
  - *Machine Learning as a Service*: Several packages provide access to cloud-
    based machine learning services. `r pkg("OpenML")` ( )
    is the official client for [the OpenML API](https://www.openml.org/frontend/
    page/home). `r pkg("clarifai")` is a
    [Clarifai.com](https://www.clarifai.com/) client that enables automated
    image description. `r pkg("rLTP")` accesses the
    [ltp-cloud service](https://www.ltp-cloud.com/). `r pkg("languagelayeR")` is a client for
    Languagelayer, a language detection API. `r pkg("googlepredictionapi")` (not on CRAN):
    is an R client for the [Google Prediction API](https://cloud.google.com/ai-
    platform), a suite of cloud machine learning tools. `r pkg("yhatr")` lets you deploy, maintain,
    and invoke models via the Yhat REST API. `r pkg("datarobot")` works with Data Robot’s
    predictive modeling platform. `r pkg("mscsweblm4r")` interfaces with the Microsoft Cognitive Services Web
    Language Model API and `r pkg("mscstexta4r")` uses the Microsoft Cognitive Services Text Analytics REST
    API. `r pkg("rosetteApi")` links to the `r pkg("Rosette")` text
    analysis API. `r pkg("googleLanguageR")` provides interfaces to Google’s Cloud
    Translation API, Natural Language API, Cloud Speech API, and the Cloud Text-
    to-Speech API. `r pkg("AzureVision")` provides interfaces to the Azure Computer Vision
    and Custom Vision image recognition services.
  - *Machine Translation*: `r pkg("translate")` provides bindings for the Google Translate API v2 and
    `r pkg("translateR")`
    provides bindings for both Google and Microsoft translation APIs.
    `r pkg("RYandexTranslate")` ( )
    connects to Yandex Translate. `r pkg("transcribeR")` provides automated audio transcription via
    the HP IDOL service.
  - *Document Processing*: `r pkg("abbyyR")`  and
    `r pkg("captr")`
    connect to optical character
    recognition (OCR) APIs. `r pkg("pdftables")` ( )
    uses [the PDFTables.com webservice](https://pdftables.com/) to extract
    tables from PDFs.
  - *Mapping*: `r pkg("osmar")`
    provides infrastructure to access OpenStreetMap data from different sources
    to work with the data in common R manner and to convert data into available
    infrastructure provided by existing R packages (e.g., into sp and igraph
    objects). `r pkg("osrm")`
    provides shortest paths and travel times from OpenStreetMap.
    `r pkg("osmplotr")`
    extracts customizable map
    images from OpenStreetMap. `r pkg("RgoogleMaps")` serves two purposes: it provides a
    comfortable R interface to query the Google server for static maps, and use
    the map as a background image to overlay plots within R. [<span
    class="Ohat">R2GoogleMaps</span>](http://www.Omegahat.net/R2GoogleMaps/)
    provides a mechanism to generate JavaScript code from R that displays data
    using Google Maps. [<span class="Ohat">RKMLDevice</span>](http://
    www.Omegahat.net/RKMLDevice/) allows to create R graphics in Keyhole Markup
    Language (KML) format in a manner that allows them to be displayed on
    Google Earth (or Google Maps), and [<span class="Ohat">RKML</span>](http://
    www.Omegahat.net/RKML/) provides users with high-level facilities to
    generate KML. `r pkg("plotKML")` can visualization spatial and spatio-temporal objects in Google
    Earth. `r pkg("ggmap")`
    allows for the easy visualization of spatial data and models on top of
    Google Maps, OpenStreetMaps, Stamen Maps, or CloudMade Maps using ggplot2.
    `r pkg("mapsapi")` is an
    sf-compatible interface to Google Maps API. `r pkg("leafletR")`: Allows you to display
    your spatial data on interactive web-maps using the open-source JavaScript
    library Leaflet. `r pkg("openadds")` is an
    `r pkg("Openaddresses")` client, and `r pkg("banR")` provides access to the “Base Adresses Nationale” (BAN) API for French addresses.
  - *Online Surveys*: `r pkg("qualtRics")` provide functions to interact with `r pkg("Qualtrics")`. `r pkg("WufooR")` can retrieve
    data from [Wufoo.com](https://www.wufoo.com/) forms. `r pkg("redcapAPI")` and `r pkg("REDCapR")`
    can provide access to data stored in a
    REDCap (Research Electronic Data CAPture) database, which is a web
    application for building and managing online surveys and databases
    developed at Vanderbilt University. [<span class="GitHub">formr</
    span>](https://github.com/rubenarslan/formr/) facilitates use of the
    `r pkg("formr")` survey framework, which is built on openCPU.
    `r pkg("Rexperigen")`
    is a client for the [Experigen experimental platform](https://
    becker.phonologist.org/experigen/) .
  - *Visualization*: Plot.ly is a company that allows you to create
    visualizations in the web using R (and Python), which is accessible via
    `r pkg("plotly")`.
    `r pkg("googleVis")`
    provides an interface between R and the Google chart tools. The [<span
    class="Ohat">RUbigraph</span>](http://www.Omegahat.net/RUbigraph/) package
    provides an R interface to a Ubigraph server for drawing interactive,
    dynamic graphs. You can add and remove vertices/nodes and edges in a graph
    and change their attributes/characteristics such as shape, color, size.
  - *Other* :
      - `r pkg("rrefine")` can
        import to and export from the `r pkg("OpenRefine")` data cleaning service.

**Social Media Clients**

  - `r pkg("Rfacebook")`
    provide an interface to the Facebook API.
  - The [<span class="Ohat">Rflickr</span>](http://www.Omegahat.net/Rflickr/)
    package provides an interface to the Flickr photo management and sharing
    application Web service. (not on CRAN)
  - `r pkg("instaR")`
    is a client for the [Instagram API](https://www.instagram.com/developer/) .
  - `r pkg("Rlinkedin")` is
    a client for the LinkedIn API. Auth is via OAuth.
  - `r pkg("rpinterest")`
    connects to the `r pkg("Pintrest")` API.
  - `r pkg("vkR")` is a client for
    VK, a social networking site based in Russia.
  - [<span class="GitHub">meetupr</span>](https://github.com/rladies/meetupr/)
    is a client for the Meetup.com API.
  - *Twitter*: `r pkg("twitteR")` provides an
    interface to the Twitter web API. It claims to be deprecated in favor of
    `r pkg("rtweet")`
    ( ). [<span
    class="GitHub">twitterreport</span>](https://github.com/gvegayon/
    twitterreport/) (not on CRAN) focuses on report generation based on Twitter
    data. `r pkg("streamR")`
    provides a series of functions that allow users to access Twitter’s filter,
    sample, and user streams, and to parse the output into data frames. OAuth
    authentication is supported. `r pkg("tweet2r")` is an alternative implementation geared toward
    SQLite and postGIS databases. `r pkg("graphTweets")` produces a network graph from a data.frame
    of tweets. `r pkg("tweetscores")` (not on CRAN) implements a political ideology
    scaling measure for specified Twitter users.
  - `r pkg("brandwatchR")`
    is a package to retrieve a data from the Brandwatch social listening API.
    Both raw text and aggregate statistics are available, as well as project
    and query management functions.
  - `r pkg("hackeRnews")`
    is a client for the
    [Official Hacker News API](https://github.com/HackerNews/API) .

**Web Analytics Services**

  - *Google Trends*: `r pkg("gtrendsR")` offers functions to perform and display Google Trends queries.
    [<span class="Ohat">RGoogleTrends</span>](http://www.Omegahat.net/
    RGoogleTrends/) provides an alternative.
  - *Google Analytics*: `r pkg("googleAnalyticsR")`, `r pkg("ganalytics")`, and `r pkg("RGA")` provide functions for
    accessing and retrieving data from the [Google Analytics APIs](https://
    developers.google.com/analytics/). The latter supports OAuth 2.0
    authorization. `r pkg("RGA")`
    provides a shiny app to explore data. `r pkg("searchConsoleR")` links to the
    [Google Search Console](https://developers.google.com/webmaster-tools/)
    (formerly Webmaster Tools).
  - *Online Advertising*: `r pkg("fbRads")` can manage Facebook ads via the Facebook Marketing API. [<span
    class="GitHub">RDoubleClick</span>](https://github.com/WillemPaling/
    RDoubleClick/) (not on CRAN) can retrieve data from Google’s DoubleClick
    Campaign Manager Reporting API. `r pkg("RSmartlyIO")` loads Facebook and Instagram advertising data provided by
    [Smartly.io](https://app.smartly.io/) .
  - *Other services*: `r pkg("RSiteCatalyst")` has functions for accessing the Adobe Analytics
    (Omniture SiteCatalyst) Reporting API.
  - `r pkg("RAdwords")`
    is a package for
    loading Google Adwords data.
  - `r pkg("webreadr")`
    can process various
    common forms of request log, including the Common and Combined Web Log
    formats and AWS logs.

**Web Services for R Package Development**

  - R-Hub <http://log.r-hub.io/> is a project to enable package builds across
    all architectures. `r pkg("rhub")` is a package that interfaces with R-Hub to allow you to check a
    package on the platform.

**Other Web Services**

  - *Push Notifications*: `r pkg("RPushbullet")` provides an easy-to-use interface for the
    Pushbullet service which provides fast and efficient notifications between
    computers, phones and tablets. `r pkg("pushoverr")` can sending push notifications to mobile devices (iOS and
    Android) and desktop using `r pkg("Pushover")` .
    `r pkg("notifyme")`
    can control Phillips Hue
    lighting.

  - *Reference/bibliography/citation management*: `r pkg("rorcid")` is a programmatic interface the
    [Orcid.org](https://orcid.org/) API, which can be used for identifying
    scientific authors and their publications (e.g., by DOI).
    `r pkg("rdatacite")`
    connects to `r pkg("DataCite")`, which manages DOIs and
    metadata for scholarly datasets. `r pkg("scholar")` provides functions to extract citation data
    from Google Scholar. `r pkg("rscopus")` provides functions to extract citation data from
    Elsevier Scopus APIs. Convenience functions are also provided for comparing
    multiple scholars and predicting future h-index values. `r pkg("mathpix")` convert an image of a
    formula (typeset or handwritten) via Mathpix webservice to produce the
    LaTeX code. `r pkg("zen4R")`
    provides an Interface to `r pkg("Zenodo")` REST API, including
    management of depositions, attribution of DOIs by ‘Zenodo’ and upload of
    files.

  - *Literature*: `r pkg("rplos")` is a programmatic interface to the Web Service methods provided
    by the Public Library of Science journals for search. `r pkg("europepmc")` connects to the Europe
    PubMed Central service. [pubmed.mineR](https://cran.rstudio.com/web/
    packages/pubmed.mineR/index.html) is a package for text mining of [PubMed
    Abstracts](https://pubmed.ncbi.nlm.nih.gov/) that supports fetching text
    and XML from PubMed. `r pkg("jstor")` provides functions and helpers to import metadata, ngrams and
    full-texts from Data for Research service by JSTOR. `r pkg("aRxiv")` is a client for the arXiv
    API, a repository of electronic preprints for computer science,
    mathematics, physics, quantitative biology, quantitative finance, and
    statistics. `r pkg("roadoi")` provides an interface to the [Unpaywall API](https://
    unpaywall.org/products/api) for finding free full-text versions of academic
    papers. `r pkg("rcoreoa")`
    is an interface to the [CORE API](https://core.ac.uk/docs/), a search
    interface for open access scholarly articles. `r pkg("rcrossref")` is an interface to
    Crossref’s API, `r pkg("crminer")` extracts full text from scholarly articles retrieved via
    Crossref’s Text and Data Mining service; `r pkg("fulltext")` is a general purpose
    package to search for, retrieve and extract full text from scholarly
    articles; and `r pkg("rromeo")` is an interface
    to the SHERPA/RoMEO API, a database of scientific journal archival policies
    regarding pre-, post-print, and accepted manuscript.

  - *Automated Metadata Harvesting*: `r pkg("oai")` and `r pkg("OAIHarvester")` harvest metadata using the Open Archives
    Initiative Protocol for Metadata Harvesting (OAI-PMH) standard.

  - *Wikipedia*: `r pkg("WikipediR")` is a
    wrapper for the MediaWiki API, aimed particularly at the Wikimedia
    ‘production’ wikis, such as Wikipedia. `r pkg("WikidataR")` can request data from [Wikidata.org](https://www.wikidata.org/
    wiki/Wikidata:Main_Page), the free knowledgebase. `r pkg("wikipediatrend")` provides access to Wikipedia
    page access statistics. `r pkg("WikidataQueryServiceR")` is a client for the
    [Wikidata Query Service](https://query.wikidata.org/) .

  - `r pkg("bigrquery")`
    ( ): An interface to Google’s
    bigquery.

  - `r pkg("discgolf")`
    provides a client to
    interact with the API for the `r pkg("Discourse")` web
    forum platform. The API is for an installed instance of Discourse, not for
    the Discourse site itself.

  - [<span class="GitHub">mockaRoo</span>](https://github.com/stephlocke/
    mockaRoo/) (not on CRAN) uses the [MockaRoo API](https://www.mockaroo.com/
    api/docs) to generate mock or fake data based on an input schema.

  - `r pkg("randNames")`
    generates random names
    and personal identifying information using the <https://randomapi.com/> API.

  - `r pkg("rerddap")`: A
    generic R client to interact with any ERDDAP instance, which is a special
    case of OPeNDAP ( <https://en.wikipedia.org/wiki/OPeNDAP> ), or *Open-
    source Project for a Network Data Access Protocol*. Allows user to swap
    out the base URL to use any ERDDAP instance.

  - `r pkg("RStripe")`
    provides an interface to `r pkg("Stripe")`, an online payment
    processor.

  - `r pkg("slackr")` is a
    client for Slack.com messaging platform.

  - [<span class="GitHub">stackr</span>](https://github.com/dgrtwo/stackr/)
    (not on CRAN): An unofficial wrapper for the read-only features of the
    [Stack Exchange API](https://api.stackexchange.com/) .

  - [<span class="GitHub">useRsnap</span>](https://github.com/nealrichardson/
    useRsnap/) (not on CRAN) provides an interface to the API for
    `r pkg("Usersnap")`, a tool for collecting
    feedback from web application users.

  - `r pkg("duckduckr")` is
    an R interface [DuckDuckGo’s Instant Answer API](https://duckduckgo.com/api)

### CRAN packages:

  - `r pkg("abbyyR")`
  - `r pkg("ajv")`
  - `r pkg("analogsea")`
  - `r pkg("aRxiv")`
  - [aws.signature](https://cran.rstudio.com/web/packages/aws.signature/
    index.html)
  - `r pkg("AzureAuth")`
  - `r pkg("AzureContainers")`
  - `r pkg("AzureCosmosR")`
  - `r pkg("AzureGraph")`
  - `r pkg("AzureKusto")`
  - `r pkg("AzureQstor")`
  - `r pkg("AzureRMR")`
  - `r pkg("AzureStor")`
  - `r pkg("AzureTableStor")`
  - `r pkg("AzureVision")`
  - `r pkg("AzureVM")`
  - `r pkg("banR")`
  - `r pkg("bigrquery")`
  - `r pkg("boilerpipeR")`
  - `r pkg("boxr")`
  - `r pkg("brandwatchR")`
  - `r pkg("captr")`
  - `r pkg("clarifai")`
  - `r pkg("crminer")`
  - `r pkg("crul")` (core)
  - `r pkg("crunch")`
  - `r pkg("crunchy")`
  - `r pkg("curl")` (core)
  - `r pkg("dash")`
  - `r pkg("dataone")`
  - `r pkg("datarobot")`
  - `r pkg("dataverse")`
  - `r pkg("discgolf")`
  - `r pkg("downloader")`
  - `r pkg("duckduckr")`
  - `r pkg("europepmc")`
  - `r pkg("FastRWeb")`
  - `r pkg("fauxpas")`
  - `r pkg("fbRads")`
  - `r pkg("feedeR")`
  - `r pkg("fiery")`
  - `r pkg("fulltext")`
  - `r pkg("ganalytics")`
  - `r pkg("gdns")`
  - `r pkg("geonapi")`
  - `r pkg("geosapi")`
  - `r pkg("ggmap")`
  - `r pkg("gh")`
  - `r pkg("gistr")`
  - `r pkg("git2r")`
  - `r pkg("gitlabr")`
  - `r pkg("gmailr")`
  - `r pkg("googleAnalyticsR")`
  - `r pkg("googleAuthR")`
  - `r pkg("googleCloudStorageR")`
  - `r pkg("googleComputeEngineR")`
  - `r pkg("googleLanguageR")`
  - `r pkg("googlesheets")`
  - `r pkg("googleVis")`
  - `r pkg("graphTweets")`
  - `r pkg("gsheet")`
  - `r pkg("gtrendsR")`
  - `r pkg("hackeRnews")`
  - `r pkg("htm2txt")`
  - `r pkg("htmltidy")`
  - `r pkg("htmltools")`
  - `r pkg("httpcache")`
  - `r pkg("httpcode")`
  - `r pkg("httping")`
  - `r pkg("httpRequest")`
  - `r pkg("httptest")`
  - `r pkg("httpuv")`
  - `r pkg("httr")` (core)
  - `r pkg("imguR")`
  - `r pkg("instaR")`
  - `r pkg("ipaddress")`
  - `r pkg("iptools")`
  - `r pkg("jqr")`
  - `r pkg("js")`
  - `r pkg("jsonlite")` (core)
  - `r pkg("jsonvalidate")`
  - `r pkg("jstor")`
  - `r pkg("languagelayeR")`
  - `r pkg("leafletR")`
  - `r pkg("longurl")`
  - `r pkg("magrittr")`
  - `r pkg("mailR")`
  - `r pkg("mapsapi")`
  - `r pkg("mathpix")`
  - `r pkg("Microsoft365R")`
  - `r pkg("mime")`
  - `r pkg("mscstexta4r")`
  - `r pkg("mscsweblm4r")`
  - `r pkg("ndjson")`
  - `r pkg("notifyme")`
  - `r pkg("oai")`
  - `r pkg("OAIHarvester")`
  - `r pkg("openadds")`
  - `r pkg("opencage")`
  - `r pkg("opencpu")`
  - `r pkg("OpenML")`
  - `r pkg("osmar")`
  - `r pkg("osmplotr")`
  - `r pkg("osrm")`
  - `r pkg("ows4R")`
  - `r pkg("paws")`
  - `r pkg("pdftables")`
  - `r pkg("plotKML")`
  - `r pkg("plotly")`
  - `r pkg("plumber")`
  - `r pkg("postlightmercury")`
  - [pubmed.mineR](https://cran.rstudio.com/web/packages/pubmed.mineR/
    index.html)
  - `r pkg("pushoverr")`
  - `r pkg("qualtRics")`
  - `r pkg("radiant")`
  - `r pkg("RAdwords")`
  - `r pkg("randNames")`
  - `r pkg("rapiclient")`
  - `r pkg("rapport")`
  - `r pkg("rcoreoa")`
  - `r pkg("Rcrawler")`
  - `r pkg("rcrossref")`
  - `r pkg("RCurl")`
  - `r pkg("rdatacite")`
  - `r pkg("rdrop2")`
  - `r pkg("redcapAPI")`
  - `r pkg("REDcapR")`
  - `r pkg("repmis")`
  - `r pkg("reqres")`
  - `r pkg("request")`
  - `r pkg("rerddap")`
  - `r pkg("restfulr")`
  - `r pkg("Rexperigen")`
  - `r pkg("Rfacebook")`
  - `r pkg("rfigshare")`
  - `r pkg("RGA")`
  - `r pkg("rgeolocate")`
  - `r pkg("RgoogleMaps")`
  - `r pkg("rhub")`
  - `r pkg("rio")`
  - `r pkg("rjson")`
  - `r pkg("RJSONIO")`
  - `r pkg("Rlinkedin")`
  - `r pkg("rLTP")`
  - `r pkg("roadoi")`
  - `r pkg("ROAuth")`
  - `r pkg("robotstxt")`
  - `r pkg("Rook")`
  - `r pkg("rorcid")`
  - `r pkg("rosetteApi")`
  - `r pkg("routr")`
  - `r pkg("rpinterest")`
  - `r pkg("rplos")`
  - `r pkg("RPushbullet")`
  - `r pkg("rrefine")`
  - `r pkg("rromeo")`
  - `r pkg("RSclient")`
  - `r pkg("rscopus")`
  - `r pkg("rsdmx")`
  - `r pkg("RSelenium")`
  - `r pkg("Rserve")`
  - `r pkg("RSiteCatalyst")`
  - `r pkg("RSmartlyIO")`
  - `r pkg("RStripe")`
  - `r pkg("rtweet")`
  - `r pkg("rvest")`
  - `r pkg("RYandexTranslate")`
  - `r pkg("scholar")`
  - `r pkg("scrapeR")`
  - `r pkg("searchConsoleR")`
  - `r pkg("securitytxt")`
  - `r pkg("seleniumPipes")`
  - `r pkg("sendmailR")`
  - `r pkg("servr")`
  - `r pkg("shiny")` (core)
  - `r pkg("slackr")`
  - `r pkg("spiderbar")`
  - `r pkg("splashr")`
  - `r pkg("streamR")`
  - `r pkg("swagger")`
  - `r pkg("tidyRSS")`
  - [tm.plugin.webmining](https://cran.rstudio.com/web/packages/tm.plugin.webmining/index.html)
  - `r pkg("transcribeR")`
  - `r pkg("translate")`
  - `r pkg("translateR")`
  - `r pkg("tweet2r")`
  - `r pkg("twitteR")`
  - `r pkg("uaparserjs")`
  - `r pkg("urlshorteneR")`
  - `r pkg("urltools")`
  - `r pkg("V8")`
  - `r pkg("vcr")` (core)
  - `r pkg("vkR")`
  - `r pkg("W3CMarkupValidator")`
  - `r pkg("webmockr")` (core)
  - `r pkg("webreadr")`
  - `r pkg("webshot")`
  - `r pkg("webutils")`
  - `r pkg("whisker")`
  - `r pkg("WikidataQueryServiceR")`
  - `r pkg("WikidataR")`
  - `r pkg("wikipediatrend")`
  - `r pkg("WikipediR")`
  - `r pkg("WufooR")`
  - `r pkg("XML")`
  - `r pkg("xml2")` (core)
  - `r pkg("XML2R")`
  - `r pkg("xslt")`
  - `r pkg("yhatr")`
  - `r pkg("zen4R")`

### Related links:

  - [rOpenSci Task View: Open Data](https://github.com/ropensci/opendata)
