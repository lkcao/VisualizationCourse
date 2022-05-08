library(tidyverse)

# get data on troop movements and city names
troops <- read_table("data/minard-troops.txt")
cities <- read_table("data/minard-cities.txt")
troops
cities


#troop layer
ggplot(data=troops,mapping=aes(x=long,y=lat))+
  geom_path(mapping=aes(
    size=survivors,
    color=direction,
    group=group))+
geom_text(data=cities,mapping=aes(label=city))+
scale_size(range=c(1,12),labels=scales::comma)+
scale_color_manual(values=c('tan','grey50'),labels=c('Advance','Retreat'))+
coord_map()+
theme_void()


  

