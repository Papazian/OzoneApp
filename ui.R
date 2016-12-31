#
# ui.R
#
# OzoneApp created using Shiny and R Studio 
#
# https://papazian.shinyapps.io/OzoneApp/
# 
# by John Papazian
# 
# December 30, 2016
#

library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Ozone Concentration from Temperature in New York City"),
  h5("by John P. on December 30, 2016"),
  h5("data source:  http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/airquality.html"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderTemp", "What is the temperature (degrees F)?", 50, 100, value = 85),
      checkboxInput("showModel1", "Show/Hide Model 1: Linear Regression on all data", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2: Linear Regression without Ozone outliers", value = TRUE),
      checkboxInput("showModel3", "Show/Hide Model 3: LOESS (curve fitting local polynomial regression) on all data", value = TRUE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h5("Predicted Ozone from Model 1: Linear Regression on all data"),
      textOutput("pred1"),
      h5("Predicted Ozone from Model 2: Linear Regression without Ozone outliers"),
      textOutput("pred2"),
      h5("Predicted Ozone from Model 3: LOESS (curve fitting local polynomial regression) on all data"),
      textOutput("pred3")
    )
  )
))