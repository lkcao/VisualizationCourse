Design a `theme()`
================
Likun Cao
2020-07-29

## Generate plot

``` r
library(tidyverse)
library(gapminder)
library(scales)
```

``` r
gap_plot <- gapminder %>%
  # mutate(pop = pop / 1000000) %>%
  ggplot(aes(gdpPercap, lifeExp)) +
  geom_point(alpha = .2) +
  geom_smooth(mapping = aes(color = continent), se = FALSE) +
  scale_x_log10(labels = dollar) +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "Life expectancy strongly correlates to national wealth",
       x = "GDP per capita",
       y = "Average life expectancy",
       color = NULL,
       caption = "Source: Gapminder Project")
gap_plot
```

![](02-design-a-theme_files/figure-gfm/gapminder-plot-1.png)<!-- -->

## Develop a custom `theme()`

Generate a customized theme and apply it to the plot above. Go beyond
simply using another default theme such as `theme_minimal()` to
customize the visual appearance of the non-data elements. Things to
consider modifying include:

  - Fonts
  - Text size/styles
  - Grid lines
  - Margins

You can use an existing `theme_*()` as a starting point, but be sure to
go beyond that.

``` r
# your theme here
windowsFonts(`Roboto Condensed` = windowsFont("Roboto Condensed"))
theme_custom <- theme_bw(base_size=10)+theme(
  panel.grid.minor = element_blank(),
  plot.title = element_text(face='bold',size = rel(1.5),color='brown',family="serif"),
  plot.caption = element_text(
  face = "italic", size = rel(0.8),
  color = "brown", hjust = 1,family='serif'
  ),
  legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='serif'),
  axis.title = element_text(face = "plain",color='grey30',family='serif',size=rel(0.9)),
  axis.title.x = element_text(margin = margin(t = 12),vjust=-0.2,hjust=0.5),
  axis.title.y = element_text(margin = margin(r = 12), hjust = 0.5),
  axis.line = element_line(colour = "grey60"),
  panel.border = element_blank(),
  axis.text.x = element_text(size = rel(0.9), family = "serif", color = "grey30", face = "plain"),
  axis.text.y = element_text(size = rel(0.9), family = "serif", color = "grey30", face = "plain")
  )

gap_plot +
  theme_custom
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![](02-design-a-theme_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

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
    ##  package      * version date       lib source        
    ##  assertthat     0.2.1   2019-03-21 [1] CRAN (R 4.0.0)
    ##  backports      1.1.7   2020-05-13 [1] CRAN (R 4.0.0)
    ##  blob           1.2.1   2020-01-20 [1] CRAN (R 4.0.2)
    ##  broom          0.5.6   2020-04-20 [1] CRAN (R 4.0.2)
    ##  callr          3.4.3   2020-03-28 [1] CRAN (R 4.0.2)
    ##  cellranger     1.1.0   2016-07-27 [1] CRAN (R 4.0.0)
    ##  cli            2.0.2   2020-02-28 [1] CRAN (R 4.0.0)
    ##  colorspace     1.4-1   2019-03-18 [1] CRAN (R 4.0.2)
    ##  crayon         1.3.4   2017-09-16 [1] CRAN (R 4.0.0)
    ##  DBI            1.1.0   2019-12-15 [1] CRAN (R 4.0.2)
    ##  dbplyr         1.4.4   2020-05-27 [1] CRAN (R 4.0.2)
    ##  desc           1.2.0   2018-05-01 [1] CRAN (R 4.0.2)
    ##  devtools       2.3.1   2020-07-21 [1] CRAN (R 4.0.2)
    ##  digest         0.6.25  2020-02-23 [1] CRAN (R 4.0.0)
    ##  dplyr        * 1.0.0   2020-05-29 [1] CRAN (R 4.0.0)
    ##  ellipsis       0.3.1   2020-05-15 [1] CRAN (R 4.0.0)
    ##  evaluate       0.14    2019-05-28 [1] CRAN (R 4.0.2)
    ##  fansi          0.4.1   2020-01-08 [1] CRAN (R 4.0.0)
    ##  farver         2.0.3   2020-01-16 [1] CRAN (R 4.0.2)
    ##  forcats      * 0.5.0   2020-03-01 [1] CRAN (R 4.0.2)
    ##  fs             1.4.1   2020-04-04 [1] CRAN (R 4.0.2)
    ##  gapminder    * 0.3.0   2017-10-31 [1] CRAN (R 4.0.2)
    ##  generics       0.0.2   2018-11-29 [1] CRAN (R 4.0.0)
    ##  ggplot2      * 3.3.2   2020-06-19 [1] CRAN (R 4.0.2)
    ##  glue           1.4.1   2020-05-13 [1] CRAN (R 4.0.0)
    ##  gtable         0.3.0   2019-03-25 [1] CRAN (R 4.0.2)
    ##  haven          2.3.1   2020-06-01 [1] CRAN (R 4.0.2)
    ##  hms            0.5.3   2020-01-08 [1] CRAN (R 4.0.0)
    ##  htmltools      0.5.0   2020-06-16 [1] CRAN (R 4.0.2)
    ##  httr           1.4.1   2019-08-05 [1] CRAN (R 4.0.0)
    ##  jsonlite       1.7.0   2020-06-25 [1] CRAN (R 4.0.2)
    ##  knitr          1.29    2020-06-23 [1] CRAN (R 4.0.2)
    ##  labeling       0.3     2014-08-23 [1] CRAN (R 4.0.0)
    ##  lattice        0.20-41 2020-04-02 [2] CRAN (R 4.0.1)
    ##  lifecycle      0.2.0   2020-03-06 [1] CRAN (R 4.0.0)
    ##  lubridate      1.7.9   2020-06-08 [1] CRAN (R 4.0.2)
    ##  magrittr       1.5     2014-11-22 [1] CRAN (R 4.0.0)
    ##  Matrix         1.2-18  2019-11-27 [2] CRAN (R 4.0.1)
    ##  memoise        1.1.0   2017-04-21 [1] CRAN (R 4.0.2)
    ##  mgcv           1.8-31  2019-11-09 [2] CRAN (R 4.0.1)
    ##  modelr         0.1.8   2020-05-19 [1] CRAN (R 4.0.2)
    ##  munsell        0.5.0   2018-06-12 [1] CRAN (R 4.0.2)
    ##  nlme           3.1-148 2020-05-24 [2] CRAN (R 4.0.1)
    ##  pillar         1.4.4   2020-05-05 [1] CRAN (R 4.0.0)
    ##  pkgbuild       1.0.8   2020-05-07 [1] CRAN (R 4.0.2)
    ##  pkgconfig      2.0.3   2019-09-22 [1] CRAN (R 4.0.0)
    ##  pkgload        1.1.0   2020-05-29 [1] CRAN (R 4.0.2)
    ##  prettyunits    1.1.1   2020-01-24 [1] CRAN (R 4.0.0)
    ##  processx       3.4.2   2020-02-09 [1] CRAN (R 4.0.2)
    ##  ps             1.3.3   2020-05-08 [1] CRAN (R 4.0.2)
    ##  purrr        * 0.3.4   2020-04-17 [1] CRAN (R 4.0.0)
    ##  R6             2.4.1   2019-11-12 [1] CRAN (R 4.0.0)
    ##  RColorBrewer   1.1-2   2014-12-07 [1] CRAN (R 4.0.0)
    ##  Rcpp           1.0.4.6 2020-04-09 [1] CRAN (R 4.0.0)
    ##  readr        * 1.3.1   2018-12-21 [1] CRAN (R 4.0.2)
    ##  readxl         1.3.1   2019-03-13 [1] CRAN (R 4.0.0)
    ##  remotes        2.2.0   2020-07-21 [1] CRAN (R 4.0.2)
    ##  reprex         0.3.0   2019-05-16 [1] CRAN (R 4.0.2)
    ##  rlang          0.4.7   2020-07-09 [1] CRAN (R 4.0.2)
    ##  rmarkdown      2.3     2020-06-18 [1] CRAN (R 4.0.2)
    ##  rprojroot      1.3-2   2018-01-03 [1] CRAN (R 4.0.2)
    ##  rstudioapi     0.11    2020-02-07 [1] CRAN (R 4.0.2)
    ##  rvest          0.3.5   2019-11-08 [1] CRAN (R 4.0.0)
    ##  scales       * 1.1.1   2020-05-11 [1] CRAN (R 4.0.2)
    ##  sessioninfo    1.1.1   2018-11-05 [1] CRAN (R 4.0.2)
    ##  stringi        1.4.6   2020-02-17 [1] CRAN (R 4.0.0)
    ##  stringr      * 1.4.0   2019-02-10 [1] CRAN (R 4.0.2)
    ##  testthat       2.3.2   2020-03-02 [1] CRAN (R 4.0.2)
    ##  tibble       * 3.0.1   2020-04-20 [1] CRAN (R 4.0.0)
    ##  tidyr        * 1.1.0   2020-05-20 [1] CRAN (R 4.0.2)
    ##  tidyselect     1.1.0   2020-05-11 [1] CRAN (R 4.0.0)
    ##  tidyverse    * 1.3.0   2019-11-21 [1] CRAN (R 4.0.2)
    ##  usethis        1.6.1   2020-04-29 [1] CRAN (R 4.0.2)
    ##  vctrs          0.3.1   2020-06-05 [1] CRAN (R 4.0.0)
    ##  withr          2.2.0   2020-04-20 [1] CRAN (R 4.0.2)
    ##  xfun           0.15    2020-06-21 [1] CRAN (R 4.0.2)
    ##  xml2           1.3.2   2020-04-23 [1] CRAN (R 4.0.2)
    ##  yaml           2.2.1   2020-02-01 [1] CRAN (R 4.0.0)
    ## 
    ## [1] C:/Users/Kun/Documents/R/win-library/4.0
    ## [2] C:/Program Files/R/R-4.0.1/library
