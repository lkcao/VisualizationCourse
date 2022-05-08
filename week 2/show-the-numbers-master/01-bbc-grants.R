# Load libraries
library(tidyverse)  # For ggplot, dplyr, and friends
library(readxl)     # For reading Excel files
library(lubridate)  # For working with dates

# Load the original Excel file
bbc_raw <- read_excel("data/360-giving-data.xlsx")

bbc <- bbc_raw %>% 
  # Extract the year from the award date
  mutate(grant_year = year(`Award Date`)) %>% 
  # Rename some columns
  rename(grant_amount = `Amount Awarded`,
         grant_program = `Grant Programme:Title`,
         grant_duration = `Planned Dates:Duration (months)`) %>% 
  # Make a new text-based version of the duration column, recoding months
  # between 12-23, 23-35, and 36+. The case_when() function here lets us use
  # multiple if/else conditions at the same time.
  mutate(grant_duration_text = case_when(
    grant_duration >= 12 & grant_duration < 24 ~ "1 year",
    grant_duration >= 24 & grant_duration < 36 ~ "2 years",
    grant_duration >= 36 ~ "3 years"
  )) %>% 
  # Get rid of anything before 2016
  filter(grant_year > 2015) %>% 
  # Make a categorical version of the year column
  mutate(grant_year_category = factor(grant_year))

#VIS for grant-amount
ggplot(data=bbc,mapping=aes(x=grant_amount,fill=grant_year_category))+
  geom_histogram(binwidth=10000,color='white')


