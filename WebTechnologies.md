---
name: WebTechnologies
topic: Web Technologies and Services
maintainer: Mauricio Vargas Sepulveda, Will Beasley
email: mavargas11@uc.cl
version: 2023-02-18
source: https://github.com/cran-task-views/WebTechnologies/
---

## 0. Introduction

### Tools for Working with the Web

This task view recommends packages and strategies for efficiently interacting
with resources over the internet with R.
This task view focuses on:

1. [Direct data download and ingestion](#direct),
1. [Online services](#online),
1. [Frameworks for building web-based R applications](#frameworks),
1. [Low-level operations](#low), and
1. [Resources](#resources)

If you have suggestions for improving or growing this task view,
please submit an issue or a pull request in the GitHub repository linked above.
If you can't contribute on GitHub,
please e-mail the task view maintainer.
If you have an issue with a package discussed below,
please contact the package's maintainer.

Thanks to all contributors to this task view, especially to
Scott Chamberlain, Thomas Leeper, Patrick Mair, Karthik Ram, and Christopher Gandrud
who maintained this task view up to 2021.

### Core Tools For HTTP Requests

The bulk of R's capabilities are supplied by CRAN packages
that are layered on top of [libcurl](https://curl.se/libcurl/).
Four packages provide the foundation for most modern approaches.

1. `r pkg("httr", priority = "core")` is a user-facing client for HTTP requests.
    It leverages the curl package for most operations.
    Additional options may be passed to curl through httr's `config` parameter.
    If you are developing a package that calls a web service,
    we recommend reading httr's vignettes.

    httr's team is developing its successor, `r pkg("httr2")`.
    If you're creating a package needs a stable foundation,
    you might use httr now and wait for httr2 v1.0 to be released.
    However if you can adapt to breaking changes as httr2 matures,
    it may be beneficial to invest in httr2's approach now.

1. `r pkg("crul", priority = "core")` is another package that leverages curl.
    It is an [R6](https://r6.r-lib.org/)-based client that supports
    asynchronous HTTP requests,
    a pagination helper,
    HTTP mocking via `r pkg("webmockr")`,
    and request caching for unit tests via `r pkg("vcr")`.
    crul is intended to be called by other packages, instead of R users.
    Unlike httr,
    crul's [current version](https://docs.ropensci.org/crul/reference/auth.html#details)
    does not support OAuth.
    Additional options may be passed to curl when instantiating crul's R6 classes.

1. `r pkg("curl", priority = "core")` is the lower-level
    package that provides a close interface between R and the
    [libcurl C library](https://curl.se/libcurl/).
    It is not intended to be called directly by typical R users.
    curl may be useful for operations on web-based XML or with FTP
    (as crul and httr are focused primarily on HTTP).

1. [utils](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/00Index.html) and
    [base](https://stat.ethz.ch/R-manual/R-devel/library/base/html/00Index.html)
    are the base R packages
    that provide `download.file()`, `url()`, and related functions.
    These functions also use libcurl.

    <!--
      They started supporting TLS/SSL with v3.3.0 and have had small increments through v4.2.2+.
      See https://cran.r-project.org/doc/manuals/r-release/NEWS.3.html and
      https://cran.r-project.org/doc/manuals/r-release/NEWS.html
    -->

## 1. [Direct data download and ingestion]{#direct}

In recent years,
many functions have been updated to accommodate web pages that are protected with TLS/SSL.
Consequently you can usually download a file's if its url starts with "http" or "https".

If the data file is not accessible via a simple url, you probably want to skip to the "Online Services" section.  It describes how to work with specific web services such as AWS, Google Documents, Twitter, REDCap, PubMed, and Wikipedia.

### Ingest a file directly

Many base and CRAN packages provide functions that accept a [url](https://en.wikipedia.org/wiki/URL) and
return a `data.frame` or `list`.

- For tabular/rectangular plain-text structures:
  - [utils](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/00Index.html)'s
    `read.csv()`, `read.table()`, and friends
    return a `base::data.frame`.
  - `r pkg("readr")`'s `read_csv()`, `read_delim()` and friends
    return a `tibble::tibble`, which derives from `base::data.frame`.
  - `r pkg("data.table")`'s `fread()`
    returns a `data.table::data.table`, which derives from `base::data.frame`.
  - `r pkg("arrow")`'s `read_csv_arrow()`
    returns a `tibble::tibble()` or other [Arrow](https://arrow.apache.org/) structures.
- For hierarchical plain-text structures:
  - `r pkg("jsonlite")`'s `fromJSON()` converts JSON into a `list`.
  - `r pkg("XML")`'s `parseXML()` converts XML into a `list`.
- For HTML, see the "Parsing Structured Web Data" section below.
- For structures in the Spark ecosystem:
  - `r pkg("arrow")`: interacts with a variety of file types used with big data
    including parquet, feather, and arrow IPC streams.
- For other file structures:
  - `r pkg("rio")` and `r pkg("repmis")`: accommodate many plain-text and proprietary formats.

### Download a file, then ingest it

If you need to process a different type of file,
you can accomplish this in two steps.
First download the file from a server to your local computer;
second pass the path of the new local file to a function in a
package like
[haven](https://CRAN.R-project.org/package=haven)
or
[foreign](https://cran.r-project.org/package=foreign).

Many base and CRAN packages provide functions that download files:

- [utils](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/00Index.html)'s `download.file()`.
- `r pkg("curl")`'s `curl_download()`, and `curl_fetch_multi()`, and friends.
- An alternative is to use `httr::GET()` (or `RCurl::getURL()`) to first read
the file into R as a character vector before parsing with a function like `utils::read.table(text = ...)`.

### Parsing Structured Web Data

The vast majority of web-based data is structured as
plain text, HTML, XML, or JSON.
Web service APIs increasingly rely on JSON, but XML is still prevalent in many applications.
There are several packages for specifically working with these format.
These functions can be used to interact directly with insecure web pages or
can be used to parse locally stored or in-memory web files.
Colloquially, these activities are called
[web scraping](https://en.wikipedia.org/wiki/Web_scraping).

- *XML*:
  There are two foundational packages for working with XML: `r pkg("XML")` and `r pkg("xml2")`.
  Both support general XML (and HTML) parsing, including XPath queries.
  `r pkg("xml2")` is less fully featured, but more user friendly with respect to memory management,
  classes (e.g., XML node vs. node set vs. document), and namespaces.
  Of the two, only the `r pkg("XML")` supports *de novo* creation of XML nodes and documents.

  Other XML tools include:
  - `r pkg("XML2R")` is a collection of convenient functions for coercing XML into data frames.
  An alternative to `r pkg("XML")` is `r pkg("selectr")`,
  which parses CSS3 Selectors and translates them to XPath 1.0 expressions.
  `r pkg("XML")` is often used for parsing xml and html,
  but selectr translates CSS selectors to XPath,
  so can use the CSS selectors instead of XPath.

  - `r ohat("XMLSchema")` provides facilities in R for reading XML schema documents and
  processing them to create definitions for R classes and functions for converting XML nodes
  to instances of those classes.
  It provides the framework for meta-computing with XML schema in R.
  - `r pkg("xslt")` is an extension for `r pkg("xml2")` to transform XML documents by applying an xslt style-sheet.
  This may be useful for web scraping, as well as
  transforming XML markup into another human- or machine-readable format
  (e.g., HTML, JSON, plain text, etc.).
  - `r ohat("XMLRPC")` provides an implementation of XML-RPC,
  a relatively simple remote procedure call mechanism that uses HTTP and XML.
  This can be used for communicating between processes on a single machine or
  for accessing Web services from within R.

- *HTML*:
  All of the tools that work with XML also work for HTML, though HTML tends to be more prone to be malformed.  So `xml2::read_html()` is a good first function to use for importing HTML.  Other tools are designed specifically to work with HTML.
  - For capturing static content of web pages `r pkg("postlightmercury")` is a client
    for the web service 'Mercury' that turns web pages into structured and clean text.
  - `r pkg("rvest")` is another higher-level alternative which expresses common web scraping tasks
    with [pipes](https://r4ds.hadley.nz/workflow-pipes.html)
    (like Base R's `|>` and magrittr's `%>%`).
  - `r pkg("boilerpipeR")` provides generic extraction of main text content from HTML files;
  removal of ads, sidebars and headers using the boilerpipe Java library.
  - PhantomJS (which was [archived in 2018](https://github.com/ariya/phantomjs/issues/15344)): `r pkg("webshot")` uses PhantomJS to provide screenshots of web pages without a browser.
    It can be useful for testing websites (such as Shiny applications).
  `  r github("cpsievert/rdom")` uses PhantomJS to access a webpage's Document Object Model (DOM).
  - `r pkg("htmltools")` provides functions to create HTML elements.

  - `r ohat("RHTMLForms")` reads HTML documents and obtains a description of each of the forms it contains,
  along with the different elements and hidden fields.
  `r pkg("htm2txt")` uses regex to converts html documents to plain text by removing all html tags.
  `r pkg("Rcrawler")` does crawling and scraping of web pages.
  - *HTML Utilities*:
    These tools don't extract content, but they can help your develop and debug.
    - `r pkg("W3CMarkupValidator")` provides an R Interface to W3C Markup Validation Services for validating HTML documents.
    - The [selectorgadget browser extension](https://selectorgadget.com/) can be used to identify page elements.
    - `r ohat("RTidyHTML")` interfaces to the libtidy library for correcting HTML documents that are not well-formed.
      This library corrects common errors in HTML documents.

- *JSON*:
  There are several packages for reading and writing JSON:
  `r pkg("rjson")`,
  `r pkg("RJSONIO")`, and
  `r pkg("jsonlite")`.
  We recommend using `r pkg("jsonlite")`.
  Check out the paper describing jsonlite by Jeroen Ooms <https://arxiv.org/abs/1403.2805>.
  `r pkg("jqr")` provides bindings for the fast JSON library 'jq'.
  `r pkg("jsonvalidate")` validates JSON against a schema using the "is-my-json-valid" JavaScript library;
  `r pkg("ajv")` does the same using the 'ajv' JavaScript library.
  `r pkg("ndjson")` supports the "ndjson" format.

- *RSS/Atom*:
  `r github("datawookie/feedeR")` can be used to parse RSS or Atom feeds.
  `r pkg("tidyRSS")` parses RSS, Atom XML/JSON and geoRSS into a tidy data.frame.
- `r pkg("swagger")` can be used to automatically generate functions for working with an web service API
  that provides documentation in [Swagger.io](https://swagger.io/) format.

### Tools for Working with Scraped Webpage Contents

<!-- This should be merged with the previous section. -->

- `r ohat("SSOAP")` provides a client-side SOAP (Simple Object Access Protocol) mechanism.
  Beware, SSOAP itself may not install, and/or its dependencies.
  The best bet is to get the web service maintainers to switch to REST.
- `r ohat("Rcompression")` (not on CRAN): Interface to zlib and bzip2 libraries
  for performing in-memory compression and decompression in R.
  This is useful when receiving or sending contents to remote servers,
  e.g. Web services, HTTP requests via RCurl.

## 2. [Online services]{#online}

### Cloud Computing and Storage

- *Amazon Web Services (AWS)*:
  - `r pkg("paws")` is an interface to nearly all AWS APIs,
    including compute, storage, databases, and machine learning.
    It also requires no external system dependencies.
  - `r pkg("aws.signature")` provides functionality for generating AWS API request signatures.
  - *Elastic Cloud Compute (EC2)* is a cloud computing service.
    `r gcode("segue")` (not on CRAN) manages EC2 instances and S3 storage,
    which includes a parallel version of `lapply()`
    for the Elastic Map Reduce (EMR) engine called `emrlapply()`.
    It uses Hadoop Streaming on Amazon's EMR in order to get simple parallel computation.
  - *Simple DB*: `r ohat("RAmazonDBREST")` provides an interface to Amazon's Simple DB API.
- *Microsoft Azure*: Azure and Microsoft 365 are Microsoft's cloud computing services.
  - The Azure platform provides Paas, SaaS and IaaS and supports many different tools and frameworks,
    including both Microsoft-specific and third-party systems;
    while Microsoft 365 is a unified framework for accessing cloud data from
    Microsoft's Office services, Windows and Dynamics.
    The [AzureR package family](https://github.com/Azure/AzureR)
    aims to provide a suite of lightweight, powerful tools for working with Azure in R.
    The packages listed below are part of the family, and are also mirrored at the cloudyr project.
  - *Azure Active Directory (AAD)* is a centralized directory and identity service.
    `r pkg("AzureAuth")` is an R client for AAD;
    use this to obtain OAuth tokens for authenticating with other Azure services,
    including Resource Manager and storage (see next).
  - *Microsoft Graph* is the API framework for the Microsoft 365 platform,
    including Azure Active Directory and Office.
    `r pkg("AzureGraph")` is a low-level extensible R6-based interface to Graph.
    `r pkg("Microsoft365R")` is an interface to the Office part of Microsoft 365,
    including OneDrive and SharePoint Online.
  - *Azure Resource Manager (ARM)* is a service for deploying other Azure services.
    `r pkg("AzureRMR")` is an R interface to ARM, and allows managing
    subscriptions, resource groups, resources and templates.
    It exposes a general R6 class framework that can extended to provide extra
    functionality for specific services (see next).
  - *Azure Storage Accounts* are a general-purpose data storage facility.
    Different types of storage are available: file, blob, table, Data Lake, and more.
    `r pkg("AzureStor")` provides an R interface to storage.
    Features include clients for file, blob and Data Lake Gen2 storage,
    parallelized file transfers,
    and an interface to Microsoft's cross-platform AzCopy command line utility.
    Also supplied is an ARM interface, to allow creation and managing of storage accounts.
    `r pkg("AzureTableStor")` and `r pkg("AzureQstor")` extend AzureStor
    to provide interfaces to table storage and queue storage respectively
  - `r pkg("AzureVM")` creates and manages virtual machines in Azure.
    It includes templates for a wide variety of common VM specifications and
    operating systems, including Windows, Ubuntu, Debian and RHEL.
  - `r pkg("AzureContainers")` provides a unified facility for working with containers in Azure.
    Specifically, it includes R interfaces to
    *Azure Container Instances (ACI)*,
    *Azure Docker Registry (ACR)* and
    *Azure Kubernetes Service (AKS)*.
    Create Docker images and push them to an ACR repository;
    spin up ACI containers;
    deploy Kubernetes services in AKS.
  - *Azure Data Explorer*, also known as *Kusto*, is a fast, scalable
    data exploration and analytics service.
    `r pkg("AzureKusto")` is an R interface to ADE/Kusto.
    It includes a dplyr client interface similar to that provided
    by dbplyr for SQL databases, a DBI client interface, and an
    ARM interface for deploying and managing Kusto clusters and databases.
  - *Azure Cosmos DB* is a multi-model NoSQL database service,
    previously known as Document DB.
    `r pkg("AzureCosmosR")` is an interface to the core/SQL API for Cosmos DB.
    It also includes simple bridges to the table storage and MongoDB APIs.
  - *Azure Computer Vision* and *Azure Custom Vision* are AI services for
    image recognition and analysis.
    Computer Vision is a pre-trained service for handling commonly-encountered tasks,
    while Custom Vision allows you to train your own image recognition model on a custom dataset.
    `r pkg("AzureVision")` provides an interface to both these services.
- *Google Cloud*:
  - `r pkg("googleComputeEngineR")` interacts with the Google Compute Engine API,
    and lets you create, start and stop instances in the Google Cloud.
  - `r pkg("googleCloudStorageR")` interfaces with Google Cloud Storage.
  - `r pkg("bigrquery")`: An interface to Google's BigQuery.
  - `r pkg("rrefine")` provides a client for the 'Open Refine' (formerly 'Google Refine') data cleaning service.
  - `r pkg("gargle")`: An interface to [Google APIs](https://developers.google.com/apis-explorer).
  - Look in other sections of the Web Technologies task view for packages interfacing other Google products.
- *Dropbox*:
  `r pkg("rdrop2")` facilitates
  uploads & downloads,
  copy/move/delete file and directory operations, and
  account & quotas queries.
  `r pkg("repmis")`'s `source_Dropbox()` function
  for downloading/caching plain-text data from non-public folders.
- *Other Cloud Storage*:
  `r pkg("boxr")` is a lightweight, high-level interface for the
  [box.com API](https://developer.box.com/reference/).

- *Docker*:
  `r pkg("analogsea")` is a general purpose client for the Digital Ocean v2 API.
  In addition, it includes functions to install various R tools
  including base R, RStudio server, and more.
  There's an improving interface
  to interact with docker on your remote droplets via this package.
- `r pkg("crunch")` provides an interface to the [crunch.io](https://crunch.io/)
  storage and analytics platform.
  `r pkg("crunchy")` facilitates making Shiny apps on Crunch.
- [The cloudyr project](https://cloudyr.github.io/) aims to provide interfaces to popular
  Amazon, Azure and Google cloud services without the need for external system dependencies.
  Amazon Web Services is a popular, proprietary cloud service offering a
  suite of computing, storage, and infrastructure tools.

### Software Development

- [*R-hub*](https://builder.r-hub.io/) is a collection of free services to help R package development across all architectures.
  `r pkg("rhub")` interfaces with R-Hub to allow you to check a package on the platform.
- [*GitHub*](https://github.com/):
  `r pkg("gistr")` works with GitHub gists ([gist.github.com](https://gist.github.com/discover)) from R,
  allowing you to create new gists, update gists with new files, rename files, delete files,
  get and delete gists, star and un-star gists, fork gists, open a gist in your default browser,
  get embed code for a gist, list gist commits, and get rate limit information when authenticated.
  `r pkg("git2r")` provides bindings to the git version control system and
  `r pkg("gh")` is a client for the GitHub API.
- [*GitLab*](https://about.gitlab.com/):
  `r pkg("gitlabr")` is a GitLab-specific client.

### Document and Images

- *Data archiving*:
  `r pkg("dataverse")` provides access to [Dataverse](https://dataverse.org/), the open source research data repository software.
  `r pkg("rfigshare")` connects with [Figshare.com](https://figshare.com/).
  `r pkg("dataone")` provides a client for 'DataONE' repositories.
- *Google Drive/Google Documents*:
  `r ohat("RGoogleDocs")` is an example of using the RCurl and XML packages
  to quickly develop an interface to the Google Documents API.
  `r ohat("RGoogleStorage")` provides programmatic access to the Google Storage API.
  This allows R users to access and store data on Google's storage.
  We can upload and download content, create, list and delete folders/buckets, and
  set access control permissions on objects and buckets.
- *Google Sheets*:
  `r pkg("googlesheets4")` (replaces `googlesheets`) can access private or public 'Google Sheets'
  by title, key, or URL. Extract data or edit data.
  Create, delete, rename, copy, upload, or download spreadsheets and worksheets.
  `r pkg("gsheet")` can download Google Sheets using just the sharing link.
  Spreadsheets can be downloaded as a data frame, or as plain text to parse manually.
- `r pkg("imguR")` shares plots using the image hosting service [Imgur.com](https://imgur.com/).
  knitr also has a function `imgur_upload()` to load images from literate programming documents.
- *Teams*, *SharePoint* and *OneDrive*:
  `r pkg("Microsoft365R")` provides an interface to these services,
  which form part of the Microsoft 365 (formerly known as Office 365) suite.

### Data Processing and Visualization

- *Document Processing*:
  `r pkg("abbyyR")`  and `r pkg("captr")` connect to optical character recognition (OCR) APIs.
  `r pkg("pdftables")` uses [the PDFTables.com webservice](https://pdftables.com/) to extract tables from PDFs.
- *Visualization*:
  Plot.ly is a company that allows you to create visualizations in the web using R (and Python),
  which is accessible via `r pkg("plotly")`.
  `r pkg("googleVis")` provides an interface between R and the Google chart tools.
  `r ohat("RUbigraph")` provides an R interface to a Ubigraph server for drawing interactive, dynamic graphs.
  You can add and remove vertices/nodes and edges in a graph and change their attributes/characteristics
  such as shape, color, size.
- *Other* :
  `r pkg("rrefine")` can import to and export from the 'OpenRefine' data cleaning service.

### Machine Learning and Translation

This list describes online services.  For a more complete treatment of the topic, please see the [Machine Learning](https://CRAN.R-project.org/view=MachineLearning) task view.

- *Machine Learning as a Service*:
  Several packages provide access to cloud-based machine learning services.
  `r pkg("OpenML")` is the official client for [the OpenML API](https://www.openml.org/frontend/page/home).
  `r pkg("clarifai")` is a [Clarifai.com](https://www.clarifai.com/) client that enables automated image description.
  `r pkg("rLTP")` accesses the [ltp-cloud service](https://www.ltp-cloud.com/).
  `r pkg("languagelayeR")` is a client for Languagelayer, a language detection API.
  `googlepredictionapi` (not on CRAN, but available from [Google](https://code.google.com/archive/p/r-google-prediction-api-v12/)):
  is an R client for the [Google Prediction API](https://cloud.google.com/ai-platform),
  a suite of cloud machine learning tools.
  `r pkg("yhatr")` lets you deploy, maintain, and invoke models via the Yhat REST API.
  `r pkg("datarobot")` works with Data Robot's predictive modeling platform.
  `r pkg("mscsweblm4r")` interfaces with the Microsoft Cognitive Services Web Language Model API and
  `r pkg("mscstexta4r")` uses the Microsoft Cognitive Services Text Analytics REST API.
  `r pkg("rosetteApi")` links to the 'Rosette' text analysis API.
  `r pkg("googleLanguageR")` provides interfaces to Google's
  Cloud Translation API, Natural Language API, Cloud Speech API, and the Cloud Text-to-Speech API.
  `r pkg("AzureVision")` provides interfaces to the Azure Computer Vision and Custom Vision image recognition services.
- *Machine Translation*:
  `r pkg("RYandexTranslate")` connects to Yandex Translate.
  `r pkg("transcribeR")` provides automated audio transcription via the HP IDOL service.

### Spatial Analysis

This list describes online services.  For a more complete treatment of the topic, please see the [Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial) task view.

- *Geolocation/Geocoding*:
  Services that translate between addresses and longlats.
  `r pkg("rgeolocate")` offers several online and offline tools.
  `r github("trestletech/rydn")` (not on CRAN) is an interface to the
  Yahoo Developers network geolocation APIs, and
  `r github("hrbrmstr/ipapi")` can be used to geolocate IPv4/6 addresses and/or domain names
  using the <http://ip-api.com/> API.
  `r pkg("opencage")` provides access to to the 'OpenCage' geocoding service.
  `r github("hrbrmstr/nominatim")` (not on CRAN) connects to the
  [OpenStreetMap Nominatim API](https://github.com/hrbrmstr/nominatim) for reverse geocoding.
  `r github("ropensci/PostcodesioR")` (not on CRAN) provides post code lookup and
  geocoding for the United Kingdom.
  `r pkg("geosapi")` is an R client for the 'GeoServer' REST API,
   an open source implementation used widely for serving spatial data.
  `r pkg("geonapi")` provides an interface to the 'GeoNetwork' legacy API,
  an open source catalogue for managing geographic metadata.
  `r pkg("ows4R")` is a new R client for the 'OGC' standard Web-Services,
  such Web Feature Service (WFS) for data and Catalogue Service (CSW) for metadata.
  `r pkg("openadds")` is an Openaddresses client.

- *Mapping*:
  Services that help create visual maps.
  - *OpenStreetMap*:
  `r pkg("osmplotr")` extracts customizable map images.
  - *Google Maps*:
  `r pkg("RgoogleMaps")` serves two purposes:
  it provides a comfortable R interface to query the Google server for static maps, and
  uses the map as a background image to overlay plots within R.
  `r ohat("R2GoogleMaps")` provides a mechanism to generate JavaScript code from R that displays data using Google Maps.
  `r pkg("mapsapi")` is an sf-compatible interface to Google Maps API.

- *Routing*:
  Services that calculate and optimize distances and routes.
  - *OpenStreetMap*:
  `r pkg("osrm")` assists with the computation of routes, trips, isochrones and travel distances matrices.

### Social Media Clients

- *Twitter*:
  `r pkg("twitteR")` provides an interface through its API.
  It claims to be deprecated in favor of `r pkg("rtweet")`.
  `r github("gvegayon/twitterreport")` (not on CRAN) focuses on report generation based on Twitter data.
  `r pkg("streamR")` allows users to access Twitter's filter,
  sample, and user streams, and to parse the output into data frames.
  OAuth authentication is supported.
  `r pkg("graphTweets")` produces a network graph from a data.frame of tweets.
  `r github("pablobarbera/twitter_ideology")` implements a political ideology scaling measure for specified Twitter users.
- *Facebook*:
  `r pkg("Rfacebook")` provides an interface through its API.
- *Instagram*:
  `r pkg("instaR")` provides an interface through its API.
- *LinkedIn*:
  `r pkg("Rlinkedin")` provides an interface through its API.
- *Flickr*:
  `r ohat("Rflickr")` (not on CRAN) provides an interface to the photo management and sharing application service.
- *Stack Exchange*:
  `r github("dgrtwo/stackr")` (not on CRAN): provides an interface through its API.
- *Pinterest*:
  `r pkg("rpinterest")` provides an interface through its API.
- *VK*:
  `r pkg("vkR")` provides an interface to the social networking site based in Russia.
- *Meetup*:
  `r github("rladies/meetupr")` provides an interface through its API.
- *Brandwatch*:
  `r pkg("brandwatchR")` provides an interface to the social listening service.
  Both raw text and aggregate statistics are available, as well as project and query management functions.
- *Hacker News*:
  `r pkg("hackeRnews")` provides an interface through its API.
- *Mastodon*:
  `r pkg("rtoot")` provides an interface through its API.
- *Slack*:
  `r pkg("slackr")` is a client for  messaging platform.
- *Discourse*:
  `r github("sckott/discgolf")` (archived)
  provides an interface to an instance of Discourse, not to the Discourse site itself.

### Survey, Questionnaire, and Data Capture Tools

- *REDCap*:
  `r pkg("REDCapR")` and `r pkg("redcapAPI")` export and import data from a REDCap,
  a web application for building and managing online surveys and research databases.
  `r pkg("REDCapTidieR")` and `r pkg("tidyREDCap")`
  follow [tidy](https://www.tidyverse.org/) principles to extend `r pkg("REDCapR")`.
- *Qualtrics*:
  `r pkg("qualtRics")` provide functions to interact with Qualtrics,
  an online survey and data collection software platform.
- *Wufoo*:
  `r pkg("WufooR")` retrieves data from Wufoo,
  which is another data collection tool from the SurveyMonkey company.
- *formr*:
 `r github("rubenarslan/formr")` facilitates use of the formr online survey framework,
  which relies on R via OpenCPU.
- *Experigen*:
  `r pkg("Rexperigen")` is a client for Experigen,
  which is a platform for creating phonology experiments.
- *Usersnap*:
  `r github("nealrichardson/useRsnap")` connects to Usersnap,
  a tool for collecting feedback from web application users.

### Web Analytics Services

- *Google Trends*:
  `r pkg("gtrendsR")` offers functions to perform and display Google Trends queries.
  `r ohat("RGoogleTrends")` provides an alternative.
- *Google Analytics*:
  `r pkg("googleAnalyticsR")`, and `r pkg("ganalytics")` provide functions for accessing and retrieving
  data from the [Google Analytics APIs](https://developers.google.com/analytics/).
  The latter supports OAuth 2.0 authorization.
  `r pkg("searchConsoleR")` links to the
  [Google Search Console](https://developers.google.com/webmaster-tools/) (formerly Webmaster Tools).
- *Online Advertising*:
  `r pkg("fbRads")` can manage Facebook ads via the Facebook Marketing API.
  `r github("WillemPaling/RDoubleClick")` (not on CRAN) can retrieve data from
  Google's DoubleClick Campaign Manager Reporting API.
  `r pkg("RSmartlyIO")` loads Facebook and Instagram advertising data provided by
  [Smartly.io](https://app.smartly.io/).
- *Other services*:
  `r pkg("RSiteCatalyst")` has functions for accessing the Adobe Analytics
   (Omniture SiteCatalyst) Reporting API.
- `r pkg("RAdwords")` loads Google Adwords data.
- `r pkg("webreadr")` can process various common forms of request log,
  including the Common and Combined Web Log formats and AWS logs.
- `r pkg("WebAnalytics")` provides tools for analysis of
  web application performance, workload and user population.
  There is some overlap with `webreadr`, but webreader focuses on reading log files,
  while WebAnalytics focuses on analysing them.

### Publications

- *Reference/bibliography/citation management*:
  `r pkg("rorcid")` connects to the [Orcid.org](https://orcid.org/) API,
  which can identify scientific authors and their publications (e.g., by DOI).
  `r pkg("rdatacite")` connects to [DataCite](https://datacite.org/),
  which manages DOIs and metadata for scholarly datasets.
  `r pkg("scholar")` extracts citation data from [Google Scholar](https://scholar.google.com/).
  `r pkg("rscopus")` extracts citation data from [Elsevier Scopus](https://www.elsevier.com/solutions/scopus).
  Convenience functions are also provided for comparing multiple scholars and
  predicting future h-index values.
  `r pkg("mathpix")` converts an image of a formula (typeset or handwritten)
  via Mathpix webservice to produce the 'LaTeX' code.
  `r pkg("zen4R")` connects to [Zenodo](https://zenodo.org/) API,
  including management of depositions, attribution of DOIs and upload of files.

- *Literature*:
  `r pkg("rplos")` connects to the Public Library of Science journals.
  `r pkg("europepmc")` connects to the Europe PubMed Central service.
  `r pkg("pubmed.mineR")` is for text mining of [PubMed Abstracts](https://pubmed.ncbi.nlm.nih.gov/)
  that supports fetching text and XML from PubMed.
  `r pkg("jstor")` retrieves
  metadata, ngrams and full-texts from Data for Research service by JSTOR.
  `r pkg("aRxiv")` connects to arXiv, a repository of electronic preprints for
  computer science, mathematics, physics, quantitative biology, quantitative finance, and statistics.
  `r pkg("roadoi")` connects to the [Unpaywall API](https://unpaywall.org/products/api)
  for finding free full-text versions of academic papers.
  `r pkg("rcoreoa")` is an interface to the [CORE API](https://core.ac.uk/docs/),
  a search interface for open access scholarly articles.
  `r pkg("rcrossref")` is an interface to Crossref's API.

### Generating Synthetic Data

- *MockaRoo API*:
  `r github("stephlocke/mockaRoo")` (not on CRAN) generates mock or fake data based on an input schema.
- *RandomAPI*:
  `r github("karthik/randNames")` generates random names and personal identifying information.

### Sports Analytics

Many CRAN packages interact with services facilitating sports analysis.  For a more complete treatment of the topic, please see the [Sports Analytics](https://CRAN.R-project.org/view=SportsAnalytics) task view.

### Other Web Services

- *Push Notifications*:
  `r pkg("RPushbullet")` provides an easy-to-use interface for the Pushbullet service
  which provides fast and efficient notifications between
  computers, phones and tablets.
  `r pkg("pushoverr")` can sending push notifications to mobile devices (iOS and Android) and desktop
  using 'Pushover'.
  `r pkg("notifyme")` can control Phillips Hue lighting.

- *Automated Metadata Harvesting*:
  `r pkg("oai")` and `r pkg("OAIHarvester")` harvest metadata
  using the Open Archives Initiative Protocol for Metadata Harvesting (OAI-PMH) standard.

- *Wikipedia*:
  `r pkg("WikipediR")` is a wrapper for the 'MediaWiki' API,
  aimed particularly at the 'Wikimedia' "production" wikis, such as 'Wikipedia'.
  `r pkg("WikidataR")` can request data from
  [Wikidata.org](https://www.wikidata.org/wiki/Wikidata:Main_Page), the free knowledge base.
  `r pkg("wikipediatrend")` provides access to Wikipedia page access statistics.
  `r pkg("WikidataQueryServiceR")` is a client for the [Wikidata Query Service](https://query.wikidata.org/).

- `r pkg("rerddap")`: A generic R client to interact with any ERDDAP instance,
  which is a special case of OPeNDAP (<https://en.wikipedia.org/wiki/OPeNDAP>),
  or *Open-source Project for a Network Data Access Protocol*.
  Allows user to swap out the base URL to use any ERDDAP instance.

- `r pkg("RStripe")` provides an interface to 'Stripe', an online payment processor.

- `r pkg("duckduckr")` is an R interface to [DuckDuckGo](https://duckduckgo.com/)

## 3. [Frameworks for building web-based R applications]{#frameworks}

- [Model Operationalization](https://docs.microsoft.com/en-us/machine-learning-server/what-is-operationalization)
  (previously DeployR)
  is a Microsoft product that provides support for deploying R and Python models and
  code to a server as a web service to later consume.
- `r pkg("shiny")` makes it easy to build interactive web applications with R.
- `r github("plotly/dashR")` is a web framework which is available for
  Python, R and Julia, with components written in React.js.
- Other web frameworks include:
  `r pkg("fiery")` that is meant to be more flexible but less easy to use than shiny
  (`r pkg("reqres")` and `r pkg("routr")` are utilities used by fiery
  that provide HTTP request and response classes, and HTTP routing, respectively);
  `r github("att/rcloud")` provides an iPython notebook-style web-based R interface; and
  `r pkg("Rook")`, which contains the specification and convenience software
  for building and running Rook applications.
- The `r pkg("opencpu")` framework for embedded statistical computation and reproducible research
  exposes a web API interfacing R, LaTeX and Pandoc.
  This API is used for example to integrate statistical functionality into systems,
  share and execute scripts or reports on centralized servers,
  and build R based apps.
- Several general purpose server/client frameworks for R exist.
  `r pkg("Rserve")` and
  `r pkg("RSclient")`
  provide server and client functionality for TCP/IP or local socket interfaces.
  `r pkg("httpuv")` provides a low-level socket and protocol support
  for handling HTTP and WebSocket requests directly within R.
  Another related package, perhaps which `r pkg("httpuv")` replaces, is `websockets` (retired from CRAN).
  `r pkg("servr")` provides a simple HTTP server to serve files under a given directory based on httpuv.
- Several packages offer functionality for turning R code into a web API.
  `r pkg("FastRWeb")` provides some basic infrastructure for this.
  `r pkg("plumber")` allows you to create a REST API by decorating existing R source code.
  `r pkg("beakr")` provides an R version of functionality found in python Flask and JavaScript Express.js.
- `r ohat("WADL")` provides tools to process Web Application Description Language (WADL) documents and
  to programmatically generate R functions to interface to the REST methods
  described in those WADL documents. (not on CRAN)
- `r ohat("RDCOMServer")` provides a mechanism to export R objects as (D)COM objects in Windows.
  It can be used along with `r ohat("RDCOMClient")`,
  which provides user-level access from R to other COM servers. (not on CRAN)
- `r pkg("radiant")` is Shiny-based GUI for R that runs in a browser from a server or local machine.
- The 'Tiki' Wiki CMS/Groupware framework has an R plugin (`PluginR`) to run R code from wiki pages,
  and use data from their own collected web databases (trackers).
  A demo: <https://r.tiki.org/tiki-index.php> .
- `r pkg("whisker")`: Implementation of logicless templating based on 'Mustache' in R.
- Mustache syntax is described in <http://mustache.github.io/mustache.5.html>
- `r ohat("CGIwithR")` (not on CRAN) allows one to use R scripts as CGI programs
  for generating dynamic Web content.
  HTML forms and other mechanisms to submit dynamic requests can be used to provide input to R scripts
  via the Web to create content that is determined within that R script.

### Other Useful Packages and Functions

- *JavaScript*:
  `r pkg("V8")` is an R interface to Google's open source, high performance JavaScript engine.
  It can wrap JavaScript libraries as well as NPM packages.
  `r ohat("SpiderMonkey")` provides another means of evaluating JavaScript code,
  creating JavaScript objects and calling JavaScript functions and methods from within R.
  This can work by embedding the JavaScript engine within an R session or
  by embedding R in an browser such as Firefox and
  being able to call R from JavaScript and call back to JavaScript from R.
  `r pkg("js")` wraps `r pkg("V8")` and validates, reformats, optimizes and analyzes JavaScript code.
- *Email*:
  `r pkg("mailR")` is an interface to Apache Commons Email to send emails from within R.
  `r pkg("sendmailR")` provides a simple SMTP client.
  `r pkg("gmailr")` provides access the Google's gmail.com RESTful API.
  `r pkg("Microsoft365R")` provides a client for Microsoft's Outlook email service,
  both personal (outlook.com) and
  as part of the Microsoft 365 (formerly known as Office 365) suite.
- *Mocking*:
  `r pkg("webmockr")` stubs and sets expectations on HTTP requests.
  It is inspired from Ruby's `webmock`.
  `r pkg("webmockr")` only helps mock HTTP requests, and returns nothing when requests match expectations.
  It integrates with `r pkg("crul")` and `r pkg("httr")`.
  See *Testing* for mocking with returned responses.
- *Testing*:
  `r pkg("vcr")` provides an interface to easily cache HTTP requests in R package test suites
  (but can be used outside of testing use cases as well).
  vcr relies on `r pkg("webmockr")` to do the HTTP request mocking.
  vcr integrates with `r pkg("crul")` and `r pkg("httr")`.
  `r pkg("httptest")` provides a framework for testing packages that communicate with HTTP APIs,
  offering tools for mocking APIs, for recording real API responses for use as mocks,
  and for making assertions about HTTP requests,
  all without requiring a live connection to the API server at runtime.
  httptest only works with httr.
- *Miscellaneous*:
  `r pkg("webutils")` contains various functions for developing web applications,
  including parsers for `application/x-www-form-urlencoded` as well as `multipart/form-data`.
  `r pkg("mime")` guesses the MIME type for a file from its extension.
  `r pkg("rsdmx")` provides tools to read data and metadata documents exchanged through the
  Statistical Data and Metadata Exchange (SDMX) framework;
  it focuses on the SDMX XML standard format(SDMX-ML).
  `r pkg("robotstxt")` provides functions and classes for parsing robots.txt files and
  checking access permissions;
  `r pkg("spiderbar")` does the same.
  `r pkg("uaparserjs")` uses the JavaScript ["ua-parser" library](https://github.com/ua-parser)
  to parse User-Agent HTTP headers.
  `r pkg("rapiclient")` is a client for consuming APIs that follow the
  [Open API format](https://www.openapis.org/).
  `r pkg("restfulr")` models a RESTful service as if it were a nested R list.

## 4. [Low-level operations]{#low}

### Tools for Working with URLs

- The `httr::parse_url()` function can be used to extract portions of a URL.
  The `RCurl::URLencode()` and `utils::URLencode()` functions can be used to encode character strings for use in URLs.
  `utils::URLdecode()` decodes back to the original strings.
  `r pkg("urltools")` can also handle URL encoding, decoding, parsing, and parameter extraction.
- `r pkg("iptools")` can facilitate working with IPv4 addresses, including for use in geolocation.
  A similar package `r pkg("ipaddress")`, handles IPv4 and IPv6 addresses and networks.
- `r github("dmpe/urlshorteneR")` offers URL expansion and analysis for Bit.ly, Goo.gl, and is.gd.
  `r pkg("longurl")` uses the longurl.org API to provide similar functionality.
- `r github("hrbrmstr/gdns")` provides access to Google's secure HTTP-based DNS resolution service.

### Additional tools for internet communication

For specialized situations, the following resources may be useful:

- `r pkg("RCurl")` is another low-level client for libcurl.
  Of the two low-level curl clients, we recommend using `r pkg("curl")`.
  `r pkg("httpRequest")` is another low-level package for HTTP requests that implements
  the GET, POST and multipart POST verbs,
  but we do not recommend its use.
- `r pkg("request")` provides a high-level package that is useful for developing other API client packages.
  `r pkg("httping")` provides simplified tools to ping and time HTTP requests, around `r pkg("httr")` calls.
  `r pkg("httpcache")` provides a mechanism for caching HTTP requests.
- `r pkg("nanonext")` is an alternative low-level sockets implementation that can be used to perform HTTP and
  streaming WebSocket requests synchronously or asynchronously over its own concurrency framework.
  It uses the NNG/mbedTLS libraries as a backend.
- For dynamically generated webpages (i.e., those requiring user interaction to display results),
  `r pkg("RSelenium")` can be used to automate those interactions and extract page contents.
  It provides a set of bindings for the Selenium 2.0 webdriver using the 'JsonWireProtocol'.
  It can also aid in automated application testing, load testing, and web scraping.
  `r pkg("seleniumPipes")` provides a "pipe"-oriented interface to the same.
- *Authentication*: Using web resources can require authentication,
  either via API keys, OAuth, username:password combination, or via other means.
  Additionally, sometimes web resources that require authentication be in the header of an http call,
  which requires a little bit of extra work. API keys and username:password combos can be combined
  within a url for a call to a web resource, or can be specified via commands in
  `r pkg("RCurl")` or `r pkg("httr")`.
  OAuth is the most complicated authentication process,
  and can be most easily done using `r pkg("httr")`.

  See the 6 demos within `r pkg("httr")`,
  three for OAuth 1.0 (LinkedIn, Twitter, Vimeo) and
  three for OAuth 2.0 (Facebook, GitHub, Google).
  `r pkg("ROAuth")` provides a separate R interface to OAuth.
  OAuth is easier to to do in `r pkg("httr")`, so start there.
  `r pkg("googleAuthR")` provides an OAuth 2.0 setup specifically for Google web services,
  and `r pkg("AzureAuth")` provides similar functionality for Azure Active Directory.

### Handling HTTP Errors/Codes

- `r pkg("fauxpas")` brings a set of Ruby or Python like R6 classes for each individual HTTP status code,
  allowing simple and verbose messages, with a choice of using messages, warnings, or stops.
- `r pkg("httpcode")` is a simple package to help a user/package find HTTP status codes and
  associated messages by name or number.

### Security

- `r github("hrbrmstr/securitytxt")` identifies and parses web Security policy files.

## 5. [Resources]{#resources}

### Links

- CRAN Task View [Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial)

- CRAN Task View [Machine Learning](https://CRAN.R-project.org/view=MachineLearning)

- CRAN Task View [Reproducible Research](https://CRAN.R-project.org/view=ReproducibleResearch)

- CRAN Task View [Sports Analytics](https://CRAN.R-project.org/view=SportsAnalytics)
