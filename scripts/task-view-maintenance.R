# Keep current with the advice in
#  https://github.com/cran-task-views/ctv/blob/main/Contributing.md

task_view_name  <- "WebTechnologies"
path_md         <- sprintf("%s.md"  , task_view_name)
path_html       <- sprintf("%s.html", task_view_name)

if (base::basename(getwd()) != "WebTechnologies") {
  stop("The working directory should be the root of the repository.")
} else {
  source("scripts/url-db-from-ctv-md.R")
}

# Create the html and visually inspect the content and formatting.
ctv::ctv2html(path_md)
utils::browseURL(path_html)

# Check that the information text and the package list
#  are consistent and that all packages are available from CRAN:
ctv::check_ctv_packages(path_md)

# Determine if any urls need to be updated
#  or if any services are defunct (and their entry should be removed).
url_db_from_ctv_md(path_md)

# Check spelling
path_spelling <- "scripts/spelling.csv"

# Run block to update list.
if (FALSE) {
  path_md |>
    spelling::spell_check_files() |>
    dplyr::pull("word") |>
    readr::write_lines(path_spelling)
}

words_ignore <- readr::read_lines(path_spelling)
spelling::spell_check_files(path_md, words_ignore)
