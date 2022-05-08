library(tidyverse)  # For ggplot, dplyr, and friends
library(geofacet)   # For map-shaped facets
library(scales)     # For helpful scale functions like dollar()
library(ggrepel)    # For non-overlapping labels

# import data
wdi_raw <- read_csv("data/wdi_raw.csv")

# clean data
wdi_clean <- wdi_raw %>% 
  filter(region != "Aggregates") %>% 
  select(iso2c, country, year, 
         life_expectancy = SP.DYN.LE00.IN, 
         access_to_electricity = EG.ELC.ACCS.ZS, 
         co2_emissions = EN.ATM.CO2E.PC, 
         gdp_per_cap = NY.GDP.PCAP.KD, 
         region, income)

head(wdi_clean)
