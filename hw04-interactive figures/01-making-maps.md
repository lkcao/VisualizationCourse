Making maps
================
Likun Cao
2020-07-30

## Session information

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 4.0.2

    ## -- Attaching packages --------------- tidyverse 1.3.0 --

    ## √ ggplot2 3.3.2     √ purrr   0.3.4
    ## √ tibble  3.0.1     √ dplyr   1.0.0
    ## √ tidyr   1.1.0     √ stringr 1.4.0
    ## √ readr   1.3.1     √ forcats 0.5.0

    ## Warning: package 'ggplot2' was built under R version 4.0.2

    ## Warning: package 'tidyr' was built under R version 4.0.2

    ## Warning: package 'readr' was built under R version 4.0.2

    ## Warning: package 'stringr' was built under R version 4.0.2

    ## Warning: package 'forcats' was built under R version 4.0.2

    ## -- Conflicts ------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(sf)
```

    ## Warning: package 'sf' was built under R version 4.0.2

    ## Linking to GEOS 3.8.0, GDAL 3.0.4, PROJ 6.3.1

``` r
library(ggmap)
```

    ## Warning: package 'ggmap' was built under R version 4.0.2

    ## Google's Terms of Service: https://cloud.google.com/maps-platform/terms/.

    ## Please cite ggmap if you use it! See citation("ggmap") for details.

``` r
library(rnaturalearth)
```

    ## Warning: package 'rnaturalearth' was built under R version 4.0.2

``` r
library(RColorBrewer)
library(patchwork)
```

    ## Warning: package 'patchwork' was built under R version 4.0.2

``` r
library(tidycensus)
```

    ## Warning: package 'tidycensus' was built under R version 4.0.2

``` r
library(viridis)
```

    ## Warning: package 'viridis' was built under R version 4.0.2

    ## Loading required package: viridisLite

    ## Warning: package 'viridisLite' was built under R version 4.0.2

``` r
library(here)
```

    ## Warning: package 'here' was built under R version 4.0.2

    ## here() starts at C:/Users/Kun/Documents/GitHub/hw04-clk16

``` r
library(viridis)
readRenviron("~/.Renviron")
```

\#First Map

``` r
chi_shape <- st_read("geo_export_428b9c33-80df-460c-ba29-f680dc167a24.shp")
```

    ## Reading layer `geo_export_428b9c33-80df-460c-ba29-f680dc167a24' from data source `C:\Users\Kun\Documents\GitHub\hw04-clk16\geo_export_428b9c33-80df-460c-ba29-f680dc167a24.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 61 features and 4 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -87.94011 ymin: 41.64454 xmax: -87.52414 ymax: 42.02304
    ## geographic CRS: WGS84(DD)

``` r
median_age <- get_acs(geography = "zcta", variables = c(median_age = "B01002_001E"),year = 2018)
```

    ## Getting data from the 2014-2018 5-year ACS

``` r
(chi_age <- chi_shape%>%
  left_join(median_age, by = c("zip" = "GEOID")))
```

    ## Simple feature collection with 61 features and 8 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -87.94011 ymin: 41.64454 xmax: -87.52414 ymax: 42.02304
    ## geographic CRS: WGS84(DD)
    ## First 10 features:
    ##    objectid shape_area shape_len   zip        NAME   variable estimate moe
    ## 1        33  106052287  42720.04 60647 ZCTA5 60647 B01002_001     31.8 0.4
    ## 2        34  127476051  48103.78 60639 ZCTA5 60639 B01002_001     33.1 0.9
    ## 3        35   45069038  27288.61 60707 ZCTA5 60707 B01002_001     39.6 1.3
    ## 4        36   70853834  42527.99 60622 ZCTA5 60622 B01002_001     31.7 0.4
    ## 5        37   99039621  47970.14 60651 ZCTA5 60651 B01002_001     33.0 1.1
    ## 6        38   23506056  34689.35 60611 ZCTA5 60611 B01002_001     38.9 2.7
    ## 7        39  166166339  67710.65 60638 ZCTA5 60638 B01002_001     37.7 1.0
    ## 8        40  128309832  48187.95 60652 ZCTA5 60652 B01002_001     35.7 1.2
    ## 9         1   49170579  33983.91 60626 ZCTA5 60626 B01002_001     34.0 1.1
    ## 10        8   66565455  38321.31 60615 ZCTA5 60615 B01002_001     33.8 1.0
    ##                          geometry
    ## 1  MULTIPOLYGON (((-87.67762 4...
    ## 2  MULTIPOLYGON (((-87.72683 4...
    ## 3  MULTIPOLYGON (((-87.785 41....
    ## 4  MULTIPOLYGON (((-87.66707 4...
    ## 5  MULTIPOLYGON (((-87.70656 4...
    ## 6  MULTIPOLYGON (((-87.61401 4...
    ## 7  MULTIPOLYGON (((-87.74347 4...
    ## 8  MULTIPOLYGON (((-87.68305 4...
    ## 9  MULTIPOLYGON (((-87.66421 4...
    ## 10 MULTIPOLYGON (((-87.58103 4...

``` r
ggplot(data = chi_age) + 
  geom_sf(aes(fill = estimate))+
  labs(title = "Median Age by Zip Code Areas in Chicago (2018)", subtitle = "Palette: viridis (inferno). Cutting-points: equal steps.",
caption = "Source: 2018 American Community Survey",fill = NULL) +
   scale_fill_viridis(option='inferno',direction=-1,alpha=0.7,guide = guide_colorsteps())+
    theme_minimal(base_size=10)+
  theme(panel.grid.minor = element_blank(),
                plot.title = element_text(face='bold',size = rel(1.5),color='grey20',family="serif"), plot.caption = element_text(face = "italic", size = rel(0.8), color = "grey30", family='serif',hjust=0.5),
  legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='serif'),plot.subtitle = element_text(face='bold',size = rel(1),color='grey30',family="serif"))
```

![](01-making-maps_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

\#second map

``` r
us_shape <- st_read("cb_2018_us_state_500k.shp")%>%
  filter(!(NAME %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))
```

    ## Reading layer `cb_2018_us_state_500k' from data source `C:\Users\Kun\Documents\GitHub\hw04-clk16\cb_2018_us_state_500k.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 56 features and 9 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -179.1489 ymin: -14.5487 xmax: 179.7785 ymax: 71.36516
    ## geographic CRS: NAD83

``` r
health<-read.csv("us-sdoh-2014-v.csv")%>%
  filter(!(state %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))%>%
  group_by(state)%>%
  summarize(under_17_proportion=mean(ep_age17))
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

``` r
(us_age <- us_shape%>%
  left_join(health, by = c("NAME" = "state")))
```

    ## Simple feature collection with 52 features and 10 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -171.0899 ymin: -14.5487 xmax: 146.0648 ymax: 49.38436
    ## geographic CRS: NAD83
    ## First 10 features:
    ##    STATEFP  STATENS    AFFGEOID GEOID STUSPS           NAME LSAD        ALAND
    ## 1       28 01779790 0400000US28    28     MS    Mississippi   00 121533519481
    ## 2       37 01027616 0400000US37    37     NC North Carolina   00 125923656064
    ## 3       40 01102857 0400000US40    40     OK       Oklahoma   00 177662925723
    ## 4       51 01779803 0400000US51    51     VA       Virginia   00 102257717110
    ## 5       54 01779805 0400000US54    54     WV  West Virginia   00  62266474513
    ## 6       22 01629543 0400000US22    22     LA      Louisiana   00 111897594374
    ## 7       26 01779789 0400000US26    26     MI       Michigan   00 146600952990
    ## 8       25 00606926 0400000US25    25     MA  Massachusetts   00  20205125364
    ## 9       16 01779783 0400000US16    16     ID          Idaho   00 214049787659
    ## 10      12 00294478 0400000US12    12     FL        Florida   00 138949136250
    ##          AWATER under_17_proportion                       geometry
    ## 1    3926919758            24.56599 MULTIPOLYGON (((-88.50297 3...
    ## 2   13466071395            22.85634 MULTIPOLYGON (((-75.72681 3...
    ## 3    3374587997            24.15880 MULTIPOLYGON (((-103.0026 3...
    ## 4    8528531774            22.12606 MULTIPOLYGON (((-75.74241 3...
    ## 5     489028543            20.52545 MULTIPOLYGON (((-82.6432 38...
    ## 6   23753621895            23.33665 MULTIPOLYGON (((-88.8677 29...
    ## 7  103885855702            22.56316 MULTIPOLYGON (((-83.19159 4...
    ## 8    7129925486            20.66196 MULTIPOLYGON (((-70.23405 4...
    ## 9    2391722557            25.47930 MULTIPOLYGON (((-117.2427 4...
    ## 10  31361101223            19.82685 MULTIPOLYGON (((-80.17628 2...

``` r
ggplot(data = us_age) +
  geom_sf(aes(fill=under_17_proportion))+
   coord_sf(crs = "+proj=longlat +datum=WGS84 +no_defs",xlim=c(-125,-60),ylim=c(25,55)) +
  labs(title='Proportion of People Under Age 17 across States',subtitle='Source:Geoda Data and Lab')+
  scale_fill_viridis(option='cividis',direction=1,alpha=0.7,guide = guide_colorbar())+
    theme_minimal(base_size=10)+
  theme(panel.grid.minor = element_blank(),
                plot.title = element_text(face='bold',size = rel(1.3),color='grey20',family="serif"), plot.caption = element_text(face = "italic", size = rel(0.8), color = "grey20", family='serif',hjust=0.5),
  legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='serif'),plot.subtitle = element_text(face='italic',size = rel(1),color='grey20',family="serif"), legend.title = element_text(colour="grey20", size = rel(0.9), face = "italic",family='serif'))
```

![](01-making-maps_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
\#third map

``` r
china_box<- c(left = 62.6367,
            bottom = 11.6771,
            right = 140.8008,
            top = 55.0492)
china_map <- get_stamenmap(bbox = china_box,
  zoom =4,'terrain')
```

    ## Source : http://tile.stamen.com/terrain/4/10/5.png

    ## Source : http://tile.stamen.com/terrain/4/11/5.png

    ## Source : http://tile.stamen.com/terrain/4/12/5.png

    ## Source : http://tile.stamen.com/terrain/4/13/5.png

    ## Source : http://tile.stamen.com/terrain/4/14/5.png

    ## Source : http://tile.stamen.com/terrain/4/10/6.png

    ## Source : http://tile.stamen.com/terrain/4/11/6.png

    ## Source : http://tile.stamen.com/terrain/4/12/6.png

    ## Source : http://tile.stamen.com/terrain/4/13/6.png

    ## Source : http://tile.stamen.com/terrain/4/14/6.png

    ## Source : http://tile.stamen.com/terrain/4/10/7.png

    ## Source : http://tile.stamen.com/terrain/4/11/7.png

    ## Source : http://tile.stamen.com/terrain/4/12/7.png

    ## Source : http://tile.stamen.com/terrain/4/13/7.png

    ## Source : http://tile.stamen.com/terrain/4/14/7.png

``` r
travel<-read.csv('travelling.csv',sep='\t')%>%
  filter(level=='5A')

ggmap(china_map)+
  stat_density_2d(data = travel,
             mapping = aes(x = longitude,
                           y =  latitude,fill = stat(level)), alpha=0.3,bins=25, geom = "polygon")+
  scale_fill_gradientn(colors = brewer.pal(7, "YlOrRd"))+
    scale_size_area(guide = FALSE)+
    theme_minimal()+
  labs(title='Heatmap for 5A Tourist Spots in China', x='longitude', y='latitude',subtitle='Data Source: Crawlling')+
   theme(plot.title = element_text(face='bold',size = rel(1.3),color='grey10',family="mono"), plot.caption = element_text(face = "italic", size = rel(0.8), color = "grey10", family='mono',hjust=0.5),
  legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='mono'),plot.subtitle = element_text(face='italic',size = rel(1),color='grey10',family="mono"), legend.title = element_text(colour="grey10", size = rel(0.9), face = "italic",family='mono'))
```

![](01-making-maps_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

\#fourth map

``` r
us_shape <- st_read("cb_2018_us_state_500k.shp")%>%
  filter(!(NAME %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))
```

    ## Reading layer `cb_2018_us_state_500k' from data source `C:\Users\Kun\Documents\GitHub\hw04-clk16\cb_2018_us_state_500k.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 56 features and 9 fields
    ## geometry type:  MULTIPOLYGON
    ## dimension:      XY
    ## bbox:           xmin: -179.1489 ymin: -14.5487 xmax: 179.7785 ymax: 71.36516
    ## geographic CRS: NAD83

``` r
university<-read.csv("university.csv")%>%
  filter(!(state %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))

ggplot(data = us_shape) + 
  geom_sf() + 
  geom_point(data = university, aes(x = lon, y = lat,color=highest_degree_offered,shape=highest_degree_offered,size=enrollment),alpha=0.7) +
  scale_colour_brewer(palette = "Set1")+
  coord_sf(xlim = c(-130, -60),
           ylim = c(20, 50))+
  theme_minimal()+
  labs(title='U.S. University Distribution (2013)',x='',y='',subtitle='Source: Kaggler Open Source Data')+
  theme_minimal(base_size=10)+
  theme(legend.position="bottom",panel.grid.minor = element_blank(), plot.title = element_text(face='bold',size = rel(1.3),color='grey20',family="serif"), plot.caption = element_text(face = "italic", size = rel(0.8), color = "grey20", family='serif',hjust=0.5),
  legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='serif'),plot.subtitle = element_text(face='italic',size = rel(1),color='grey20',family="serif"), legend.title = element_text(colour="grey20", size = rel(0.9), face = "italic",family='serif'))
```

    ## Warning: Removed 2 rows containing missing values (geom_point).

![](01-making-maps_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Description:

The first map is about median age in Chicago Zip Code Areas. For this
map I allow R to choose cut-off points itself, and you can see from the
map that R choose an equal interval breaking (interval=4) which I think
makes sense as it presents the difference between different zip code
areas relatively clear. For the color, I choose viridis (inferno) and
reverse the sequence of color because I hope to show “younger” areas
with lighter colors and “older” areas with darker color. We can see from
the map that, overall, western and loop areas are younger, while north
side and south side are older.

The second map is about the average proportion of population under the
age 17 across U.S. For each state, I calculate its value as the mean of
all its counties—technically this is a wrong calculation because I
didn’t take population of each county into consideration, but I didn’t
find population variable in the datasets, so it might still serve as a
proxy for what we want to measure. We can see from the map that,
generally, northeast has few children while middle U.S. has more
children. The cut-off points are chosen by R as well (equal intervals).
Darker color is used to show less children.

The third map is a visualization of Chinese 5A tourist spots (:-)welcome
to China\!). Since tourist spots are often related to natural sceneries,
I use the ‘terrain’ stamen map as the base map. On this map, I draw a
heatmap of Chinese 5A tourist spots, which is the highest level of
Chinese tourist spots. You can see that most such spots are distributed
in the southern China, and there is also a weaker center around Beijing
(Hebei province). Although there are also some in the north, its few
relative to south. If someone wants to have fun in China, she should
spend most of her time in the south.

The fourth map is about the distribution of U.S. university. I use it to
generate a spatial scatter plot. On this map, you can see I use both dot
shape and dot color to show the highest degree the university provides
(bachelor/master/doctor), and the size of the dot is used to show the
total enrollment of students in 2013. Although it seems a little
redundant to use both color and shape to show the degree variable (and
Tufte will hate me for that), I think it will make the picture more
aesthetically pleasing and more intuitive for the reader. You can see
from the picture that many universities in U.S. cluster in the
northeastern areas, and many of them are also on the western coast.
Midwest has relatively few.

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
    ##  date     2020-07-30                    
    ## 
    ## - Packages -------------------------------------------------------------------
    ##  package       * version  date       lib source        
    ##  assertthat      0.2.1    2019-03-21 [1] CRAN (R 4.0.0)
    ##  backports       1.1.7    2020-05-13 [1] CRAN (R 4.0.0)
    ##  bitops          1.0-6    2013-08-17 [1] CRAN (R 4.0.0)
    ##  blob            1.2.1    2020-01-20 [1] CRAN (R 4.0.2)
    ##  broom           0.5.6    2020-04-20 [1] CRAN (R 4.0.2)
    ##  callr           3.4.3    2020-03-28 [1] CRAN (R 4.0.2)
    ##  cellranger      1.1.0    2016-07-27 [1] CRAN (R 4.0.0)
    ##  class           7.3-17   2020-04-26 [2] CRAN (R 4.0.1)
    ##  classInt        0.4-3    2020-04-07 [1] CRAN (R 4.0.2)
    ##  cli             2.0.2    2020-02-28 [1] CRAN (R 4.0.0)
    ##  colorspace      1.4-1    2019-03-18 [1] CRAN (R 4.0.2)
    ##  crayon          1.3.4    2017-09-16 [1] CRAN (R 4.0.0)
    ##  curl            4.3      2019-12-02 [1] CRAN (R 4.0.2)
    ##  DBI             1.1.0    2019-12-15 [1] CRAN (R 4.0.2)
    ##  dbplyr          1.4.4    2020-05-27 [1] CRAN (R 4.0.2)
    ##  desc            1.2.0    2018-05-01 [1] CRAN (R 4.0.2)
    ##  devtools        2.3.1    2020-07-21 [1] CRAN (R 4.0.2)
    ##  digest          0.6.25   2020-02-23 [1] CRAN (R 4.0.0)
    ##  dplyr         * 1.0.0    2020-05-29 [1] CRAN (R 4.0.0)
    ##  e1071           1.7-3    2019-11-26 [1] CRAN (R 4.0.2)
    ##  ellipsis        0.3.1    2020-05-15 [1] CRAN (R 4.0.0)
    ##  evaluate        0.14     2019-05-28 [1] CRAN (R 4.0.2)
    ##  fansi           0.4.1    2020-01-08 [1] CRAN (R 4.0.0)
    ##  farver          2.0.3    2020-01-16 [1] CRAN (R 4.0.2)
    ##  forcats       * 0.5.0    2020-03-01 [1] CRAN (R 4.0.2)
    ##  foreign         0.8-80   2020-05-24 [2] CRAN (R 4.0.1)
    ##  fs              1.4.1    2020-04-04 [1] CRAN (R 4.0.2)
    ##  generics        0.0.2    2018-11-29 [1] CRAN (R 4.0.0)
    ##  ggmap         * 3.0.0    2019-02-04 [1] CRAN (R 4.0.2)
    ##  ggplot2       * 3.3.2    2020-06-19 [1] CRAN (R 4.0.2)
    ##  glue            1.4.1    2020-05-13 [1] CRAN (R 4.0.0)
    ##  gridExtra       2.3      2017-09-09 [1] CRAN (R 4.0.2)
    ##  gtable          0.3.0    2019-03-25 [1] CRAN (R 4.0.2)
    ##  haven           2.3.1    2020-06-01 [1] CRAN (R 4.0.2)
    ##  here          * 0.1      2017-05-28 [1] CRAN (R 4.0.2)
    ##  hms             0.5.3    2020-01-08 [1] CRAN (R 4.0.0)
    ##  htmltools       0.5.0    2020-06-16 [1] CRAN (R 4.0.2)
    ##  httr            1.4.1    2019-08-05 [1] CRAN (R 4.0.0)
    ##  isoband         0.2.2    2020-06-20 [1] CRAN (R 4.0.2)
    ##  jpeg            0.1-8.1  2019-10-24 [1] CRAN (R 4.0.0)
    ##  jsonlite        1.7.0    2020-06-25 [1] CRAN (R 4.0.2)
    ##  KernSmooth      2.23-17  2020-04-26 [2] CRAN (R 4.0.1)
    ##  knitr           1.29     2020-06-23 [1] CRAN (R 4.0.2)
    ##  labeling        0.3      2014-08-23 [1] CRAN (R 4.0.0)
    ##  lattice         0.20-41  2020-04-02 [2] CRAN (R 4.0.1)
    ##  lifecycle       0.2.0    2020-03-06 [1] CRAN (R 4.0.0)
    ##  lubridate       1.7.9    2020-06-08 [1] CRAN (R 4.0.2)
    ##  magrittr        1.5      2014-11-22 [1] CRAN (R 4.0.0)
    ##  maptools        1.0-1    2020-05-14 [1] CRAN (R 4.0.2)
    ##  MASS            7.3-51.6 2020-04-26 [2] CRAN (R 4.0.1)
    ##  memoise         1.1.0    2017-04-21 [1] CRAN (R 4.0.2)
    ##  modelr          0.1.8    2020-05-19 [1] CRAN (R 4.0.2)
    ##  munsell         0.5.0    2018-06-12 [1] CRAN (R 4.0.2)
    ##  nlme            3.1-148  2020-05-24 [2] CRAN (R 4.0.1)
    ##  patchwork     * 1.0.1    2020-06-22 [1] CRAN (R 4.0.2)
    ##  pillar          1.4.4    2020-05-05 [1] CRAN (R 4.0.0)
    ##  pkgbuild        1.0.8    2020-05-07 [1] CRAN (R 4.0.2)
    ##  pkgconfig       2.0.3    2019-09-22 [1] CRAN (R 4.0.0)
    ##  pkgload         1.1.0    2020-05-29 [1] CRAN (R 4.0.2)
    ##  plyr            1.8.6    2020-03-03 [1] CRAN (R 4.0.2)
    ##  png             0.1-7    2013-12-03 [1] CRAN (R 4.0.0)
    ##  prettyunits     1.1.1    2020-01-24 [1] CRAN (R 4.0.0)
    ##  processx        3.4.2    2020-02-09 [1] CRAN (R 4.0.2)
    ##  ps              1.3.3    2020-05-08 [1] CRAN (R 4.0.2)
    ##  purrr         * 0.3.4    2020-04-17 [1] CRAN (R 4.0.0)
    ##  R6              2.4.1    2019-11-12 [1] CRAN (R 4.0.0)
    ##  rappdirs        0.3.1    2016-03-28 [1] CRAN (R 4.0.2)
    ##  RColorBrewer  * 1.1-2    2014-12-07 [1] CRAN (R 4.0.0)
    ##  Rcpp            1.0.5    2020-07-06 [1] CRAN (R 4.0.2)
    ##  readr         * 1.3.1    2018-12-21 [1] CRAN (R 4.0.2)
    ##  readxl          1.3.1    2019-03-13 [1] CRAN (R 4.0.0)
    ##  remotes         2.2.0    2020-07-21 [1] CRAN (R 4.0.2)
    ##  reprex          0.3.0    2019-05-16 [1] CRAN (R 4.0.2)
    ##  rgdal           1.5-12   2020-06-26 [1] CRAN (R 4.0.2)
    ##  RgoogleMaps     1.4.5.3  2020-02-12 [1] CRAN (R 4.0.2)
    ##  rjson           0.2.20   2018-06-08 [1] CRAN (R 4.0.0)
    ##  rlang           0.4.7    2020-07-09 [1] CRAN (R 4.0.2)
    ##  rmarkdown       2.3      2020-06-18 [1] CRAN (R 4.0.2)
    ##  rnaturalearth * 0.1.0    2017-03-21 [1] CRAN (R 4.0.2)
    ##  rprojroot       1.3-2    2018-01-03 [1] CRAN (R 4.0.2)
    ##  rstudioapi      0.11     2020-02-07 [1] CRAN (R 4.0.2)
    ##  rvest           0.3.5    2019-11-08 [1] CRAN (R 4.0.0)
    ##  scales          1.1.1    2020-05-11 [1] CRAN (R 4.0.2)
    ##  sessioninfo     1.1.1    2018-11-05 [1] CRAN (R 4.0.2)
    ##  sf            * 0.9-4    2020-06-13 [1] CRAN (R 4.0.2)
    ##  sp              1.4-2    2020-05-20 [1] CRAN (R 4.0.2)
    ##  stringi         1.4.6    2020-02-17 [1] CRAN (R 4.0.0)
    ##  stringr       * 1.4.0    2019-02-10 [1] CRAN (R 4.0.2)
    ##  testthat        2.3.2    2020-03-02 [1] CRAN (R 4.0.2)
    ##  tibble        * 3.0.1    2020-04-20 [1] CRAN (R 4.0.0)
    ##  tidycensus    * 0.9.9.5  2020-06-10 [1] CRAN (R 4.0.2)
    ##  tidyr         * 1.1.0    2020-05-20 [1] CRAN (R 4.0.2)
    ##  tidyselect      1.1.0    2020-05-11 [1] CRAN (R 4.0.0)
    ##  tidyverse     * 1.3.0    2019-11-21 [1] CRAN (R 4.0.2)
    ##  tigris          0.9.4    2020-04-01 [1] CRAN (R 4.0.2)
    ##  units           0.6-7    2020-06-13 [1] CRAN (R 4.0.2)
    ##  usethis         1.6.1    2020-04-29 [1] CRAN (R 4.0.2)
    ##  uuid            0.1-4    2020-02-26 [1] CRAN (R 4.0.0)
    ##  vctrs           0.3.1    2020-06-05 [1] CRAN (R 4.0.0)
    ##  viridis       * 0.5.1    2018-03-29 [1] CRAN (R 4.0.2)
    ##  viridisLite   * 0.3.0    2018-02-01 [1] CRAN (R 4.0.2)
    ##  withr           2.2.0    2020-04-20 [1] CRAN (R 4.0.2)
    ##  xfun            0.15     2020-06-21 [1] CRAN (R 4.0.2)
    ##  xml2            1.3.2    2020-04-23 [1] CRAN (R 4.0.2)
    ##  yaml            2.2.1    2020-02-01 [1] CRAN (R 4.0.0)
    ## 
    ## [1] C:/Users/Kun/Documents/R/win-library/4.0
    ## [2] C:/Program Files/R/R-4.0.1/library
