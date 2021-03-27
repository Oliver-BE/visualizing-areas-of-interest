################## LOAD PACKAGES ####################
library(tidyverse)
library(shiny)
library(shinyjs)
library(shinythemes)
library(shinycssloaders)
library(plotly)
library(leaflet)
library(AOI)


myAboutPage <- navbarMenu(
  "About",
  tabPanel(
    "The Data",
    fluidRow(titlePanel("The Data")),
    fluidRow(
      tags$p("This data is drawn from the Geolife data set from Microsoft. We attempted to wield this data to visualize the lives of people and their movements around Beijing for use in machine learning tasks. They require these citations when their data is used.&nbsp;")),
    fluidRow(
        tags$p("Yu Zheng, Lizhu Zhang, Xing Xie, Wei-Ying Ma. Mining interesting locations and travel sequences from GPS trajectories. In Proceedings of International conference on World Wild Web (WWW 2009), Madrid Spain. ACM Press: 791-800."),
        tags$p("Yu Zheng, Quannan Li, Yukun Chen, Xing Xie, Wei-Ying Ma. Understanding Mobility Based on GPS Data. In Proceedings of ACM conference on Ubiquitous Computing (UbiComp 2008), Seoul, Korea. ACM Press: 312-321."),
        tags$p("Yu Zheng, Xing Xie, Wei-Ying Ma, GeoLife: A Collaborative Social Networking Service among User, location and trajectory. Invited paper, in IEEE Data Engineering Bulletin. 33, 2, 2010, pp. 32-40.")
    )
  ),
  tabPanel("Us",
           fluidRow(titlePanel("About")),
           fluidRow(
             column(
               width = 5,
               fluidRow(titlePanel("The Project")),
               fluidRow(
                 offset = 1,
                 "This porject attempted to make use of RShiny's data viz features and AWS' hosting capabilities store our large dataset"
               )
             ),
             column(
               width = 5,
               fluidRow(titlePanel("The Team")),
               fluidRow(
                 offset = 1,
                 "Connor Haugh cleaned data, made UI, and learned rshiny. Oliver Baldwin-Edwards wrote the core data visualizations, Isaac Caruso masterminded hosting and deployment. This project is for the 2021 HACKSMITH event in less than 24 hours."
               )
             )
           ))
) # end navbarmenu