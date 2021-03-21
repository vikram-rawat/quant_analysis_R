
# load library --------------------

library("quantmod")
library("data.table")
library("FinancialMath")
library("ggplot2")
# library("WDI")
library("wbstats")
library("imfr")
library("stringi")
library("skimr")

# set_ defaults -------------------

setDTthreads(0L)

country_names <- 
  c("India", 
    "United States",
    "Japan",
    "United Kingdom",
    "Australia")

# source files --------------------

source("R/functions.R")

# get_data ------------------------

new_wb_cache <- wb_cache() 

View(new_wb_cache$countries)

skim(new_wb_cache$countries)
skim(new_wb_cache$indicators)
skim(new_wb_cache$sources)
skim(new_wb_cache$topics)
skim(new_wb_cache$regions)
skim(new_wb_cache$income_levels)
skim(new_wb_cache$lending_types)
skim(new_wb_cache$languages)

get_wbi_count(
  indicator = "GDP",
  country_id = "IN")
