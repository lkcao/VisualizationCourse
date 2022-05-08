Annotation
================
Likun Cao
2020-07-29

``` r
library(tidyverse)
library(gapminder) 
# Load data here
```

Do the following:

1.  Make a plot. Any kind of plot will do (though it might be easiest to
    work with `geom_point()`).

<!-- end list -->

``` r
gapminder1<-gapminder %>%
    filter(year == 2007)
ggplot(data=gapminder1,mapping=aes(x=gdpPercap,y=lifeExp,color=continent))+
    geom_point()+
    theme_minimal()+
    labs(title='Relationship between GDP per Capita and Life Expectancy in 2007',x='GDP per Capita (log scale)', y='Life Expectancy')+
    scale_x_log10()
```

![](04-annotation_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

1.  Label (some or all of) the points using one of `geom_text()`,
    `geom_label()`, `geom_text_repel()`, or `geom_label_repel()`. You
    might need to make a new indicator variable so that you only
    highlight a few of the points instead of all of them. \*In this
    exercise I only label the country from Oceania, i.e., Austrilia and
    New Zealand.

<!-- end list -->

``` r
library(ggrepel)
```

    ## Warning: package 'ggrepel' was built under R version 4.0.2

``` r
ggplot(data=gapminder1,mapping=aes(x=gdpPercap,y=lifeExp,color=continent))+
    geom_point()+
    theme_minimal()+
    labs(title='Relationship between GDP per Capita and Life Expectancy in 2007',x='GDP per Capita (log scale)', y='Life Expectancy')+
    scale_x_log10()+
    geom_label_repel(data = gapminder1%>%
                         filter(continent=='Oceania'),aes(label = country),color = "black")
```

![](04-annotation_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

1.  Add \*at least two each\*\* the following annotations somewhere on
    the plot using `annotate()`:
    
      - **Text**
      - **An arrow** (make a curved arrow for bonus fun)
      - **A rectangle**
    
    You can add more if you want, but those three are the minimum. Try
    to incorporate the annotations into the design of the plot rather
    than just placing them wherever.

<!-- end list -->

``` r
ggplot(data=gapminder1,mapping=aes(x=gdpPercap,y=lifeExp,color=continent))+
    geom_point()+
    theme_minimal()+
    labs(title='Relationship between GDP per Capita and Life Expectancy in 2007',x='GDP per Capita(log scale)', y='Life Expectancy')+
    scale_x_log10()+
    annotate(geom = "rect", xmin = 300, xmax = 1000, ymin = 40, ymax = 50, fill = "#2ECC40", alpha = 0.25) +
    annotate(geom = "rect", xmin = 17000, xmax = 55000, ymin = 75, ymax = 85, fill = "#FF851B", alpha = 0.25)+
    annotate(geom = "segment", x = 30000, xend = 30000, y = 73, yend =77, color = "#FF851B", arrow = arrow(angle = 20, length = unit(0.5, "lines"))) +
    annotate(geom = "segment", x = 1200, xend = 800, y = 45, yend =45, color = "#2ECC40", arrow = arrow(angle = 20, length = unit(0.5, "lines")))+
    annotate(geom = "text", x = 1500, y = 45, label = "lowest region", color = "#2ECC40",size=3,hjust=-0.2) +
  annotate(geom = "text", x = 30000, y = 67, label = "highest\nregion", color = "#FF851B",size=3) 
```

![](04-annotation_files/figure-gfm/unnamed-chunk-3-1.png)<!-- --> Good
luck and have fun\!

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
