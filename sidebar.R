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
                                     tabsetPanel(
                                       tabPanel(
                                       "One Person",
                                       fluidRow(
                                         radioButtons(
                                           inputId = "chosen_random",
                                           label = "Choose a person:",
                                           choices =
                                             c("Randomly" = "Randomly",
                                               "By ID" = "Id"),
                                           selected = "Id"
                                         )
                                       ),
                                       fluidRow(
                                         selectInput(
                                          inputId = "chosen_id",
                                          label = "ID:",
                                          choices = c('0','1','2','3','4','5','8','9','10','11','13','14','15','16','17','22','25','28','30','34','35','36','37','38','39','41','42','44','62','68','82','84','85','96','126','128','144','153','163','167','179'
                                                      ),
                                          selected = "14"
                                        )
                                       ),
                                       
                                       fluidRow(actionButton(inputId = "one_person_id", label = "Visualize"), align = "center"),
                                       value = "single_person_tab"
                                     ), 
                                     
                                     # tab 2
                                     tabPanel("Many People on one day",
                                              fluidRow(numericInput(
                                                min=1,
                                                max=40,
                                                inputId = "chosen_amount",
                                                label = "How Many People?",
                                                value = 2
                                              )),
                                              fluidRow(actionButton(inputId = "many_people_id", label = "Visualize"), align = "center"),
                                              value = "many_person_tab"
                                       ), id = "tab_panel_id")
                                   )))
