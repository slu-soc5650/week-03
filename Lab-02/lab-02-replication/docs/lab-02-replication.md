Lab 02 Notebook
================
Christopher Prener, Ph.D.
(February 08, 2018)

Introduction
------------

This is the replication notebook for Lab-0 from the course SOC 4650/5650: Introduction to GISc.

Project Set Up
--------------

``` r
knitr::opts_knit$set(root.dir = here::here())
```

Load Dependencies
-----------------

The following code loads the package dependencies for our analysis:

``` r
# tidyverse
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

``` r
library(readr) # data import

# other packages
library(janitor)
library(naniar)
```

Load Data
---------

The following code loads the data package and assigns our data to a data frame in our global environment:

``` r
riversRaw <- read_csv("data/MO_HYDRO_ImpairedRiversStreams.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_character(),
    ##   YR = col_integer(),
    ##   BUSINESSID = col_integer(),
    ##   WBID = col_double(),
    ##   MDNR_IMPSZ = col_double(),
    ##   SIZE_ = col_double(),
    ##   EPA_APPRSZ = col_double(),
    ##   UP_X = col_double(),
    ##   UP_Y = col_double(),
    ##   DWN_X = col_double(),
    ##   DWN_Y = col_double(),
    ##   EVENTDAT = col_date(format = ""),
    ##   FMEASURE = col_double(),
    ##   TMEASURE = col_double(),
    ##   SHAPE_Leng = col_double(),
    ##   Shape_Le_1 = col_double()
    ## )

    ## See spec(...) for full column specifications.

``` r
riversTibble <- as_tibble(riversRaw)
```

Part 1
------

### Question 7

The following pipeline renames the variables all to snake case and then makes some specific changes to `eventdat` and `county_u_d` to make them easier to work with:

``` r
riversTibble %>%
  clean_names(case = "snake") %>%
  rename(date = eventdat) %>%
  rename(county = county_u_d) -> riversTibble
```

We now have a tibble with uniformly named variables.

### Question 8

The following function from the `naniar` package gives us a table of the number of missing observations per variable:

``` r
miss_var_summary(riversTibble)
```

    ## # A tibble: 31 x 3
    ##      variable n_missing     percent
    ##         <chr>     <int>       <dbl>
    ##  1  rchsmdate      6029 100.0000000
    ##  2    rch_res      6029 100.0000000
    ##  3   feat_url      6029 100.0000000
    ##  4    perm_id       256   4.2461436
    ##  5       date       256   4.2461436
    ##  6         ou        56   0.9288439
    ##  7         yr         0   0.0000000
    ##  8 businessid         0   0.0000000
    ##  9       wbid         0   0.0000000
    ## 10 water_body         0   0.0000000
    ## # ... with 21 more rows

The variables `rchsmdate`, `rch_res`, and `feat_url` are all missing for every observation in the data set. There are also three other variables - `perm_id`, `date`, and `ou` - that has some missing data.

### Question 9

The `get_dupes()` function, without specifying any specific variables, will report each identical observation in the data set:

``` r
get_dupes(riversTibble)
```

    ## No variable names specified - using all columns.

    ## # A tibble: 36 x 32
    ##       yr businessid  wbid water_body wb_cls mdnr_impsz  size epa_apprsz
    ##    <int>      <int> <dbl>      <chr>  <chr>      <dbl> <dbl>      <dbl>
    ##  1  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  2  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  3  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  4  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  5  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  6  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  7  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  8  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ##  9  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ## 10  2010      51730  2579  Platte R.      P      142.4 142.4      142.4
    ## # ... with 26 more rows, and 24 more variables: unit <chr>,
    ## #   pollutant <chr>, source <chr>, iu <chr>, ou <chr>, up_x <dbl>,
    ## #   up_y <dbl>, dwn_x <dbl>, dwn_y <dbl>, county <chr>, wb_epa <chr>,
    ## #   comment <chr>, perm_id <chr>, date <date>, reachcode <chr>,
    ## #   rchsmdate <chr>, rch_res <chr>, src_desc <chr>, feat_url <chr>,
    ## #   fmeasure <dbl>, tmeasure <dbl>, shape_leng <dbl>, shape_le_1 <dbl>,
    ## #   dupe_count <int>

There are a total of 36 rows. We can look at the `dupe_count` variable by scrolling all the way to the right in the interactive table in our notebook. If you scan through that list of values, you'll see there 2's for each row. There are 36 rows total. Dividing the total number of rows by 2, since each row as one duplicate, gives us 18 unique observations in these 36 rows.

### Question 10

This time, we'll specify the specific variable we want to look for duplicates in. We're interested in the `perm_id` variable since it appears to be an identification number variable.

``` r
get_dupes(riversTibble, perm_id)
```

    ## # A tibble: 2,349 x 32
    ##                                   perm_id dupe_count    yr businessid
    ##                                     <chr>      <int> <int>      <int>
    ##  1 {0034FF55-A18A-4963-9779-071E6E2086B3}          3  2006      51618
    ##  2 {0034FF55-A18A-4963-9779-071E6E2086B3}          3  2008      51620
    ##  3 {0034FF55-A18A-4963-9779-071E6E2086B3}          3  2006      51619
    ##  4 {00B100BE-A84F-497C-BE54-35D5F3F60793}          2  2008      51018
    ##  5 {00B100BE-A84F-497C-BE54-35D5F3F60793}          2  2008      51770
    ##  6 {0145F682-2D9F-4FE8-9BB1-1A32BBE0B2DA}          2  2006      51487
    ##  7 {0145F682-2D9F-4FE8-9BB1-1A32BBE0B2DA}          2  2006      51486
    ##  8 {019A3253-616F-43E6-BDC9-EC98AF1A6207}          4  2006      51548
    ##  9 {019A3253-616F-43E6-BDC9-EC98AF1A6207}          4  2010      55224
    ## 10 {019A3253-616F-43E6-BDC9-EC98AF1A6207}          4  2014      62493
    ## # ... with 2,339 more rows, and 28 more variables: wbid <dbl>,
    ## #   water_body <chr>, wb_cls <chr>, mdnr_impsz <dbl>, size <dbl>,
    ## #   epa_apprsz <dbl>, unit <chr>, pollutant <chr>, source <chr>, iu <chr>,
    ## #   ou <chr>, up_x <dbl>, up_y <dbl>, dwn_x <dbl>, dwn_y <dbl>,
    ## #   county <chr>, wb_epa <chr>, comment <chr>, date <date>,
    ## #   reachcode <chr>, rchsmdate <chr>, rch_res <chr>, src_desc <chr>,
    ## #   feat_url <chr>, fmeasure <dbl>, tmeasure <dbl>, shape_leng <dbl>,
    ## #   shape_le_1 <dbl>

There are 2,349 instances of duplicate identification numbers. This variable does not uniquely identify observations, and therefore is not a good identification variable. **After experimenting with this function and knitr, there is no need to remove it from your notebook. It creates clear, concise output.**

### Question 11

The following pipeline removes observations that are not in St. Louis, and subsets the variables so that we have a more limited tibble to work with.

``` r
riversTibble %>%
  filter(county == "St. Louis") %>%
  select(yr, wbid, water_body, pollutant, source) -> stlTibble
```

Looking in our global environment, we now have only 179 observations across these 5 variables.

### Question 12

Finally, we'll make some specific changes to the `water_body` variable and create a new binary variable that is `TRUE` when the pollutant is E. coli:

``` r
stlTibble %>%
  mutate(water_body = ifelse(water_body == "Gravois Creek tributary", "Gravois Cr. tributary", water_body)) %>%
  mutate(water_body = ifelse(water_body == "Twomile Creek", "Twomile Cr.", water_body)) %>%
  mutate(water_body = ifelse(water_body == "Watkins Creek tributary", "Watkins Cr. tributary", water_body)) %>%
  mutate(ecoli = ifelse(pollutant == "Escherichia coli (W)", TRUE, FALSE)) -> stlTibble
```

We now have a binary measure for assessing the incidence of E. Coli pollution in St. Louis as well as a standardized set of values for the body of water variable.
