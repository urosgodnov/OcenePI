library(shiny)
source("auxiliary.R")

shinyServer(function(input, output, session) {
  
  #Dynamic slider creation
  output$TV <- renderUI({

    sliderInput("TV",
                "Stevilo tock pri vajah",
                min = 0,
                max = input$mTV,
                value = 50)
  })
  
  output$TP <- renderUI({
    
    sliderInput("TP",
                "Stevilo tock pri informacijski pismenosti",
                min = 0,
                max = input$mIP,
                value = 10)
  })
  
  output$TK <- renderUI({
    
    sliderInput("TK",
                "Stevilo tock pri obeh kolokvijih",
                min = 0,
                max = input$mKO,
                value = 20)
  })
  
  observeEvent(input$animation, {
    

    value = sample(25:input$mTV, 1)
    updateSliderInput(session, "TV", value = value)
    
    value = sample(5:input$mIP, 1)
    updateSliderInput(session, "TP", value = value)
    
    value = sample(8:input$mKO, 1)
    updateSliderInput(session, "TK", value = value)
    
  })
  
  sliderValues <- reactive({
    
      comDF(input$TV,input$TP,input$TK, input$mTV, input$mIP,input$mKO)
    
  }) 
  
  ocena <- reactive({
    
    ocenatxt(input$TV,input$TP,input$TK, input$mTV, input$mIP,input$mKO)
    
  }) 
  
  output$values <- renderTable({
    sliderValues()
  })
  
  output$ocena <- renderText({
    ocena()
  })
  

  
})