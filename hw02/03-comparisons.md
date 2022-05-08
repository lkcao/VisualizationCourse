Comparisons
================
Likun Cao
2020-07-28

``` r
library(tidyverse)
library(broom)

unemployment <- read_csv("data/unemployment.csv")
```

Use data from the US Bureau of Labor Statistics (BLS) to show the trends
in employment rate for all 50 states between 2006 and 2016.

**What stories does this plot tell? Which states struggled to recover
from the 2008–09 recession?**

Some hints/tips:

  - You’ll be plotting 51 facets. You can filter out DC if you want to
    have a better grid (like 5 × 10), or you can try using `facet_geo()`
    from the [**geofacet** package](https://hafen.github.io/geofacet/)
    to lay out the plots like a map of the US (try this\!).

  - Try mapping other aesthetics onto the graph too. You’ll notice there
    are columns for region and division—play with those as colors, for
    instance.

  - This plot might be big, so make sure you adjust `fig.width` and
    `fig.height` in the chunk options so that it’s visible when you knit
    it.

<!-- end list -->

``` r
unemployment1 <- unemployment %>% 
  filter(state != "Washington")

ggplot(data=unemployment1,mapping=aes(date,unemployment,fig.width=1,fig.height=1))+
  geom_line(size=1)+
  theme_void()+
  facet_wrap(vars(state), scales = "free_y",nrow = 5)+
  theme(strip.text = element_text(face = "bold"))
```

![](03-comparisons_files/figure-gfm/small-multiples-1.png)<!-- -->
Story: The unemployment first rises up, and them came back to normal
after 2008 for most states. Several states, including Louisiana and New
Mexico did not recover very well from the 2008 recession.

# Slopegraphs

Use data from the BLS to create a slopegraph that compares the
unemployment rate in January 2006 with the unemployment rate in January
2009, either for all 50 states at once (good luck with that\!) or for a
specific region or division. Make sure the plot doesn’t look too busy or
crowded in the end.

**What story does this plot tell? Which states in the US (or in the
specific region you selected) were the most/least affected the Great
Recession?**

``` r
northeast <- unemployment %>% 
  filter(region == 'Northeast') %>% 
  filter(year %in% c(2006, 2009)) %>% 
  filter(month_name=='January') %>%
  mutate(year = factor(year)) %>% 
  mutate(label_first = ifelse(year == 2006, str_c(state, ": ", unemployment), NA),
  label_last = ifelse(year == 2009,str_c(unemployment), NA))

library(ggrepel)
```

    ## Warning: package 'ggrepel' was built under R version 4.0.2

``` r
ggplot(northeast, aes(x = year, y = unemployment, group = state, color = state)) +
  geom_line(size = 1.5)+
  geom_text_repel(aes(label = label_first), direction = "y", nudge_x = -1, seed = 1234) +
  geom_text_repel(aes(label = label_last), direction = "y", nudge_x = 1, seed = 1234) +
  guides(color = FALSE)+
  theme_minimal()
```

    ## Warning: Removed 9 rows containing missing values (geom_text_repel).

    ## Warning: Removed 9 rows containing missing values (geom_text_repel).

![](03-comparisons_files/figure-gfm/slopegraphs-1.png)<!-- -->

In this figure I show the slopegraph of unemployment of Northeast region
(from 2006-2009). Most states in the northeast has an increasing
unemployment rate during this period. Rhode Island is the most affected
state in the northeast.

## Bump charts

Create a bump chart showing something from the unemployment data
(perhaps the top 10 states or bottom 10 states in unemployment?)

If you do this, plotting 51 lines is going to be a huge mess. But
filtering the data is also a bad idea, because states could drop in and
out of the top/bottom 10 over time, and we don’t want to get rid of
them. Instead, you can zoom in on a specific range of data in your plot
with `coord_cartesian(ylim = c(1, 10))`, for instance.

``` r
rank_df<- unemployment %>% 
  group_by(year,state) %>% 
  summarize(mean_unemployment=mean(unemployment))%>%
  group_by(year)%>%
  mutate(ranks = rank(mean_unemployment))
```

    ## `summarise()` regrouping output by 'year' (override with `.groups` argument)

``` r
ggplot(rank_df, aes(x = year, y = ranks, color = state)) +
  geom_line(size=1) +
  geom_point(size=2) +
  guides(color=FALSE)+
  coord_cartesian(ylim = c(10, 1))+
  scale_y_reverse(breaks = 1:10)+
  labs(x = NULL, y = "Rank") +
  theme_minimal() +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank())
```

![](03-comparisons_files/figure-gfm/bumpchart-1.png)<!-- -->

This figure shows the 10 states with the lowest unemployment rates from
2006 to 2016. The yearly unemployment rate is calculated as the average
unemployment rate throughout the year. \#\# Session information

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
    ##  date     2020-07-28                    
    ## 
    ## - Packages -------------------------------------------------------------------
    ##  package     * version date       lib source        
    ##  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.0)
    ##  backports     1.1.7   2020-05-13 [1] CRAN (R 4.0.0)
    ##  blob          1.2.1   2020-01-20 [1] CRAN (R 4.0.2)
    ##  broom       * 0.5.6   2020-04-20 [1] CRAN (R 4.0.2)
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
    ##  generics      0.0.2   2018-11-29 [1] CRAN (R 4.0.0)
    ##  ggplot2     * 3.3.2   2020-06-19 [1] CRAN (R 4.0.2)
    ##  ggrepel     * 0.8.2   2020-03-08 [1] CRAN (R 4.0.2)
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
