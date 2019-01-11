if (!require("crul")) {
  install.packages("crul", repos = "https://cran.rstudio.com/")
}

extract_github <- function(file, ...) {
  f <- rawToChar(readBin(file, what = "raw", n = 1e7L))
  pattern <- "<github>[A-Za-z0-9\\-]+/[A-Za-z0-9\\-]+</github>"
  m <- regmatches(f, gregexpr(pattern, f))[[1]]
  m <- gsub("</?github>", "", m)
  m <- vapply(strsplit(m, "/"), "[[", "", 2)
  sprintf("https://cran.rstudio.com/web/packages/%s/", m)
}

check_one <- function(url) {
  r <- try(crul::HttpClient$new(url)$head(), silent = TRUE)
  if (inherits(r, "try-error")) {
    list(url1 = url, 
      url2 = NA_character_, 
      redirect = NA, 
      error = NA, 
      status = NA_real_
    )
  } else {
    list(url1 = url, 
      url2 = r$url, 
      redirect = !identical(url, r$url), 
      error = !r$success(), 
      status = r$status_code
    )
  }
}

check_urls <- function(urls) {
  check <- lapply(urls, check_one)
  out <- do.call("rbind.data.frame", c(check, stringsAsFactors = FALSE,
    make.row.names = FALSE))
  return(structure(out, class = c("url_check", "data.frame")))
}

print.url_check <- function(x, ...) {
  f <- is.na(x[["url2"]])
  r <- x[["redirect"]]
  e <- x[["error"]]
  s <- x[["status"]] != 200
  print.data.frame(x[ (f | r | e | s) ,, drop = FALSE])
  invisible(x)
}

u <- extract_github("webtech.md")
print(ch <- check_urls(u))
