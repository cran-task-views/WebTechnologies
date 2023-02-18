# install.packages("CGIwithR", repos="http://www.omegahat.net/R")
# library_temp <- base::tempdir(check = TRUE)
# cat(library_temp)
# libraries_existing <- .libPaths()
# .libPaths(c(libraries_existing, library_temp))

# cran_dependencies <- c(
#   "RCurl",
#   "RJSONIO"
# )
# 
# install.packages(cran_dependencies)#, lib = library_temp)

package_omegahat <- c(
  "CGIwithR",
  "R2GoogleMaps",
  "RAmazonDBREST",
  "Rflickr",
  "RGoogleDocs",
  "RGoogleStorage",
  "SSOAP",  # Is on GitHub, but doesn't have a description file: https://github.com/omegahat/SSOAP
  "SXalan",
  "WADL",
  "XMLRPC"
)
package_github <- c(
  "Rcompression",
  "RDCOMClient",
  "RDCOMServer",
  "RGoogleTrends",
  "RHTMLForms",
  "RTidyHTML",
  "RUbigraph",
  "SpiderMonkey",
  "Sxslt",
  "XMLSchema"
)

outcome <- list()
for(p in package_github) {
  message("Installing ", p)
  # install.packages(
  #   p, 
  #   repos = "http://www.omegahat.net/R",
  #   type  = "source"
  #   #, lib = library_temp
  # )
  remotes::install_github(
    repo = paste0("omegahat/", p)
  )
  
  success <- requireNamespace(p, quietly = T)
  outcome[[p]] <- success
  
  message("success: ", success)
  if (success) remove.packages(p)#, lib = library_temp)
}

outcome |> 
  tibble::enframe(
    name = "package",
    value = "install_success"
  ) |> 
  dplyr::mutate(
    install_success = as.logical(install_success)
  )

# print(outcome)

# Remove all the CRAN packages used to test Omega Hat
# remove.packages(cran_dependencies)#, lib = library_temp)

# Restore session's libraries and remove temp library
# .libPaths(libraries_existing)
# unlink(library_temp, recursive = TRUE, force = TRUE)

# install.packages("SXalan", repos = "http://www.omegahat.net/R", type  = "source")
# remotes::install_github("omegahat/SSOAP")

# === From GitHub =======
# # A tibble: 10 × 2
#    package       install_success
#    <chr>         <lgl>          
#  1 Rcompression  FALSE          # Please define LIB_BZIP2
#  2 RDCOMClient   TRUE           
#  3 RDCOMServer   FALSE          # ERROR: dependencies 'SWinRegistry', 'Ruuid' are not available for package 'RDCOMServer'
#  4 RGoogleTrends TRUE           
#  5 RHTMLForms    TRUE           
#  6 RTidyHTML     FALSE          # make: cc: No such file or directory; make: *** [<builtin>: access.o] Error 127
#  7 RUbigraph     FALSE          # undefined exports: runUbigraph
#  8 Sxslt         FALSE          # Please define LIB_XSLT
#  9 SpiderMonkey  FALSE          # ERROR: dependencies 'RAutoGenRunTime', 'Rffi' are not available for package 'SpiderMonkey'
# 10 XMLSchema     TRUE    

# === From omegahat site =======
# # A tibble: 20 × 2
#    package        install_success
#    <chr>          <lgl>          
#  1 CGIwithR       TRUE           
#  2 R2GoogleMaps   TRUE           
#  3 RAmazonDBREST  TRUE           
#  4 Rcompression   FALSE      # Please define LIB_ZLIB    
#  5 RDCOMClient    TRUE           
#  6 RDCOMServer    FALSE      # package ‘RDCOMServer’ is not available for this version of R    
#  7 Rflickr        TRUE           
#  8 RGoogleDocs    TRUE           
#  9 RGoogleStorage TRUE           
# 10 RGoogleTrends  TRUE           
# 11 RHTMLForms     TRUE           
# 12 RTidyHTML      FALSE      # make: cc: No such file or directory; make: *** [<builtin>: access.o] Error 127    
# 13 RUbigraph      FALSE      # undefined exports: runUbigraph    
# 14 SpiderMonkey   FALSE      # ERROR: dependencies 'RAutoGenRunTime', 'Rffi' are not available for package 'SpiderMonkey    
# 15 SSOAP          TRUE           
# 16 SXalan         FALSE          
# 17 Sxslt          FALSE      # Please define LIB_XSLT       
# 18 WADL           TRUE           
# 19 XMLRPC         TRUE           
# 20 XMLSchema      TRUE 
