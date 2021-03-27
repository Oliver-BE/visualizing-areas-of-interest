library(tidyverse)
library(shiny)
library(shinyjs)
library(ggplot2) 
library(lubridate)
library(leaflet)
library(plotly)
library(anytime)
library(AOI) 

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
    
    
    # leaflet title
    tag.map.title <- tags$style(HTML("
    .leaflet-control.map-title { 
        transform: translate(-50%,20%);
        position: fixed !important;
        left: 50%;
        text-align: center;
        padding-left: 10px; 
        padding-right: 10px; 
        background: rgba(255,255,255,0.75);
        font-weight: bold;
        font-size: 24px;
      }
    "))
    
    title <- tags$div(
      tag.map.title, HTML("Users in Beijing")
    )
      
    map <- leaflet(data = df) %>%  
      # addProviderTiles(providers$OpenStreetMap.DE)  %>% 
      addProviderTiles(providers$Stamen.TonerLite)  %>% 
      setView(lng=116.4074, lat=39.9042, zoom=10) %>% 
      addControl(title, position = "topleft", className="map-title")
    
    colors <- c("#6bdf12","#57d29d","#65179c","#74125c","#ba265b","#E08214","#B2ABD2","#8073AC", "#542788", "#2D004B", "#8C510A", "#BF812D","#DFC27D","#F6E8C3", "#C7EAE5", "#80CDC1", "#35978F", "#9E0142", "#D53E4F","#F46D43","#FDAE61", "#FEE08B", "#FFFFBF", "#E6F598","#ABDDA4","#FFCC33","#FF0033", "#9D1027", "#AE4978", "#62F423")
    
    for(user_number in levels(df$user)) {
      sel_color <- sample(colors, 1)  
      
      map <- map %>%
        addPolylines(lng = ~lon, lat = ~lat, data=df[df$user == user_number,], color = sel_color,
                     weight = 2, opacity = 3)
    }
    
    return(map)
  })
}