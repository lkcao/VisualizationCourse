Uncertainty
================
Likun Cao
2020-07-29

# Task 2: Visualizing uncertainty with gapminder

For this exercise you’ll revisit Hans Rosling’s gapminder data on health
and wealth. Install the **gapminder** package if you haven’t already.
Also install the **ggridges** and **gghalves** packages.

``` r
library(tidyverse)  # For ggplot, dplyr, and friends
library(gapminder)  # For health/wealth data
library(ggridges)   # For ridge plots
library(gghalves)   # For half geoms
```

## Histograms

Make a histogram of *logged* GDP per capita for 1997 only, across all
five continents.

``` r
# Create a filtered dataset
gapminder_filtered <- gapminder %>%
  filter(year == 1997)%>%
  mutate(log_gdp=log(gdpPercap,10))
```

``` r
ggplot(gapminder_filtered,mapping=aes(x=log_gdp,fill=continent))+
  geom_histogram(alpha=0.5)+
  facet_wrap(~continent)+
  labs(title = "Logged GDP across Continents",x = "log(GDP)", y = "count")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](03-uncertainty_files/figure-gfm/plot-histogram-1.png)<!-- -->

## Densities

Make a ridge plot of life expectancy over time, from 1952 to 2007.
You’ll need to use the full gapminder data, not the 1997-only data.

``` r
gapminder <- gapminder %>%
  mutate(year_fact= factor(year))

ggplot(gapminder, aes(x = lifeExp, y = fct_rev(year_fact), fill = year_fact)) +
  geom_density_ridges() +
  guides(fill = FALSE)+
  labs(title="Ridge Plot for Life Expectancy",x="Life Expectancy", y="year")
```

    ## Picking joint bandwidth of 3.88

![](03-uncertainty_files/figure-gfm/plot-ridgeplot-1.png)<!-- -->

## Boxes, violins, and friends

Make a filtered dataset that selects data from only 2007 *and* removes
Oceania. Show the distribution of *logged* GDP per capita across the
*four* continents using some combination of boxplots and/or violin plots
and/or strip plots, either overlaid on top of each other, or using their
`geom_half_*()` counterparts from **gghalves**.

``` r
gapminder_filtered2 <- gapminder %>%
  filter(year == 2007)%>%
  filter (continent !='Oceania')
```

``` r
ggplot(gapminder_filtered2 ,
       aes(x = continent, y = gdpPercap)) +
  geom_half_boxplot(aes(fill = continent), side = "l", width = 0.5, nudge = 0.1) +
  geom_half_point(aes(color = continent), side = "l", size = 0.5) +
  geom_half_violin(aes(fill = continent), side = "r") +
  guides(color = FALSE, fill = FALSE)+
  labs(title='Half Plot for Distribution of Log GDP across Continents',x='contient',y='GDP')+
  guides(color = FALSE, fill = FALSE) +
  coord_flip()+
  theme_minimal()+
  scale_y_log10()
```

![](03-uncertainty_files/figure-gfm/plot-distribution-1.png)<!-- -->

## Session information

``` r
devtools::session_info()
```

    ## - Session info ---------------------------------------------------------------
    ##  setting  value                         
    ##  version  R version 4.0.1 (2020-06-06)  
    ##  os       Windows 10 x64                
    ##  system   x86_64, mingw32               
    ##  ui       RTerm                         
    ##  language (EN)                          
    ##  collate  Chinese (Simplified)_China.936
    ##  ctype    Chinese (Simplified)_China.936
    ##  tz       America/Chicago               
    ##  date     2020-07-29                    
    ## 
    ## - Packages -------------------------------------------------------------------
    ##  package     * version date       lib source        
    ##  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.0)
    ##  backports     1.1.7   2020-05-13 [1] CRAN (R 4.0.0)
    ##  blob          1.2.1   2020-01-20 [1] CRAN (R 4.0.2)
    ##  broom         0.5.6   2020-04-20 [1] CRAN (R 4.0.2)
    ##  callr         3.4.3   2020-03-28 [1] CRAN (R 4.0.2)
    ##  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.0.0)
    ##  cli           2.0.2   2020-02-28 [1] CRAN (R 4.0.0)
    ##  colorspace    1.4-1   2019-03-18 [1] CRAN (R 4.0.2)
    ##  crayon        1.3.4   2017-09-16 [1] CRAN (R 4.0.0)
    ##  DBI           1.1.0   2019-12-15 [1] CRAN (R 4.0.2)
    ##  dbplyr        1.4.4   2020-05-27 [1] CRAN (R 4.0.2)
    ##  desc          1.2.0   2018-05-01 [1] CRAN (R 4.0.2)
    ##  devtools      2.3.1   2020-07-21 [1] CRAN (R 4.0.2)
    ##  digest        0.6.25  2020-02-23 [1] CRAN (R 4.0.0)
    ##  dplyr       * 1.0.0   2020-05-29 [1] CRAN (R 4.0.0)
    ##  ellipsis      0.3.1   2020-05-15 [1] CRAN (R 4.0.0)
    ##  evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.2)
    ##  fansi         0.4.1   2020-01-08 [1] CRAN (R 4.0.0)
    ##  farver        2.0.3   2020-01-16 [1] CRAN (R 4.0.2)
    ##  forcats     * 0.5.0   2020-03-01 [1] CRAN (R 4.0.2)
    ##  fs            1.4.1   2020-04-04 [1] CRAN (R 4.0.2)
    ##  gapminder   * 0.3.0   2017-10-31 [1] CRAN (R 4.0.2)
    ##  generics      0.0.2   2018-11-29 [1] CRAN (R 4.0.0)
    ##  gghalves    * 0.1.0   2020-03-28 [1] CRAN (R 4.0.2)
    ##  ggplot2     * 3.3.2   2020-06-19 [1] CRAN (R 4.0.2)
    ##  ggridges    * 0.5.2   2020-01-12 [1] CRAN (R 4.0.2)
    ##  glue          1.4.1   2020-05-13 [1] CRAN (R 4.0.0)
    ##  gtable        0.3.0   2019-03-25 [1] CRAN (R 4.0.2)
    ##  haven         2.3.1   2020-06-01 [1] CRAN (R 4.0.2)
    ##  hms           0.5.3   2020-01-08 [1] CRAN (R 4.0.0)
    ##  htmltools     0.5.0   2020-06-16 [1] CRAN (R 4.0.2)
    ##  httr          1.4.1   2019-08-05 [1] CRAN (R 4.0.0)
    ##  jsonlite      1.7.0   2020-06-25 [1] CRAN (R 4.0.2)
    ##  knitr         1.29    2020-06-23 [1] CRAN (R 4.0.2)
    ##  labeling      0.3     2014-08-23 [1] CRAN (R 4.0.0)
    ##  lattice       0.20-41 2020-04-02 [2] CRAN (R 4.0.1)
    ##  lifecycle     0.2.0   2020-03-06 [1] CRAN (R 4.0.0)
    ##  lubridate     1.7.9   2020-06-08 [1] CRAN (R 4.0.2)
    ##  magrittr      1.5     2014-11-22 [1] CRAN (R 4.0.0)
    ##  memoise       1.1.0   2017-04-21 [1] CRAN (R 4.0.2)
    ##  modelr        0.1.8   2020-05-19 [1] CRAN (R 4.0.2)
    ##  munsell       0.5.0   2018-06-12 [1] CRAN (R 4.0.2)
    ##  nlme          3.1-148 2020-05-24 [2] CRAN (R 4.0.1)
    ##  pillar        1.4.4   2020-05-05 [1] CRAN (R 4.0.0)
    ##  pkgbuild      1.0.8   2020-05-07 [1] CRAN (R 4.0.2)
    ##  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.0)
    ##  pkgload       1.1.0   2020-05-29 [1] CRAN (R 4.0.2)
    ##  plyr          1.8.6   2020-03-03 [1] CRAN (R 4.0.2)
    ##  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.0.0)
    ##  processx      3.4.2   2020-02-09 [1] CRAN (R 4.0.2)
    ##  ps            1.3.3   2020-05-08 [1] CRAN (R 4.0.2)
    ##  purrr       * 0.3.4   2020-04-17 [1] CRAN (R 4.0.0)
    ##  R6            2.4.1   2019-11-12 [1] CRAN (R 4.0.0)
    ##  Rcpp          1.0.4.6 2020-04-09 [1] CRAN (R 4.0.0)
    ##  readr       * 1.3.1   2018-12-21 [1] CRAN (R 4.0.2)
    ##  readxl        1.3.1   2019-03-13 [1] CRAN (R 4.0.0)
    ##  remotes       2.2.0   2020-07-21 [1] CRAN (R 4.0.2)
    ##  reprex        0.3.0   2019-05-16 [1] CRAN (R 4.0.2)
    ##  rlang         0.4.7   2020-07-09 [1] CRAN (R 4.0.2)
    ##  rmarkdown     2.3     2020-06-18 [1] CRAN (R 4.0.2)
    ##  rprojroot     1.3-2   2018-01-03 [1] CRAN (R 4.0.2)
    ##  rstudioapi    0.11    2020-02-07 [1] CRAN (R 4.0.2)
    ##  rvest         0.3.5   2019-11-08 [1] CRAN (R 4.0.0)
    ##  scales        1.1.1   2020-05-11 [1] CRAN (R 4.0.2)
    ##  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.2)
    ##  stringi       1.4.6   2020-02-17 [1] CRAN (R 4.0.0)
    ##  stringr     * 1.4.0   2019-02-10 [1] CRAN (R 4.0.2)
    ##  testthat      2.3.2   2020-03-02 [1] CRAN (R 4.0.2)
    ##  tibble      * 3.0.1   2020-04-20 [1] CRAN (R 4.0.0)
    ##  tidyr       * 1.1.0   2020-05-20 [1] CRAN (R 4.0.2)
    ##  tidyselect    1.1.0   2020-05-11 [1] CRAN (R 4.0.0)
    ##  tidyverse   * 1.3.0   2019-11-21 [1] CRAN (R 4.0.2)
    ##  usethis       1.6.1   2020-04-29 [1] CRAN (R 4.0.2)
    ##  vctrs         0.3.1   2020-06-05 [1] CRAN (R 4.0.0)
    ##  withr         2.2.0   2020-04-20 [1] CRAN (R 4.0.2)
    ##  xfun          0.15    2020-06-21 [1] CRAN (R 4.0.2)
    ##  xml2          1.3.2   2020-04-23 [1] CRAN (R 4.0.2)
    ##  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.0)
    ## 
    ## [1] C:/Users/Kun/Documents/R/win-library/4.0
    ## [2] C:/Program Files/R/R-4.0.1/library
