Lecture Prep 03 Notebook
================
Christopher Prener, Ph.D.
(January 31, 2018)

Introduction
------------

This is the replication notebook for Lecture Prep 03 from the course SOC 4650/5650: Introduction to GISc.

Project Set Up
--------------

``` r
knitr::opts_knit$set(root.dir = here::here())
```

Load Dependencies
-----------------

The following code loads the package dependencies for our analysis:

``` r
library(dplyr) # data wrangling
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Load Data
---------

The following code loads the data package and assigns our data to a data frame in our global environment:

``` r
library(stlData) # data source
leadData <- stlLead
```

Part 1
------

### Question 7

The `as_tibble()` output is much easier to read. Instead of printing every observation in the data frame, it only prints the first ten. It also only prints a selection of columns instead of printing all of them.

### Question 8

The following code converts the `leadData` object to a tibble named `leadTibble`:

``` r
leadTibble <- as_tibble(leadData)
```
