
# starts: -----------------------------------------------------------------
# loading necesary libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(rvest)
  library(janitor)
})

# loading necessary rscripts
source(file = "R/kenya.R")
source(file = "R/uganda.R")
source(file = "R/rwanda.R")
source(file = "R/ethiopia.R")

# setting options
options(timeout = 600, scipen = 999)

# scraping data: ----------------------------------------------------------
# kenya: ------------------------------------------------------------------
# system sleeps for 3 seconds
Sys.sleep(time = 3)
# getting raw data
df_raw = kshs_usd()
# exporting final data
kshs_usd_data_final()

# uganda: -----------------------------------------------------------------
# system sleeps for 3 seconds
Sys.sleep(time = 3)
# getting raw data
df_uganda <- ugshs_usd()
# exporting final data
ugshs_usd_data_final()

# tanzania: ---------------------------------------------------------------


# rwanda: -----------------------------------------------------------------
# system sleeps for 3 seconds
Sys.sleep(time = 3)
# getting raw data
df_rwanda <- rwanda_usd()
# exporting final data
rwanda_usd_data_final()

# burundi: ----------------------------------------------------------------


# ethiopia: ---------------------------------------------------------------
# system sleeps for 3 seconds
Sys.sleep(time = 3)
# getting raw data
df_ethiopia <- ethiopia_usd()
# exporting final data
ethiopia_usd_data_final()

# ends --------------------------------------------------------------------


