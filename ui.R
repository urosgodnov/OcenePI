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
          

          withSpinner(uiOutput("TV")),
          
          withSpinner(uiOutput("TP")),
          
          withSpinner(uiOutput("TK")),
          
          
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
        mainPanel(withSpinner(tableOutput("values")),
                  withSpinner(textOutput("ocena")))
        
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
      
    #Tukaj dodam nov fluidrow, ki bo vsebovala tabsete  
      fluidPage(
      
        tabsetPanel(
          
          tabPanel("Graf porazdelitve",
            fluid = TRUE,
        
             plotOutput('analiza')
      
    
          ), #tabpanel grafporazdelitve
          
          tabPanel("Osnovna statistika za celoten niz podatkov",
                   fluid = TRUE,
                   
                   tableOutput("tabelavse")
          
          
          ), #Osnovna statistika za celoten niz podatkov
          
          tabPanel("Grafi porazdelitve po letih in predmetih",
                   fluid = TRUE,
                   
                   withSpinner(plotOutput('poletih'))
                   
           
                   
                   
                   
          ),  #grafpoletih
           
          tabPanel("Statistika po letih in predmetih",
                   fluid = TRUE,
                   
                   
                  mainPanel(  
                  h4("VS2005"),  
                  withSpinner(tableOutput('tabelapoletihVS2005')),
                  h4("VS2013"), 
                  withSpinner(tableOutput('tabelapoletihVS2013')),
                  h4("UN2005"), 
                  withSpinner(tableOutput('tabelapoletihUN2005')),
                  h4("UN2013"), 
                  withSpinner(tableOutput('tabelapoletihUN2013'))
                   
                  )
                   
                   
                   
                   
                   
          )  #statistikapoletih
                   
        ) #tabsetpanel na statistiki ocen

      ) #FluidRow podseta
      
    ) #TabPanelStatistika ocen
    
    
    
  )#TabSetPanel 
  ))