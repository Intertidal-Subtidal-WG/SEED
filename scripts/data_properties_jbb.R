

# initial set up ----------------------------------------------------------

## where am I working?
here::here()

## load required packages
# library(tidyverse)
library(readr)
library(purrr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(skimr)


# data import -------------------------------------------------------------

## create lists of data files

int.files <- ## intertidal data files
  list.files("data/intertidal", pattern = "v2.csv") %>% 
  paste("data/intertidal/", ., sep = "")

sub.files <- ## subtidal data files (keen)
  list.files("data/keen", pattern = "*.csv") %>% 
  paste("data/keen/", ., sep = "")

## strings to drop from data table names
remove.i <- c("data/intertidal/", "_data_v2.csv$") ## intertidal

remove.s <- c("data/keen/keen_", ".csv$") ## subtidal

## import data into a list a split the list into the working environment

int_data <- map(int.files, read_csv) %>% ## intertidal
  map(., ~ select(., -X1)) %>% 
  set_names(paste(
    str_remove_all(int.files, 
                   paste(remove.i, 
                         collapse = "|")), 
    "_i", sep = "")) %>% 
  list2env(.GlobalEnv)


sub_data <- map(sub.files, read_csv) %>% ## intertidal
  # map(., ~ select(., -X1)) %>% 
  set_names(paste(
    str_remove_all(sub.files, 
                   paste(remove.s, 
                         collapse = "|")), 
    "_s", sep = "")) %>% 
  list2env(.GlobalEnv)


## one table in intertidal data with a different string format
kelp_quads_biomass_s <- `data/keen/kelp_quads_biomass_s` 
rm(`data/keen/kelp_quads_biomass_s`) ## remove old version

## clean up environment
rm(int.files, sub.files, remove.i, remove.s, int_data, sub_data)


# start exploring ---------------------------------------------------------

## let's start by exploring what's in the various intertidal data tables

## categories_i, counts_i, percent_cover_i, sites_i
skim(categories_i)


## what's about the subtidal data?

## cover_s, fish_s, kelp_quads_biomass_s, kelp_s, quads_s, sites_s, swath_s






paste(str_remove_all(int.files, 
               paste(remove.i, 
                     collapse = "|")), "_i", sep = "")



lapply(int.files, read_csv, (col_types = col(`Year` = col_skip())))
x <- map(int.files, read_csv)

x <- map(x, ~ select(., -X1))
map_dfr