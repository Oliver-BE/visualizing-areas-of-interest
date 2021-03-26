################## LOAD PACKAGES ####################
library(tidyverse)
library(shiny)
library(shinythemes)  
library(shinycssloaders) 
library(plotly)
library(leaflet)
library(AOI)


# UI  --------------------------------------------------------------------------
ui <- fluidPage(
  # set theme
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

  # Row 1 (inputs)
  fluidRow( 
    column(
      width = 4, offset = 1,
      selectInput(
        inputId = "chosen_subject",
        label = "Choose a subject: ",
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
      width = 6, offset = 1,
      sliderInput(
        inputId = "time_stamp",
        label = "Datetime slider",
        min = 0, max = 20, value = 0, step = 0.5,
        ticks = TRUE
      )
    )
  ),

  hr(),
  
  # Row 2 (text output and plots)
  fluidRow(  
    # column to output plots (as tabs)
    column(
      width = 12,
      shinycssloaders::withSpinner(
        tabsetPanel(
          type = "tabs",
          tabPanel(
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
            )
          )
        )
      ),
     # style = "padding:10px 10px 10px 10px;"
    ),
    
  ) # end row 2
) # end UI
