# See https://github.com/cran-task-views/WebTechnologies/issues/505

library(stringr)
library(available)
library(purrr)
library(rvest)

file_content <- readLines("WebTechnologies.md")

github_packages <- unlist(str_extract_all(file_content, "r github\\(\"([^\"]+)\"\\)"))
github_packages <- str_match(github_packages, "r github\\(\"([^\"]+)\"\\)")[, 2]
github_packages <- str_replace(github_packages, ".*/", "")

packages <- list()

# Check each package and print results
for (pkg in github_packages) {
  packages[[pkg]] <- available_on_cran(pkg)
}

on_cran <- map_lgl(packages, function(x) isFALSE(as.logical(x)))
on_cran <- github_packages[on_cran]

on_cran %>% 
  rlang::set_names() %>% 
  purrr::map_lgl(available::available_on_cran) %>% 
  tibble::enframe(
    value = "available_on_cran"
  )

urls <- sprintf("https://CRAN.R-project.org/package=%s", on_cran)

# read the urls

cran_status <- map(urls, ~{
  tryCatch({
    url <- .x
    read_html(url)
  }, error = function(e) {
    e
  })
})

cran_status <- map(cran_status, ~{
  if (inherits(.x, "error")) {
    NA
  } else {
    y <- .x %>% 
      html_nodes("p") %>%
        html_text() %>%
        str_detect("removed") %>%
        any()
    y <- ifelse(y, "removed", "available")
  }
})

on_cran[!grep("removed", unlist(cran_status))]
