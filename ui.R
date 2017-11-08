#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel("Iris Species Predictor"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "petal.length",
        label = "Petal Length (cm)",
        min = 1,
        max = 7,
        value = 4),
      sliderInput(
        inputId = "petal.width",
        label = "Petal Width (cm)",
        min = 0.0,
        max = 2.5,
        step = 0.5,
        value = 1.5),
      p("To predict a species of iris flower, please select the petal length and the petal width using the two sliders above."),
      p("The predicted species will be displayed in the text on the top right. In addition, a data visualization in the bottom right will show how the decision was made. The lines represent the decision boundaries and the red X represents your selected input.")),
    mainPanel(
      textOutput(
        outputId = "text"),
      plotOutput(
        outputId = "plot"))))
