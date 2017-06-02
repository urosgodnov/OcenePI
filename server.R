library(shiny)
library(ggplot2)
library(dplyr)
library(skimr)
library(tidyr)
library(rpivotTable)
library(shinycssloaders)
source("auxiliary.R")

data<-read.csv(file="./data/PI.csv",sep=";")
data<-data[,1:3]

shinyServer(function(input, output, session) {
  
  #Dynamic slider creation
  output$TV <- renderUI({


    sliderInput("TV",
                 "Stevilo tock pri vajah",
                 min = 0,
                 max = input$mTV,
                value = 50
              )

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
  

  output$analiza <- renderPlot({
    
    df<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]))
    
    ggplot(data=df,aes(x=Ocena))+
      geom_bar(stat="count")+ylab("Frekvenca")+theme(text = element_text(size=20))
    
  })
  
  output$naslov <- renderText({
    naslov=paste("Ocene v obdobju ",as.character(input$Obdobje[1])," in "
                 ,as.character(input$Obdobje[2]))
  })
  
  
  output$tabelavse <- renderTable({
    
    dff<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]))
    
    s<-(skim(dff))
    
    a<-s[s$var=="Ocena",c("stat","value")]
    
    colnames(a)[1:2]<-c("statistika", "vrednost")
    
    dfa<-a[c(4:7,10),]
  })
  
  
  output$poletih <- renderPlot({
    
    df<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]))
    
    ggplot(data=df,aes(x=Ocena))+facet_grid(Predmet~Leto)+
      geom_bar(stat="bin")+ylab("Frekvenca")+theme(text = element_text(size=12))    
  })
  
  output$tabelapoletihVS2005 <- renderTable({
    
    pogoji=c("n","mean","sd","min","median","max")
    
    dff<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]) & Predmet=="VS2005")%>%
      group_by(Leto)%>%do(skim(.))%>%filter(var=="Ocena",stat %in% pogoji)%>%
      select(Leto,stat,value)%>%spread(key=Leto,value=value)
    
  })
  
  output$tabelapoletihVS2013 <- renderTable({
    
    validate(
      need(input$Obdobje[2] > 2012, 'Ce zelite prikazati statistiko programa VS2013, izberite ustrezno obdobje!')
    )
    
    pogoji=c("n","mean","sd","min","median","max")
    
    dff<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]) & Predmet=="VS2013")%>%
      group_by(Leto)%>%do(skim(.))%>%filter(var=="Ocena",stat %in% pogoji)%>%
      select(Leto,stat,value)%>%spread(key=Leto,value=value)
    
  })
  
  output$tabelapoletihUN2005 <- renderTable({
    
    pogoji=c("n","mean","sd","min","median","max")
    
    dff<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]) & Predmet=="UN2005")%>%
      group_by(Leto)%>%do(skim(.))%>%filter(var=="Ocena",stat %in% pogoji)%>%
      select(Leto,stat,value)%>%spread(key=Leto,value=value)
    
  })
  
  output$tabelapoletihUN2013 <- renderTable({
    
    validate(
      need(input$Obdobje[2] > 2012, 'Ce zelite prikazati statistiko programa UN2013, izberite ustrezno obdobje!')
    )
    
    pogoji=c("n","mean","sd","min","median","max")
    
    dff<-data%>%filter(between(Leto, input$Obdobje[1], input$Obdobje[2]) & Predmet=="UN2013")%>%
      group_by(Leto)%>%do(skim(.))%>%filter(var=="Ocena",stat %in% pogoji)%>%
      select(Leto,stat,value)%>%spread(key=Leto,value=value)
    
  })
})