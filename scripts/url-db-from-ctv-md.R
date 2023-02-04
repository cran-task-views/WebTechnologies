url_db_from_ctv_md <- function(path_md, verbose = TRUE) {
  if (!inherits(path_md, "character"))  stop("`path_md` must be a character.")
  if (length(path_md) != 1L)            stop("Only one `path_md` value is accepted.")
  if (!inherits(verbose, "logical"))    stop("`verbose` must be a character.")
  if (length(verbose) != 1L)            stop("Only one `verbose` value is accepted.")

  # Capture each url, even those with parentheses.  See https://stackoverflow.com/a/67942420/1082435
  pattern <- "\\[(?<page_name>.[^][]+)\\](\\((?<page_url>(?:[^()]+|(?2))+)\\))"
  # pattern <- "\\[(?<page_name>.+?)\\]\\((?<page_url>.+?)\\)"
  lines <- readr::read_file(path)

  matches <-
    rematch2::re_match_all(lines, pattern, perl = TRUE)

  db <-
    tibble::tibble(
      label   = unlist(matches$page_name),
      URL     = unlist(matches$page_url)
    ) |>
    dplyr::distinct() |> # Avoid checking redundant entries
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

  tools:::check_url_db(db, verbose = verbose, parallel = TRUE)
}

# url_db_from_ctv_md("WebTechnologies.md")
