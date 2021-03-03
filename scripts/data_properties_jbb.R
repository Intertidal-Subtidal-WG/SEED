## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##
## Intertidal-Subtidal CIEE Working group             ##
## Contributor: Joseph Burant                         ##
## Last updated: 02 March 2021                        ##
## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ## -- ##


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
library(ggthemes)
library(skimr)

## set a plotting theme
theme_set(theme_few())

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

## COMMENT: 
## this works, but requires a specific file path...
## is there a way to do this with here(), to avoid having to
## build the list of files into paths and then strip the path off after
## import (see below)?

## import data into a list a split the list into the working environment
map(int.files, read_csv) %>% ## intertidal
  map(., ~ select(., -X1)) %>% ## drop row number column X1
  set_names(
    paste("i_", 
      str_remove_all(int.files, 
                     paste(remove.i, 
                           collapse = "|")), 
      sep = "")) %>% 
  list2env(.GlobalEnv)

map(sub.files, read_csv) %>% ## intertidal
  # map(., ~ select(., -X1)) %>% ## no row number column
  set_names(
    paste("s_", 
      str_remove_all(sub.files, 
                     paste(remove.s, 
                           collapse = "|")), 
      sep = "")) %>% 
  list2env(.GlobalEnv)

## one table in intertidal data with a different string format
s_kelp_quad_biomass <- `s_data/keen/kelp_quads_biomass` 
rm(`s_data/keen/kelp_quads_biomass`) ## remove old version

## COMMENT:
## all relevant tables from the subtidal (keen) and intertidal
## folders have been imported. 

## what tables do we have for each community?
ls(pattern = "s_") ## 7 tables from subtidal dataset

ls(pattern = "i_") ## 4 tables from the intertidal dataset

## clean up environment
rm(int.files, sub.files, remove.i, remove.s)


# exploration - intertidal data -------------------------------------------

## let's start by exploring what's in the various intertidal data tables

## categories, counts, percent_cover, sites
skim(i_categories)

## COMMENT: per discussion, categories file can be ignored as data should 
## also be represented in the percent_cover

skim(i_counts)
ggplot(data = i_counts, 
       mapping = aes(x = Year, y = Count, group = Organism)) + 
  geom_point() + 
  geom_line() + 
  facet_wrap(~ Organism)

# exploration - subtidal data ---------------------------------------------

## what's about the subtidal data?

## cover, fish, kelp_quad_biomass, kelp, quads, sites, swath

