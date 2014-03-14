library(dplyr)
library(ggplot2)

raw <- read.csv("raw//IHME_USA_GBD_2010_RESULTS_1990_2010_BY_CAUSE_Y2013M08D29.CSV",
  stringsAsFactors = FALSE)

gbd <- raw %.% 
  tbl_df() %.%
  select(-country_name, -region)

# Select single non-overlapping set of ages
dput(unique(gbd$age))
ages <- c("0-6 days", "7-27 days", "28-364 days", "1-4 years", "5-9 years", 
  "10-14 years", "15-19 years", "20-24 years", "25-29 years", 
  "30-34 years", "35-39 years", "40-44 years", "45-49 years", "50-54 years", 
  "55-59 years", "60-64 years", "65-69 years", "70-74 years",  "75-79 years",   
  "80+ years")
gbd <- gbd %.% filter(age_name %in% ages) %.%
  mutate(age = ordered(age_name, levels = ages)) %.%
  select(-age_name)

# Let's just focus on deaths in 2010
table(gbd$cause_medium, gbd$measure)

deaths <- gbd %.% 
  filter(year == 2010) %.% select(-year) %.%
  filter(measure == "death") %.% select(-measure) %.%
  filter(sex != "Both sexes") %.%
  filter(cause_name != "Total (All Causes)") %.%
  select(cause = cause_name, sex, age, n = nm_mean, rt_upper, rt_lower, 
    rt = rt_mean)

saveRDS(deaths, "deaths.rds")
