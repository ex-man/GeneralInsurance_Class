message("Loading project specific setup [project .Rprofile]")
if(!dir.exists("data")) dir.create("data")

# fix to MRAN to have versions of packages they were available when R 3.4.2 were most recent
message("CRAN is fixed to 2017-10-15 date.")
options(repos=structure(c(CRAN='https://mran.revolutionanalytics.com/snapshot/2017-10-15/')))

#### -- Packrat Autoloader (version 0.4.8-1) -- ####
source("packrat/init.R")
#### -- End Packrat Autoloader -- ####

message("End of project specific setup [project .Rprofile]")

