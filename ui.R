library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
                  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: purple}")),
  # Application title
  titlePanel("Torej, koliko bo moja ocena pri predmetu Poslovna informatika?
             Simulacija velja samo za SPROTNO delo!"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("Z drsnikom nastavite število točk pri posamezni kategoriji!"),
      
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
    mainPanel(h2("Sumulacija ocene"),
              tableOutput("values"),
              textOutput("ocena")
      # 
      # mainPanel(
      #   tableOutput("values")
      )
    
  )
  

))