library(here)
library(tidyverse)
NESdta<-read_csv("D:/2020年summer/visualization/6/anes_2016.txt")

NESdta %>% 
  select(ends_with("3"))

NESdta %>% 
  select(fttrump, pid3, ftobama)%>%
  mutate(fttrump=replace(fttrump,fttrump>100,NA),
         ftobama=replace(ftobama,ftobama>100,NA))%>%
  mutate(party=case_when(pid3==1~'Democrate',
                         pid3==2~'Republican',
                         pid3==3~'Independent',
                         pid3==4~'Independent',
                         pid3==5~'Independent'))%>%
    filter(!is.na(fttrump),
           !is.na(ftobama),
           !is.na(pid3))

for (x in c(4:15)){
  print(c("Waggoner got a hole in",x))}

fahrenheit <- c(60, 65, 70, 75, 80, 85, 90, 95, 100)
celsium<-list()
for (x in fahrenheit){
  celsium=c(celsium,((x-32)*(5/9)))
}

congress <- read_csv("D:/2020年summer/visualization/6/congress.csv")

library(recipes)
library(skimr)
library(tidyverse)
library(here)
library(naniar)
library(tidyverse)
library(here)
congress1<-congress%>%
  select(les,seniority, dwnom1, votepct,all_bills, mrp_mean)

congress1 %>% 
  gg_miss_var()

congress1 %>% 
  gg_miss_upset()

skim(median_impute$votepct) 
skim(mean_impute$dwnom1) 
skim(knn_impute$seniority) 
