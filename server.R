library(shiny)
source("auxiliary.R")

shinyServer(function(input, output, session) {
  
  observeEvent(input$animation, {
    

    value = sample(0:70, 1)
    updateSliderInput(session, "TV", value = value)
    
    value = sample(0:20, 1)
    updateSliderInput(session, "TP", value = value)
    
    value = sample(0:42, 1)
    updateSliderInput(session, "TK", value = value)
    
  })
  
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