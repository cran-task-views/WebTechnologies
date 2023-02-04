url_db_from_ctv_md <- function(path_md, verbose = TRUE) {
  pattern <- "\\[(?<page_name>.+?)\\]\\((?<page_url>.+?)\\)"
  lines <- readr::read_file(path)

  matches <-
    rematch2::re_match_all(lines, pattern, perl = TRUE)

  db <-
    tibble::tibble(
      label   = unlist(matches$page_name),
      URL     = unlist(matches$page_url)
    ) |>
    # dplyr::slice(1:5) |>
    dplyr::mutate(
      label =
        sub( # strip opening & closing bold/italics
          pattern     = "^[_\\*]{1,2})(.+?)\\1$",
          replacement = "\\2",
          x           = label
          # perl        = TRUE
        ),
    )

  if (verbose) {
    cat("---- URLs to check ----------\n")
    print(db)
  }

  db$Parent <- path
  class(db) <- "url_db"

  tools:::check_url_db(db)
}

# url_db_from_ctv_md("WebTechnologies.md")
