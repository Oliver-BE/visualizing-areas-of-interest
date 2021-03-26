################## LOAD PACKAGES ####################
library(tidyverse)
library(shiny)
library(shinythemes)  
library(shinycssloaders) 
library(plotly)


# UI  --------------------------------------------------------------------------
ui <- fluidPage(
  # set theme
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

  # Row 1 (inputs)
  fluidRow( 
    column(
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
      width = 5,
      sliderInput(
        inputId = "min_survival_time",
        label = "Filter by minimum survival time (in minutes):",
        min = 0, max = 20, value = 0, step = 0.5,
        ticks = TRUE
      )
    )
  ),

  hr(),
  # Row 3 (text output and plots)
  fluidRow(  
    # column to output plots (as tabs)
    column(
      width = 12,
      shinycssloaders::withSpinner(
        tabsetPanel(
          type = "tabs",
          tabPanel(
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
            )
          )
        )
      ),
      style = "padding:10px 10px 10px 10px;"
    ),
    
  ) # end row 3
) # end UI
