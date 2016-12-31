#
# server.R
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
shinyServer(function(input, output) 
{
  
  model1 <- lm(Ozone ~ Temp, data=airquality)
  model2 <- lm(Ozone ~ Temp, data=subset(airquality, Ozone < 100))
  model3 <- loess(Ozone ~ Temp, data=airquality)
  
  model1pred <- reactive(
  {
    TempInput <- input$sliderTemp
    predict(model1, newdata = data.frame(Temp = TempInput))
  })
  
  model2pred <- reactive(
  {
    TempInput <- input$sliderTemp
    predict(model2, newdata = data.frame(Temp = TempInput))
  })
  
  model3pred <- reactive(
  {
    TempInput <- input$sliderTemp
    predict(model3, newdata = data.frame(Temp = TempInput))
  })
  
  output$plot1 <- renderPlot(
  {
    TempInput <- input$sliderTemp
    
    plot(x=airquality$Temp, y=airquality$Ozone, xlab="Temperature (degrees F)", ylab="Ozone (ppb)", bty = "n", pch = 16)
    
    if(input$showModel1)
    {
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2)
    {
      abline(model2, col = "blue", lwd = 2)
    }
    if(input$showModel3)
    {
      model3smooth <- loess.smooth(airquality$Temp, airquality$Ozone, span = 2/3, degree = 1, family = c("symmetric", "gaussian"), evaluation=50, data=airquality)
      lines(model3smooth, col = "green", lwd = 2)
    }

    points(TempInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(TempInput, model2pred(), col = "blue", pch = 16, cex = 2)
    points(TempInput, model3pred(), col = "green", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText(
  {
    model1pred()
  })
  
  output$pred2 <- renderText(
  {
    model2pred()
  })
  
  output$pred3 <- renderText(
  {
    model3pred()
  })
})