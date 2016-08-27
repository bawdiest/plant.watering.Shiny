
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

getX <- function(input) {
  X <- input$temperature
  X <- cbind(X, input$pression)
  
  #X <- cbind(X, input$wind) "Wind is not trained enough
  X <- cbind(X, 0)
  #X <- cbind(X, input$rain) "Rain is not trained enough
  X <- cbind(X, 0)
  
  X <- cbind(X, input$humidity)
  X <- as.vector(X)
  return(X)
}

getResult <- function(X, xMin, xMax, theta) {
  r <- (X - xMin) / xMax
  r <- r %*% theta
  r <- r * 1218
  
  r <- (r * 100) / 60 #Translate seconds into ml
}

getModel <- function(param) {
  model <- read.csv("data/iRigModel", sep="")
  model <- t(model)
  if(param == "xMin") {
    return(model[,1])
  }
  if(param == "xMax") {
    return(model[,2])
  }
  if(param == "theta") {
    return(model[,3])
  }
}


#model <- t(model)

shinyServer(function(input, output) {
  shinyAppDir(".")
  
  
  X <- reactive({getX(input)})
  
  output$X <- X
  output$xMin <- reactive({getModel("xMin")})
  
  output$pumpDuration <- renderText({paste("This basilicum plant needs today", round(getResult(getX(input), getModel("xMin"), getModel("xMax"), getModel("theta"))), "ml of water", sep = " ")})
  
  output$test <- renderUI({
    tags$img(src = "http://mikmak.cc/plant.jpg")
  })
  
})
