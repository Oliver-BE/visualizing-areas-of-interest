library(leaflet)
library(AOI)
library(rgeos)

# addMarkers(lng=~lon, lat=~lat, icon = ,
#            #          popup = paste("<b><u>","User Number ", df$user, "</u></b>", "<br>",
#            #                        "<b> Date: </b>", date(df$time), "<br>",
#            #                        "<b> Time: </b>", strftime(df$time, format="%H:%M:%S"), "<br>"))
           

map <- leaflet() %>%  
  #addProviderTiles(providers$OpenStreetMap.DE)  %>% 
  addProviderTiles(providers$Stamen.TonerLite)  %>% 
  setView(lng=116.4074, lat=39.9042, zoom=11) %>% 
  addMarkers(lng=116.4074, lat=39.9042, popup="The birthplace of R")
map


#  setView(lng=116.4074, lat=39.9042, zoom=4)  

aoi_get(country = "China") %>% 
  aoi_map(returnMap = TRUE)

geocode('Beijing', pt = TRUE) %>% aoi_map(returnMap = TRUE)
aoi_get(list("Beijing", 13, 13)) %>% aoi_map(returnMap = T)

geocode('Beijing', pt = TRUE)
geocode_rev(c(39.90622, 116.3913))


library(mapboxer)

mapboxer(
  style = basemaps$Carto$positron,
  center = c(116.4074, 39.9042),
  zoom = 9,
  minZoom = 8
) %>% add_navigation_control(
  pos = "top-left",
  # Option passed to the 'NavigationControl'
  showCompass = FALSE
) %>%
  add_scale_control(
    pos = "bottom-left",
    # Option passed to the 'ScaleControl'
    unit = "nautical"
  ) %>%
  add_text_control(
    pos = "top-right",
    text = "mapboxer"
  )


# -----------
library(tidyverse)
library(shiny)
library(shinyjs)
library(lubridate)
library(RMySQL)
library(AOI) 
library(readr)
# source("./dbconfig.R")

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
# new_data <- all_data[seq(1, nrow(all_data), 12), ]
# write.csv(user_0_minute, "dat/test_data.csv")

# user_0 <- read_csv("dat/test_data.csv") %>% 
#   select(-c(X1))
# 
# data(user_0)

# args <- list(
#   drv = RMySQL::MySQL(),
#   username = Sys.getenv("USERNAME"),
#   password = Sys.getenv("PASSWORD"),
#   host     = Sys.getenv("HOST"),
#   port     = 3306,
#   dbname   = "stinky")
# 
# conn <- do.call(RMySQL::dbConnect, args) 
# on.exit(RMySQL::dbDisconnect(conn)) 

# dbGetQuery(conn, paste0(
#   "SELECT * FROM bejing as b
#     WHERE (b.user = 0 OR b.user = 1)
#       AND (time < '2008-10-24 00:00:00');"))

# df <- conn %>%
#   tbl("beijing") %>%
#   filter(user == 0 | user == 1,
#          time < '2008-10-24 00:00:00')  
# 
# df <- df %>% 
#   mutate(user = as.factor(user),
#          color = ifelse(user == 0, "#000000", "#800080"))

# RMySQL::dbRemoveTable(conn, "beijing")
# new_data <- read_csv("dat/new_data.csv")
# RMySQL::dbWriteTable(conn, "beijing", new_data_date)

new_data_date <- new_data %>% 
  mutate(date = date(time)) %>% 
  filter(date == ymd("2008-11-01") | date == ymd("2009-04-13")) 

colors <- c(brewer.pal(11, "Spectral"), brewer.pal(11, "RdYlGn"),
            brewer.pal(11, "PuOr"), brewer.pal(8, "BrBG") )


# df <- df %>%
#   mutate(user = as.factor(user),
#          color = ifelse(user == 0, "#000000", "#800080"))


# arrange(count(new_data_date, date), desc(n))
