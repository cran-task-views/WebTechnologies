# install.packages("CGIwithR", repos="http://www.omegahat.net/R")
# library_temp <- base::tempdir(check = TRUE)
# cat(library_temp)
# libraries_existing <- .libPaths()
# .libPaths(c(libraries_existing, library_temp))

# cran_dependencies <- c(
#   "RCurl"
# )
# 
# install.packages(cran_dependencies)#, lib = library_temp)

package <- c(
  "CGIwithR",
  "R2GoogleMaps",
  "RAmazonDBREST",
  "Rcompression",
  "RDCOMClient",
  "RDCOMServer",
  "Rflickr",
  "RGoogleDocs",
  "RGoogleStorage",
  "RGoogleTrends",
  "RHTMLForms",
  "RTidyHTML",
  "RUbigraph",
  "SpiderMonkey",
  "SSOAP",
  "SXalan",
  "Sxslt",
  "WADL",
  "XMLRPC",
  "XMLSchema"
)

outcome <- list()
for(p in package) {
  message("Installing ", p)
  install.packages(
    p, 
    repos = "http://www.omegahat.net/R",
    type  = "source"
    )#, lib = library_temp)
  
  success <- requireNamespace(p, quietly = T)
  outcome[[p]] <- success
  
  message("success: ", success)
  if (success) remove.packages(p)#, lib = library_temp)
}
outcome |> 
  tibble::as_tibble()
print(outcome)

# Remove all the CRAN packages used to test Omega Hat
# remove.packages(cran_dependencies)#, lib = library_temp)

# Restore session's libraries and remove temp library
# .libPaths(libraries_existing)
# unlink(library_temp, recursive = TRUE, force = TRUE)
