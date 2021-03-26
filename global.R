library(tidyverse)
library(shiny)
library(lubridate)
<<<<<<< HEAD
library(AOI) 
library(readr)

# Initial code ----------------------------------------------------------------- 
# read in data
# all_data <- read_csv("dat/cleandata.csv")
# user_0 <- all_data %>%
#   filter(user == 0)
=======
library(gsheet)

# Initial code ----------------------------------------------------------------- 
raw_apex_df <- gsheet2tbl("https://docs.google.com/spreadsheets/d/1v40AgpaoRrA3v5eEjztB5Rw_OGKRHw3L56hhJdzdqAs/edit#gid=13184181") 

# initial cleaning: get rid of rows with all NAs, clean up survival time, etc. 
apex_df <- filter(raw_apex_df, rowSums(is.na(raw_apex_df)) != ncol(raw_apex_df)) %>% 
  mutate(Timestamp_raw = parse_date_time(Timestamp, orders = "mdy HMS", tz = "EST"),
         Timestamp = as.character(Timestamp_raw),
         survival_time_dt = strptime(`Survival Time`, format = "%M:%S"),
         `Survival Time (min)` = round(minute(survival_time_dt) + second(survival_time_dt) / 60, digits = 2)) %>% 
  select(-c(X9, X10, survival_time_dt, `Survival Time`)) 

# leaderboard df
leaderboard_df <- rbind(top_n(apex_df, 1, Damage) %>% 
                          mutate(Statistic = "Most Damage"),
                        top_n(apex_df, 1, Kills) %>% 
                          mutate(Statistic = "Most Kills"),
                        top_n(apex_df, 1, Assists) %>% 
                          mutate(Statistic = "Most Assists"),
                        top_n(apex_df, 1, Knocks) %>% 
                          mutate(Statistic = "Most Knocks")) %>% 
  select(-c(Timestamp_raw))

data(apex_df)
data(leaderboard_df)
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
