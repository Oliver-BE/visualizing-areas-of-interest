################## LOAD PACKAGES ####################
print("ui.R")
library(tidyverse)
library(shiny)
library(shinythemes)
library(shinycssloaders)
library(plotly)
library(leaflet)
library(AOI)

source('./sidebar.R')
source('./aboutPage.R')

# UI  --------------------------------------------------------------------------
ui <- fluidPage(# set theme
  theme = shinytheme("flatly"),
  #shinythemes::themeSelector(),
  # set favicon
  # tags$head(tags$link(rel="shortcut icon", href="./www/favicon.ico")),
  # tags$head(tags$link(rel="icon", href="./www/favicon.ico")),
  
  # tags$style(type="text/css",
  #            ".shiny-output-error { visibility: hidden; }",
  #            ".shiny-output-error:before { visibility: hidden; }"
  # ),
  
  navbarPage(
    title = "Areas of Interest in Beijing",
    tabPanel(
      title = "Vizualizations",
      icon = icon("map-marked-alt", lib = "font-awesome"),
      sidebarLayout(mySidebar,
                    mainPanel(
                              # Row 2 (text output and plots)
                              fluidRow(
                                # column to output plots (as tabs)
                                column(width = 12,
                                       shinycssloaders::withSpinner(
                                         tabsetPanel(
                                           type = "tabs",
                                           tabPanel(title = "Map",
                                                    br(),
                                                    # shinycssloaders::withSpinner(
                                                    leafletOutput("leaflet_map", height = 550)
                                                    # )
                                           ),
                                           tabPanel(title = "Plot1",
                                                    br(),
                                                    shinycssloaders::withSpinner(# plotlyOutput()
                                                      print("HI"))),
                                           tabPanel(title = "Plot2",
                                                    br(),
                                                    shinycssloaders::withSpinner(# plotlyOutput()
                                                      print("HI")))
                                         )
                                       ))
                              )))),
                    myAboutPage
                    # footer = "Connor, Isaac and Ollie made this in 2021"
    )# end navbarPage
  ) # end UI
