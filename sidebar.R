################## LOAD PACKAGES ####################
library(tidyverse)
library(shiny)
library(shinyjs)
library(shinythemes)
library(shinycssloaders)
library(plotly)
library(leaflet)
library(AOI)


mySidebar <- sidebarPanel(
                          fluidRow(width = 8,
                                   navbarPage(
                                     "See Lives of:",
                                     tabPanel(
                                       "One Person",
                                       fluidRow(
                                         radioButtons(
                                           inputId = "chosen_random",
                                           label = "Choose a person:",
                                           choices =
                                             c("Randomly" = "Randomly",
                                               "By ID" = "Id")
                                         )
                                       ),
                                       fluidRow(numericInput(
                                         inputId = "chosen_id",
                                         label = "ID:",
                                         value = 0,
                                         min =0,
                                         max = 182
                                       )),
                                       fluidRow(numericInput(
                                         inputId = "days_id",
                                         label = "Over how many days?",
                                         value = 1,
                                         min =1,
                                         max = 10 
                                         
                                       )),
                                       
                                       fluidRow(actionButton(inputId = "one_person_id", label = "Visualize"), align = "center"),
                                     ),
                                     tabPanel("Many People on one day",
                                              fluidRow(numericInput(
                                                min=1,
                                                max=100,
                                                inputId = "chosen_amount",
                                                label = "How Many People?",
                                                value = 2
                                              )),
                                              fluidRow(actionButton(inputId = "many_people_id", label = "Visualize"), align = "center")
                                   ))))
