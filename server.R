library(shiny)
source("auxiliary.R")

shinyServer(function(input, output) {
  
  sliderValues <- reactive({
    
      comDF(input$TV,input$TP,input$TK)
    
  }) 
  
  ocena <- reactive({
    
    ocenatxt(input$TV,input$TP,input$TK)
    
  }) 
  
  output$values <- renderTable({
    sliderValues()
  })
  
  output$ocena <- renderText({
    ocena()
  })
  
})