library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",

  # Application title
  titlePanel("Simulacija ocene velja samo za SPROTNO delo v tekočem kvartalu!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Z drsnikom nastavite število točk v posamezni kategoriji!"),
      
      sliderInput("TV",
                  "Število točk pri vajah",
                  min = 0,
                  max = 70,
                  value = 50),
      
      sliderInput("TP",
                  "Število točk pri informacijski pismenosti",
                  min = 0,
                  max = 20,
                  value = 10),
      
      sliderInput("TK",
                  "Število točk pri obeh kolokvijih",
                  min = 0,
                  max = 42,
                  value = 21)
    ),
    
    # Show values
    mainPanel(
              tableOutput("values"),
              textOutput("ocena")
      )
    
  )
  

))