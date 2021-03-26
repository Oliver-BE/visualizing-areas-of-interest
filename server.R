library(tidyverse)
library(shiny)
library(ggplot2)
library(lubridate)
<<<<<<< HEAD
library(leaflet)
library(plotly)
library(AOI)
=======
library(plotly)
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
source("./global.R")

# Server -----------------------------------------------------------------------
server <- function(input, output, session) {

  # Reactive objects -----------------------------------------------------------
<<<<<<< HEAD
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
=======
  # reactive DF for raw data
  all_games <- reactive({
     
    # Read in the specified inputs from UI
    chosen_person <- input$chosen_person
    chosen_stat <- input$chosen_stat
    min_survival_time <-  input$min_survival_time 
    
    # don't filter by player if we're looking at everyone
    if(chosen_person == "All") {
      df <- apex_df %>%
        filter(`Survival Time (min)` >= min_survival_time) %>% 
        arrange(desc(Timestamp)) %>% 
        select(-c(Timestamp_raw))
      
      # don't filter by statistic if we're looking at all stats
      if(chosen_stat == "All") {
        df <- df
      }
      
      else {
        df <- df %>%
          select(Player, chosen_stat)
      }
    }
  
    # otherwise, filter by player
    else {
      df <- apex_df %>%
        filter(Player == chosen_person, `Survival Time (min)` >= min_survival_time) %>% 
        arrange(desc(Timestamp)) %>% 
        select(-c(Timestamp_raw))
      
      # don't filter by statistic if we're looking at all stats
      if(chosen_stat == "All") {
        df <- df
      }
      
      else {
        df <- df %>%
          select(Player, chosen_stat)
      }
    }
    
    return(df)
  })
  
  # reactive df for summary stats datatable
  summary_stats <- reactive ({
    
    chosen_person <- input$chosen_person
    min_survival_time <-  input$min_survival_time 
    
    if(chosen_person == "All") {
      df <- apex_df %>% 
        filter(`Survival Time (min)` >= min_survival_time)
    }
    
    else {
      df <- apex_df %>% 
        filter(Player == chosen_person, `Survival Time (min)` >= min_survival_time)
    }
    
    df <- df %>% 
      group_by(Player) %>% 
      summarize(`Num Games Played` = n(),
                `Num Wins` = sum(ifelse(`Squad Placed` == 1, TRUE, FALSE)),
                `Total Damage` = sum(Damage),
                `Total Kills` = sum(Kills),
                `Total Assists` = sum(Assists),
                `Total Knocks` = sum(Knocks),
                `Total Survival Time` = sum(`Survival Time (min)`),
                `KDR` = round(`Total Kills` / `Num Games Played`, 2),
                `Damage Per Game` = round(`Total Damage` / `Num Games Played`, 0),
                `Damage Per Minute` = round(`Total Damage` / `Total Survival Time`, 1)) %>% 
      arrange(desc(`Num Games Played`))
    
    return(df)
      
  })
  
  # reactive df for leaderboard datatable
  leaderboard <- reactive ({
    chosen_stat <- input$chosen_stat
    
    if(chosen_stat == "All") {
      df <- leaderboard_df
    }
    
    else {
      df <- leaderboard_df %>% 
        filter(Statistic == paste("Most", chosen_stat))
    }
    
    return(df)
    
  })
  
  # over time line chart
  over_time <- reactive({
    
    chosen_person <- input$chosen_person
    chosen_stat <- input$chosen_stat
    
    # if "all" stats are chosen, this plot won't work (default to Damage)
    if(chosen_stat == "All") {
      updateSelectInput(session, inputId = "chosen_stat", selected = "Damage")
    }
    
    # if comparing all players, don't filter by player
    if(chosen_person == "All") {
      oliver_df <- apex_df %>% 
        filter(Player == "Oliver") %>% 
        mutate(`Game Number` = row_number())
      oliver_df <- cbind(oliver_df, "Cumulative" = cumsum(oliver_df[[chosen_stat]]))
      
      connor_df <- apex_df %>% 
        filter(Player == "Connor") %>% 
        mutate(`Game Number` = row_number())
      connor_df <- cbind(connor_df, "Cumulative" = cumsum(connor_df[[chosen_stat]]))
      
      isaac_df <- apex_df %>% 
        filter(Player == "Isaac") %>% 
        mutate(`Game Number` = row_number())
      isaac_df <- cbind(isaac_df, "Cumulative" = cumsum(isaac_df[[chosen_stat]]))
      
      nat_df <- apex_df %>% 
        filter(Player == "Nat") %>% 
        mutate(`Game Number` = row_number())
      nat_df <- cbind(nat_df, "Cumulative" = cumsum(nat_df[[chosen_stat]]))
      
      thomas_df <- apex_df %>% 
        filter(Player == "Thomas") %>% 
        mutate(`Game Number` = row_number())
      thomas_df <- cbind(thomas_df, "Cumulative" = cumsum(thomas_df[[chosen_stat]]))
      
      df <- rbind(oliver_df, connor_df, isaac_df, nat_df, thomas_df)  
      
      fig <- plot_ly(df, x = ~`Timestamp_raw`, y = ~`Cumulative`,
                     color = ~Player,
                     type = 'scatter', mode = 'lines') %>% 
              layout(title = paste(chosen_stat, "over time by", chosen_person),
                     showlegend = T,
                     xaxis = list(title = "Date"),
                     yaxis = list(title = paste("Cumulative", chosen_stat))) 
    }
    
    else {
      df <- apex_df %>% 
        filter(Player == chosen_person) %>% 
        mutate(`Game Number` = row_number())
      
      # sum up whatever stat we are looking at (call it "Cumulative")
      df <- cbind(df, "Cumulative" = cumsum(df[[chosen_stat]]))
      
      fig <- plot_ly(df, x = ~`Timestamp_raw`, y = ~Cumulative, 
                     type = 'scatter', mode = 'lines')  %>% 
              layout(title = paste(chosen_stat, "over time by", chosen_person),
                     xaxis = list(title = "Date"),
                     yaxis = list(title = paste("Cumulative", chosen_stat))) 
    }
     
    return(fig)
  })
  
  # reactive pie chart
  donut_c <- reactive({
    
    chosen_person <- input$chosen_person
    
    if(chosen_person == "All") {
      df <- apex_df %>% 
        group_by(`Legend used`) %>% 
        select(`Legend used`) %>% 
        drop_na()
    }
    else {
      df <- apex_df %>% 
        filter(Player == chosen_person) %>% 
        group_by(`Legend used`) %>% 
        select(`Legend used`) %>% 
        drop_na()
    }
    
    df <- df %>% 
      summarize(count = n())
    
    donut_fig <- df %>% 
      plot_ly(labels = ~`Legend used`, values = ~count) %>% 
      add_pie(hole = 0.6) %>% 
      layout(title = paste("Legends Used by", input$chosen_person),  showlegend = T,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    return(donut_fig)
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
  })
  
  # Outputs --------------------------------------------------------------------
  # all games datatable output
<<<<<<< HEAD
  # output$all_games_dt <- DT::renderDataTable(DT::datatable(all_games()))
  
  output$leaflet_map <- map
  
=======
  output$all_games_dt <- DT::renderDataTable(DT::datatable(all_games()))
  
  # summary stats datatable output
  output$summary_stats_dt <- DT::renderDataTable(DT::datatable(summary_stats()))
  
  # kills over time line chart
  output$over_time_fig <- renderPlotly(over_time()) 
  
  # leaderboard datatable output
  output$leaderboard_dt <- DT::renderDataTable(DT::datatable(leaderboard()))
  
  # pie chart output
  output$donut_fig <- renderPlotly(donut_c()) 
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
}
