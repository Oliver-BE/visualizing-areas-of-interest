library(tidyverse)
library(shiny)
library(shinyjs)
library(lubridate)
library(AOI) 
library(readr)
source("./dbconfig.R")

# Initial code ----------------------------------------------------------------- 
# read in data
# all_data <- read_csv("dat/cleandata.csv")

# user_0_raw <- all_data %>% 
#   filter(user == 0,
#          time < ymd_hms("2008-10-24 00:00:00", tz = "UTC"))

# user_0 <- all_data %>%
#   # add 8 hours to convert to Chinese local time
#   mutate(time = time + 8*60*60) %>% 
#   filter(user == 0 | user == 1,
#          # only take the first day for now
#          time < ymd_hms("2008-10-24 00:00:00"))
#          # time < "2008-10-24 00:00:00")
#          # time < ymd_hms("2008-10-24 00:00:00", tz = "Asia/Brunei")) 


#user_0_minute <- user_0[seq(1, nrow(user_0), 12), ]
# write.csv(user_0_minute, "dat/test_data.csv")

user_0 <- read_csv("dat/test_data.csv") %>% 
  select(-c(X1))

data(user_0)
