library(tidyverse)
library(scales)   # For nice labels in charts

births_1994_1999 <- read_csv("data/US_births_1994-2003_CDC_NCHS.csv") %>% 
  # Ignore anything after 2000
  filter(year < 2000)
births_2000_2014 <- read_csv("data/US_births_2000-2014_SSA.csv")
births_combined <- bind_rows(births_1994_1999, births_2000_2014)

# The c() function lets us make a list of values
month_names <- c("January", "February", "March", "April", "May", "June", "July",
                 "August", "September", "October", "November", "December")

day_names <- c("Monday", "Tuesday", "Wednesday", 
               "Thursday", "Friday", "Saturday", "Sunday")

births <- births_combined %>% 
  # Make month an ordered factor, using the month_name list as labels
  mutate(month = factor(month, labels = month_names, ordered = TRUE)) %>% 
  mutate(day_of_week = factor(day_of_week, labels = day_names, ordered = TRUE),
         date_of_month_categorical = factor(date_of_month)) %>% 
  # Add a column indicating if the day is on a weekend
  mutate(weekend = ifelse(day_of_week %in% c("Saturday", "Sunday"), TRUE, FALSE))

head(births)