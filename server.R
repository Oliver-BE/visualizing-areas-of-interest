print("server.R")
library(tidyverse)
library(shiny)
library(ggplot2)
library(lubridate)
library(leaflet)
library(plotly)
library(anytime)
library(AOI)
source("./global.R")

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  
  # Reactive objects -----------------------------------------------------------
  # user_0_react <- reactive({
  #   req(input$slider_input) 
  #   time_input_min <- ymd_hms(input$slider_input[1])
  #   time_input_max <- ymd_hms(input$slider_input[2])
  #   # time_input <- ymd_hms(input$slider_input) 
  #   
  #   
  #   df <- user_0 %>%
  #     filter(time >= time_input_min & time <= time_input_max)
  #   # filter(time <= time_input) 
  #   
  #   return(df)
  # })
  
  # min_timestamp <- reactive({
  #   df <- user_0
  #   return(min(df$time))
  # })
  # 
  # max_timestamp <- reactive({
  #   df <- user_0 
  #   return(max(df$time))
  # })
  
  
  # Outputs --------------------------------------------------------------------
  # all games datatable output
  # output$all_games_dt <- DT::renderDataTable(DT::datatable(all_games()))
  
  output$leaflet_map <- renderLeaflet({
    # df <- user_0_react()
    df <- user_0
    
    map <- leaflet(data = df) %>%  
      addProviderTiles(providers$OpenStreetMap.DE)  %>% 
      # addProviderTiles(providers$Stamen.TonerLite)  %>%
      # setView(lng=116.4074, lat=39.9042, zoom=10) %>% 
      setView(lng=mean(df$lon), lat=mean(df$lat), zoom=13) %>% 
      addPolylines(lng = ~lon, lat = ~lat, 
                   weight = 3,
                   opacity = 3) %>%
      addMarkers(lng=~lon, lat=~lat, 
                 popup = paste("<b><u>","User Number ", df$user, "</u></b>", "<br>",
                               "<b> Date: </b>", date(df$time), "<br>",
                               "<b> Time: </b>", strftime(df$time, format="%H:%M:%S"), "<br>"))
    
    return(map)
  })
  
  # create dynamic slider based on date range of subject
  # output$slider_input <- renderUI({
  #   sliderInput(
  #     inputId = "slider_input",
  #     label = "Select a time stamp:",
  #     min = min_timestamp(),
  #     max = max_timestamp(),
  #     value = c(min_timestamp(), max_timestamp()),
  #     # value = min_timestamp(),
  #     step = 100,
  #     dragRange = TRUE,
  #     # animate = animationOptions(interval=300, loop=TRUE, playButton="testme"),
  #     width = "95%"
  #   )
  # })
  
}
