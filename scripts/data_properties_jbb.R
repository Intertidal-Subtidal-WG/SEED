

# initial set up ----------------------------------------------------------

## where am I working?
here::here()

## load required packages
library(readr)
library(purrr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)


# data import -------------------------------------------------------------

## create lists of data files

int.files <- ## intertidal data files
  list.files("data/intertidal", pattern = "v2.csv") %>% 
  paste("data/intertidal/", ., sep = "")

sub.files <- ## subtidal data files (keen)
  list.files("data/keen", pattern = "*.csv") %>% 
  paste("data/keen/", ., sep = "")

## import data into a list a split the list into the working environment
remove.i <- c("data/intertidal/", ".csv$") ## to drop from names
list2env( ## intertidal
  lapply(
    setNames(int.files,
             make.names(
               str_remove_all(int.files, 
                              paste(remove.i, 
                                    collapse = "|")))), 
    read_csv), envir = .GlobalEnv)


remove.s <- c("data/keen/", ".csv$") ## to drop from names
list2env( ## intertidal
  lapply(
    setNames(sub.files, 
             make.names(
               str_remove_all(sub.files, 
                              paste(remove.s, 
                                    collapse = "|")))), 
    read_csv), envir = .GlobalEnv)

## clean up environment
rm(int.files, sub.files, remove.i, remove.s)
