################## LOAD PACKAGES ####################
library(tidyverse)
library(shiny)
library(shinythemes)  
library(shinycssloaders) 
library(plotly)
<<<<<<< HEAD
library(leaflet)
library(AOI)
=======
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa


# UI  --------------------------------------------------------------------------
ui <- fluidPage(
  # set theme
<<<<<<< HEAD
  theme = shinytheme("flatly"),
  #shinythemes::themeSelector(),
  
  # set favicon
  # tags$head(tags$link(rel="shortcut icon", href="./www/favicon.ico")),
  # tags$head(tags$link(rel="icon", href="./www/favicon.ico")),
  
  # tags$style(type="text/css",
  #            ".shiny-output-error { visibility: hidden; }",
  #            ".shiny-output-error:before { visibility: hidden; }"
  # ),

  navbarPage(title = "Visualizing Areas of Interest in Beijing"),
=======
  theme = shinytheme("yeti"),
  # shinythemes::themeSelector(),
  
  # set favicon
  tags$head(tags$link(rel="shortcut icon", href="./www/favicon.ico")),
  tags$head(tags$link(rel="icon", href="./www/favicon.ico")),
  
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),

  navbarPage(title = "Apex Dashboard"),
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa

  # Row 1 (inputs)
  fluidRow( 
    column(
<<<<<<< HEAD
      width = 4, offset = 1,
      selectInput(
        inputId = "chosen_subject",
        label = "Choose a subject: ",
=======
      width = 2,
      img(
        src = "apex_logo_2.png", height = 100
      ),
      align = "center"
    ), 
    
    column(
      width = 3,
      selectInput(
        inputId = "chosen_person",
        label = "Choose your Player: ",
        choices = c(
          "Compare All" = "All",
          "Oliver" = "Oliver",
          "Nat" = "Nat",
          "Isaac" = "Isaac",
          "Connor" = "Connor",
          "Thomas" = "Thomas"
        ),
        selected = "All"
      )
    ),
    column(
      width = 2,
      selectInput(
        inputId = "chosen_stat",
        label = "Choose a statistic: ",
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
        choices = c(
          "All" = "All",
          "Damage" = "Damage",
          "Kills" = "Kills",
          "Assists" = "Assists",
          "Knocks" = "Knocks"
        ),
        selected = "all"
      )
    ), 
    column(
<<<<<<< HEAD
      width = 6, offset = 1,
      sliderInput(
        inputId = "time_stamp",
        label = "Datetime slider",
=======
      width = 5,
      sliderInput(
        inputId = "min_survival_time",
        label = "Filter by minimum survival time (in minutes):",
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
        min = 0, max = 20, value = 0, step = 0.5,
        ticks = TRUE
      )
    )
  ),

  hr(),
<<<<<<< HEAD
  
  # Row 2 (text output and plots)
=======
  # Row 3 (text output and plots)
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
  fluidRow(  
    # column to output plots (as tabs)
    column(
      width = 12,
      shinycssloaders::withSpinner(
        tabsetPanel(
          type = "tabs",
          tabPanel(
<<<<<<< HEAD
            title = "Map",
            br(),
            shinycssloaders::withSpinner(
              leafletOutput("leaflet_map", height=500)
            )
          ),
          tabPanel(
            title = "Plot1",
            br(),
            shinycssloaders::withSpinner(
              # plotlyOutput()
              print("HI")
            )
          ),
          tabPanel(
            title = "Plot2",
            br(),
            shinycssloaders::withSpinner(
              # plotlyOutput()
              print("HI")
=======
            "All Games",
            br(),
            shinycssloaders::withSpinner(
              DT::dataTableOutput(
                outputId = "all_games_dt"
              )
            )
          ),
          tabPanel(
            "Summary Stats",
            br(),
            shinycssloaders::withSpinner(
              DT::dataTableOutput(
                outputId = "summary_stats_dt"
              )
            )
          ),
          tabPanel(
            "Stats Over Time Chart",
            br(),
            shinycssloaders::withSpinner(
              plotlyOutput("over_time_fig")
            )
          ),
          tabPanel(
            "Leaderboard",
            br(),
            shinycssloaders::withSpinner(
              DT::dataTableOutput(
                outputId = "leaderboard_dt"
              )
            )
          ), 
          tabPanel(
            "Legends Used",
            br(),
            shinycssloaders::withSpinner(
              plotlyOutput("donut_fig")
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
            )
          )
        )
      ),
<<<<<<< HEAD
     # style = "padding:10px 10px 10px 10px;"
    ),
    
  ) # end row 2
=======
      style = "padding:10px 10px 10px 10px;"
    ),
    
  ) # end row 3
>>>>>>> ee1c0f42e2a64f8a3539dd45b496ffcd357d15aa
) # end UI
