library(tidyverse)
library(shiny)
library(ggplot2)
library(lubridate)
library(leaflet)
library(plotly)
library(AOI)
source("./global.R")

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  
  # Reactive objects -----------------------------------------------------------
  # leaflet output
  map <- renderLeaflet({
    
    map <- leaflet() %>%  
      #addProviderTiles(providers$OpenStreetMap.DE)  %>% 
      addProviderTiles(providers$Stamen.TonerLite)  %>%
      setView(lng=116.4074, lat=39.9042, zoom=10) %>% 
      addMarkers(lng=116.4074, lat=39.9042, 
                 popup = paste("<em>","Enter something from DF here","</em>", "<br>",
                               "<b> Description here: </b> <br>",
                               "<b> New descirption here: </b> <br>", 
                               "<b> Last description here: </b> $"))
    return(map)
  })
  
  # Outputs --------------------------------------------------------------------
  # all games datatable output
  # output$all_games_dt <- DT::renderDataTable(DT::datatable(all_games()))
  
  output$leaflet_map <- map
  
}
