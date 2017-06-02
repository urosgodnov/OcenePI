library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
shinyUI(fluidPage(#theme = "bootstrap.css",
                  
                  

  tabsetPanel(
    tabPanel(
      "Simulacija ocene",
      fluid = TRUE,
      
      
      titlePanel("Simulacija ocene velja samo za SPROTNO delo v tekočem kvartalu!"),
      
      # Sidebar with a slider input for the number of bins
      sidebarLayout(
        sidebarPanel(
          helpText("Z drsnikom nastavite število točk v posamezni kategoriji!"),
          

          uiOutput("TV"),
          
          uiOutput("TP"),
          
          uiOutput("TK"),
          
          
          sliderInput(
            "animation",
            "Avtomatska simulacija",
            1,
            10,
            1,
            step = 1,
            animate = animationOptions(interval = 3000, loop = F)
          ),
          p(
            "V primeru lenobe lahko kliknete gumb play in vam bo program sam premaknil drsnike 10x! :)"
          )
        ),
        
        
        # Show values
        mainPanel(tableOutput("values"),
                  textOutput("ocena"))
        
      ),
      
      fluidRow(tabBox(
        tabPanel(
          "Tocke vaje",
          numericInput("mTV", label = "Max tocke pri vajah",
                       value = 70)
        ),
        tabPanel(
          "Tocke IP",
          numericInput("mIP", label = "Max tocke pri IP",
                       value = 20)
        ),
        tabPanel(
          "Tocke kolokvijev",
          numericInput("mKO", label = "Max tocke pri obeh kolokvijih",
                       value = 42)
        )
      ))
      
    ), #TabPanelSimulacijaOcene
    
    
    tabPanel(
      "Statistika ocen",
      fluid = TRUE,
      
      fluidRow(
        
        column(4,offset = 2,
               
               sliderInput("Obdobje",
                           "Izberite obdobje",
                           min=2006,
                           max=2016,
                           value = c(2009,2013),
                           sep = ""
               )
               
               
        ) #column 
        
        
        
        
      ), #fluidrow
      h3(textOutput("naslov")),
      
      hr(),
      
      plotOutput('analiza')
      
    
      

      
      
    ) #TabPanelStatistika ocen
    
    
    
  )#TabSetPanel 
  ))