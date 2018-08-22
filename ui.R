#preparation
library(shiny)
library(ggplot2)
library(dplyr)
library(ranger)
library(lubridate)
library(xgboost)

total <- read.csv('data/total.csv', na.strings = c("", "NA"),stringsAsFactors = T)

load("model/rf.rda")
load("model/lm_total.rda")
load("model/lm_seasonal.rda")
load("model/lm_weather.rda")

total$Travel.Date <- as.Date(total$Travel.Date)
airport <- total %>% group_by(month) %>% summarise(bookings = mean(bookings, na.rm = T ))
total$month <- as.factor(total$month)

#UI
ui <- pageWithSidebar(
  headerPanel("Robert Harris Albany Sales Predictor"),
  sidebarPanel(

    fluidPage(
      
      # Copy the line below to make a date selector 
      dateInput("date", label = h3("Select Date"), value = Sys.Date(), min = min(total$Travel.Date) , max = max(total$Travel.Date) ),
      
      hr(),
      fluidRow(column(3, verbatimTextOutput("value")))
      
    )
    
  ),
  mainPanel(
    h3("Estimated Sales per Day:"),
    h4("(Modified data was used for information protection)"),
    p("with linear regression model"),
    h2(verbatimTextOutput("results_lm")),
    
    p("with Extreme Gradient Boosting model"),
    h2(verbatimTextOutput("results_rf")),
    
    plotOutput("icg.plot1"),
    style = "position:fixed;right:1px;")
  
)
