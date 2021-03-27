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
      tags$p("This data is drawn from the Geolife dataset from Microsoft. The dataset tabulates location data for a set of users across the globe, but in Beijing in particular, in order to learn more about people's life patterns for machine learning tasks. This dataset contains 17,621 trajectories with a total distance of about 1.2 million kilometers and a total duration of 48,000+ hours. We attempted to wield this data to visualize the lives of people and their movements around Beijing for use in machine learning tasks. This dataset is obviously very large, and deployment with Rshiny has to consider the density of these data points.The dataset require these citations when their data is used.")),
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
                 tags$p(
                 "This project offered a number of challenges:"),
                 tags$ul(
                   tags$li("Deploy a dense dataset using AWS"),
                   tags$li("Keep client-side loadtimes fast"),
                   tags$li("Create a compelling experince out of our dataset")
                 ),
                 tags$p("First, we had to efficiently deploy our dataset to our Rshiny app for learning, cleaning, and visualization. We used AWS’s Amazon Relational Database Service to couple our Rshiny server (also deployed on AWS) to make lightweight load times for our heavyweight shiny app. We displayed our data visualization using the leaflet library to plot geographic coordinates against a stunning, information-rich background. Deployment was contianerized in docker, and deploys happen every minute.")
               )
             ),
             column( style='padding-left:70px;',
               width = 5,
               fluidRow(titlePanel("The Team")),
               fluidRow(
                 offset = 1,
                 tags$p("The team is comprised of three Amherst College Seniors:"),
                 tags$ul(
                 tags$li("Connor Haugh cleaned data and masterminded UX/UI."),
                 tags$li("Oliver Baldwin-Edwards wrote the core data visualizations."),
                 tags$li("Isaac Caruso masterminded hosting and deployment.")
                 ),
                 tags$p("This project is for the 2021 HACKSMITH event, created in less than 24 hours."),
                 tags$a(href="https://github.com/Oliver-BE/visualizing-areas-of-interest", style="padding-toptag$a?:40px", "Learn More on Github")
               )
             )
           ))
) # end navbarmen
