# Before you start scraping

You may have a code to perform web scraping, and it can be very efficient
by time metrics or resources usage, but first we need to talk about whether it's
legal and ethical for you to do so.

You can use the 'polite' package, which builds upoen the principles of seeking
permission, taking slowly and never asking twice. The package builds on awesome
toolkits for defining and managing http sessions ('httr' and 'rvest'), declaring
the user agent string and investigating site policies ('robotstxt'), and
utilizing rate-limiting and response caching (ratelimitr and memoise).

The problem is not technical, but ethical and also legal. You can technically
log into an art auction site and scrape the prices of all the paintings, but
if you need an account and to use 'rSelenium' to extract the information by
automating clicks in the browser, you are subject to the Terms of Service (ToS).

Another problem is that some websites require specific connections. I can
connect to a site from my university and access content for free, but if I
connect from home, I need to pay. So, if I scrape the site from the university,
I might be breaking some laws if I am not carefull with the goal and scope of
the scraping.
