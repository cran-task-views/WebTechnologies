# See https://github.com/cran-task-views/WebTechnologies/issues/505

# Copy from the bottom of https://cran.r-project.org/web/views/WebTechnologies.html:
packages <- c(
  "dashR",
  "discgolf",
  "feedeR",
  "formr",
  "gdns",
  "ipapi",
  "meetupr",
  "mockaRoo",
  "nominatim",
  "PostcodesioR",
  "randNames",
  "rcloud",
  "RDoubleClick",
  "rydn",
  "securitytxt",
  "stackr",
  "twitter_ideology",
  "twitterreport",
  "urlshorteneR",
  "useRsnap"
)

packages |> 
  rlang::set_names() |> 
  purrr::map_lgl(available::available_on_cran) |> 
  tibble::enframe(
    value = "available_on_cran"
  )

# # A tibble: 20 × 2
# name             available_on_cran 
# dashR            TRUE             
# discgolf         FALSE # Archived on 2022-11-06 at the maintainer's request.
# feedeR           FALSE # Archived on 2021-10-05 as check problems were not corrected in time.
# formr            TRUE             
# gdns             FALSE # Archived on 2022-05-07 as calls defunct default.stringsAsFactors()
# ipapi            TRUE             
# meetupr          TRUE             
# mockaRoo         TRUE             
# nominatim        TRUE             
# PostcodesioR     FALSE # now on cran         
# randNames        FALSE # Archived on 2022-08-22 at the maintainer's request.            
# rcloud           TRUE             
# RDoubleClick     TRUE             
# rydn             TRUE             
# securitytxt      FALSE # Archived on 2021-05-14 as check problems were not corrected in time.           
# stackr           TRUE             
# twitter_ideology TRUE             
# twitterreport    TRUE             
# urlshorteneR     FALSE # now on cran            
# useRsnap         TRUE    

# p <- packages[1]
# p <- "analogsea"
# address <- sprintf("https://CRAN.R-project.org/package=%s", p)
# 
# url(address)
# available::available_on_cran(p)
