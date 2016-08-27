
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

source("getRecentMeteoData.R")

normalizeVector <- function(x) { 
  #attr(x, 'normalizeMin') <- min(x);
  #attr(x, 'normalizeMax') <- max(x);
  xMin <- min(x);
  xMax <- max(x);
  
  #x <- (x-min(x))/(max(x)-min(x));
  #x <- (x-min(x))/(max(x));
  xDiff <- xMax - xMin;
  xFactor <- 1/xDiff;
  
  
  x <- x - xMin;
  x <- x * xFactor;
  
  
  x <- (x^2)^(1/2)
  xMin <- (xMin^2)^(1/2)
  
  attr(x,"yMax") <- xMax;
  attr(x,"yMin") <- xMin;
  attr(x,"yFactor") <- xFactor;
  
  return(x);
};

X <- getRecentWeatherData()

X <- as.vector(X, mode = "integer")

temp <- (X[1])

shinyUI(pageWithSidebar(
  headerPanel("plant.watering"),
  sidebarPanel(
    h4('Enter the Weather Parameters on your location at 22h00'),
    h5('Default values are the actual weather in Zurich (CH)'),
    numericInput("temperature", "Temperature in C (-10 - +40): ", value =  temp, -10, 40, 1),
    #textInput("temperature", "Temperature in C (+10 - +40): ", value =  temp),
    p(''),
    numericInput("pression", "Pressure (QFE - Sensor Value): ", X[2], 900, 1050, 2),
    HTML('<br /><br />'),
    numericInput("wind", "Wind in km/h: ", X[3], 0, 25, 0.5),
    numericInput("rain", "Rain in mm/h: ", X[4], 0, 25, 0.1),
    numericInput("humidity", "Humidity in % (50% - 100%): ", X[5], 50, 100, 5)
  ),
  mainPanel(
    h4('You entered:'),
    verbatimTextOutput("X"),
    uiOutput('test'),
    h4("Result"),
    verbatimTextOutput("pumpDuration")
  )
))
