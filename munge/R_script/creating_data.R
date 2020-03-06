##############################################################################-
## Project: FA workshop
## Script purpose: read SPSS data and create dataset
## Date: 2020-03-05
## Author: Filipe Recch
##############################################################################-

##  Overview ----
##############################################################################-

## Packages, Parameters, & Input Data ----
##############################################################################-
suppressPackageStartupMessages(library(conflicted))
suppressPackageStartupMessages(library(janitor))
suppressPackageStartupMessages(library(magrittr))
suppressPackageStartupMessages(library(tidyverse))

# Paths and file names --------------------------------------------------------

source("file_paths.R")

data_file_paths <- fs::dir_ls(data_raw)

##  Reading in country data and joining ----
##############################################################################-

data_all_ctry <- tibble()

for (p in data_file_paths) {
  path_data <- fs::path_file(p)
  ctry <- fs::path_ext_remove(
    fs::path_file(path_data)
    )
  data_temp <- haven::read_spss(p) %>% 
    select("CNTRYID", "ID", 
           "CS4K1", 	"CS4K2", 	"CS4K3", 	"CS4K4", 	"CS4K5", 	"CS4K6", 	"CS4K7",
           "CS4N1", 	"CS4N2", 	"CS4N3", 	"CS4N4", 	"CS4N5",  "CS4N6", 	"CS4N7", 	
           "CS4N8", 	"CS4N9", 	"CS4N10", "CS4N11", "CS4N12")
  assign(eval(ctry), data_temp)
  rm(data_temp)
}

###  Joining and saving data ----
##############################################################################-

data_all_ctry <- bind_rows(
  mget(
    fs::path_ext_remove(
      fs::path_file(data_file_paths)
      )
    )
  )

readr::write_excel_csv(data_all_ctry, fs::path(data_root, "data_all_ctry.csv"))


