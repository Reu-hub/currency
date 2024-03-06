
# starts: -----------------------------------------------------------------
# loading necesary libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(rvest)
  library(janitor)
})

# loading necessary rscripts
source(file = "R/kenya.R")

# setting options
options(timeout = 600, scipen = 999)

# scraping data: ----------------------------------------------------------
df_raw = kshs_usd()

# exporting final data
kshs_usd_data_final()
# ends --------------------------------------------------------------------


