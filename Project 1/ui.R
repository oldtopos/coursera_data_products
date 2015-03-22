library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data Products Project"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("counties", 
                  "Counties:", 
                  c( "Kings County (Brooklyn)" = "36047", 
                     "Los Angeles County" = "06037",
                     "Cook County (Chicago)" = "17031",
                     "Harris County (Houston)" = "48201", 
                     "Maricopa County (Phoenix)" = "04013",
                     "San Diego County" = "06073",
                     "Orange County" = "06059",
                     "Miamai-Dade County" = "12086",
                     "Dallas County" = "48113",
                     "Queens County" = "36081" ), 
                  selected = c( "06037", "17031" ), 
                  multiple = TRUE )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("panelPlot")),
        tabPanel("About", verbatimTextOutput("about"))
      )
    )
  )
))



