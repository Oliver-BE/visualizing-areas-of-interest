library(tidyverse)
library(shiny)
library(shinyjs)
library(ggplot2) 
library(lubridate)
library(leaflet)
library(plotly)
library(anytime)
library(AOI)
# library(DBI)
# library(RColorBrewer)
# source("./global.R")

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {
  
  # establish database connection
  args <- list(
    drv = RMySQL::MySQL(),
    username = Sys.getenv("USERNAME"),
    password = Sys.getenv("PASSWORD"),
    host     = Sys.getenv("HOST"),
    port     = 3306,
    dbname   = "stinky")
  
  # conn <- do.call(DBI::dbConnect, args) %>%
  #   tbl("bejing") 
  # on.exit(DBI::dbDisconnect(conn))
  
  # Reactive objects -----------------------------------------------------------
  # process one-person data when user clicks action button
  one_person_data <- eventReactive(input$one_person_id, {  
    conn <- do.call(RMySQL::dbConnect, args) 
    on.exit(RMySQL::dbDisconnect(conn))
    
    # figure out if random person or pre-selected
    if(input$chosen_random == "Randomly") {
      all_users <- c('0','1','2','3','4','5','8','9','10','11','13','14','15','16','17','22','25','28','30','34','35','36','37','38','39','41','42','44','62','68','82','84','85','96','126','128','144','153','163','167','179')
      person_input <- sample(all_users, 1)
    } 
    else {
      person_input <- input$chosen_id
    }
    
    df <- conn %>%  
      tbl("beijing") %>%   
      filter(user == person_input) %>% 
      collect()
    
    df <- df %>% 
      mutate(user = as.factor(user))
    
    return(df)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  # process many-people data when user clicks action button
  many_person_data <- eventReactive(input$many_people_id, {  
    conn <- do.call(RMySQL::dbConnect, args) 
    on.exit(RMySQL::dbDisconnect(conn))
    
    # get input of number of people to compare
    num_people <- input$chosen_amount
    
    # randomly select
    all_users <- c('0','1','2','3','4','5','8','9','10','11','13','14','15','16','17','22','25','28','30','34','35','36','37','38','39','41','42','44','62','68','82','84','85','96','126','128','144','153','163','167','179')
    chosen_people <- sample(all_users,num_people)
    
    
    df <- conn %>%  
      tbl("beijing") %>%   
      filter(user %in% chosen_people) %>% 
      collect()
    
    df <- df %>% 
      mutate(user = as.factor(user))
    
    return(df)
  }, ignoreNULL = FALSE, ignoreInit = FALSE)
  
  
  # Outputs --------------------------------------------------------------------
  # leaflet output
  output$leaflet_map <- renderLeaflet({ 
    # if only looking at one person
    if(input$tab_panel_id == "single_person_tab") {
      df <- one_person_data()
    }
    if(input$tab_panel_id == "many_person_tab") {
      df <- many_person_data()
    }
    
      
    map <- leaflet(data = df) %>%  
      # addProviderTiles(providers$OpenStreetMap.DE)  %>% 
      addProviderTiles(providers$Stamen.TonerLite)  %>% 
      setView(lng=116.4074, lat=39.9042, zoom=10) 
    
    colors <- c(brewer.pal(11, "Spectral"), brewer.pal(11, "RdYlGn"),
                brewer.pal(11, "PuOr"), brewer.pal(8, "BrBG") )  
    
    for(user_number in levels(df$user)) {
      sel_color <- sample(colors, 1)  
      
      map <- map %>%
        addPolylines(lng = ~lon, lat = ~lat, data=df[df$user == user_number,], color = sel_color,
                     weight = 2, opacity = 3)
    }
    
    return(map)
  })
}