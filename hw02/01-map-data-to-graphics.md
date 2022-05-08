Mapping data to graphics
================
Likun Cao
2020-07-28

## Load and clean data

First we load, restructure, and clean the data.

``` r
# You'll only need the tidyverse library for this exercise
library(tidyverse)

# Load the separate datasets
fellowship <- read_csv("data/The_Fellowship_Of_The_Ring.csv")
tt <- read_csv("data/The_Two_Towers.csv")
rotk <- read_csv("data/The_Return_Of_The_King.csv")

# bind_rows() stacks data frames on top of each other
lotr_wide <- bind_rows(fellowship, tt, rotk) %>% 
  # Make the Film column a categorical variable (factor), and put it in the
  # order the categories appear (so the films are in the correct order)
  mutate(Film = fct_inorder(Film))

# Make this wide data tidy
lotr <- lotr_wide %>% 
  # This is the new way to make data long
  pivot_longer(cols = c(Female, Male), 
               names_to = "Gender", values_to = "Words")
```

## Race

Use `group_by()` and `summarize()` on the `lotr` data to find the total
number of words spoken by race. *Don’t worry about plotting it*. How
many words did male hobbits say in the movies?

``` r
(race<-lotr %>% group_by(Race,Gender)%>%
  summarize(words_sum=sum(Words,na.rm=TRUE)))
```

    ## `summarise()` regrouping output by 'Race' (override with `.groups` argument)

    ## # A tibble: 6 x 3
    ## # Groups:   Race [3]
    ##   Race   Gender words_sum
    ##   <chr>  <chr>      <dbl>
    ## 1 Elf    Female      1743
    ## 2 Elf    Male        1994
    ## 3 Hobbit Female        16
    ## 4 Hobbit Male        8780
    ## 5 Man    Female       669
    ## 6 Man    Male        8043

So the answer for this question is 8780.

## Gender and film

Use `group_by()` and `summarize()` to answer these questions *with bar
plots* (`geom_col()`)

  - Does a certain race dominate the entire trilogy? (hint: group by
    `Race`)

  - Does a certain gender dominate a movie? (lolz of course it does, but
    still, graph it) (Hint: group by both `Gender` and `Film`.)
    Experiment with filling by `Gender` or `Film` and faceting by
    `Gender` or `Film`.

<!-- end list -->

``` r
(race2<-lotr %>% group_by(Race)%>%
  summarize(words_sum=sum(Words,na.rm=TRUE)))
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

    ## # A tibble: 3 x 2
    ##   Race   words_sum
    ##   <chr>      <dbl>
    ## 1 Elf         3737
    ## 2 Hobbit      8796
    ## 3 Man         8712

``` r
ggplot(data=race2,mapping=aes(Race,words_sum))+
  geom_col()
```

![](01-map-data-to-graphics_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
(gender<-lotr %>% group_by(Gender, Film)%>%
  summarize(words_sum=sum(Words,na.rm=TRUE)))
```

    ## `summarise()` regrouping output by 'Gender' (override with `.groups` argument)

    ## # A tibble: 6 x 3
    ## # Groups:   Gender [2]
    ##   Gender Film                       words_sum
    ##   <chr>  <fct>                          <dbl>
    ## 1 Female The Fellowship Of The Ring      1243
    ## 2 Female The Two Towers                   732
    ## 3 Female The Return Of The King           453
    ## 4 Male   The Fellowship Of The Ring      6610
    ## 5 Male   The Two Towers                  6565
    ## 6 Male   The Return Of The King          5642

``` r
ggplot(data=gender,mapping=aes(Gender,words_sum,fill=Gender))+
  geom_col()+
  facet_wrap(~Film)
```

![](01-map-data-to-graphics_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->
For the first question: Hobbit and Man speak most, but Hobbit speak a
little more. For the second question：Males dominate all the three
movies.

## Race and film

Does the dominant race differ across the three movies? (Hint: group by
both `Race` and `Film`.) Experiment with filling by `Race` or `Film` and
faceting by `Race` or `Film`.

``` r
(race3<-lotr %>% group_by(Race, Film)%>%
  summarize(words_sum=sum(Words,na.rm=TRUE)))
```

    ## `summarise()` regrouping output by 'Race' (override with `.groups` argument)

    ## # A tibble: 9 x 3
    ## # Groups:   Race [3]
    ##   Race   Film                       words_sum
    ##   <chr>  <fct>                          <dbl>
    ## 1 Elf    The Fellowship Of The Ring      2200
    ## 2 Elf    The Two Towers                   844
    ## 3 Elf    The Return Of The King           693
    ## 4 Hobbit The Fellowship Of The Ring      3658
    ## 5 Hobbit The Two Towers                  2463
    ## 6 Hobbit The Return Of The King          2675
    ## 7 Man    The Fellowship Of The Ring      1995
    ## 8 Man    The Two Towers                  3990
    ## 9 Man    The Return Of The King          2727

``` r
ggplot(data=race3,mapping=aes(Race,words_sum,fill=Race))+
  geom_col()+
  facet_wrap(~Film)
```

![](01-map-data-to-graphics_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Answer:Hobbits dominate the first movie; Man dominates the second. And
Hobbit and Man have very close number of words in the third movie.

## Race and gender and film

Create a plot that visualizes the number of words spoken by race,
gender, and film simultaneously. Use the complete tidy `lotr` data
frame. You don’t need to create a new summarized dataset (with
`group_by(Race, Gender, Film)`) because the original data already has a
row for each of those (you could make a summarized dataset, but it would
be identical to the full version).

You need to show `Race`, `Gender`, and `Film` at the same time, but you
only have two possible aesthetics (`x` and `fill`), so you’ll also need
to facet by the third. Play around with different combinations (e.g. try
`x = Race`, then `x = Film`) until you find one that tells the clearest
story. For fun, add a `labs()` layer to add a title and subtitle and
caption.

``` r
ggplot(data=lotr,mapping=aes(Gender,Words,fill=Race))+
  geom_col(position='dodge')+
  facet_wrap(~Film)+
  labs(title='words of different characters',subtitle='movies',x='gender',y='words count')
```

![](01-map-data-to-graphics_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

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
    ##  date     2020-07-28                    
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
    ##  generics      0.0.2   2018-11-29 [1] CRAN (R 4.0.0)
    ##  ggplot2     * 3.3.2   2020-06-19 [1] CRAN (R 4.0.2)
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
    ##  utf8          1.1.4   2018-05-24 [1] CRAN (R 4.0.0)
    ##  vctrs         0.3.1   2020-06-05 [1] CRAN (R 4.0.0)
    ##  withr         2.2.0   2020-04-20 [1] CRAN (R 4.0.2)
    ##  xfun          0.15    2020-06-21 [1] CRAN (R 4.0.2)
    ##  xml2          1.3.2   2020-04-23 [1] CRAN (R 4.0.2)
    ##  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.0)
    ## 
    ## [1] C:/Users/Kun/Documents/R/win-library/4.0
    ## [2] C:/Program Files/R/R-4.0.1/library
