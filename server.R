library(shiny)
library(ggplot2)
#
#  Load source datasets
#
subsetData <- read.table(file = "data/subsetData.txt",sep = ",", header = TRUE, stringsAsFactors = FALSE, colClasses = c("character","character","character","character","numeric","character","numeric","character")) 
subsetData$county <- factor(subsetData$county)

# Define server logic 
shinyServer(function(input, output) 
{
  output$about <- renderText({paste("This app allows you to select counties and display 
                                    Emissions totals for motor vehicles.
                                    Simply click in the counties list to add or delete items, and the plot will update
                                    to reflect your selection.
                                    To add a county, select an entry in the drop-down list.
                                    To delete a county, select it (it will turn blue) and then use the delete key.")})
  
  output$panelPlot <- renderPlot({
    validate(
      need(input$counties, "Please select at least one county")
    )
    
    fipsData <- subset( subsetData, fips %in% input$counties, fips:county )
    #
    #  Aggregate by year and county
    #
    aggdata <- aggregate(x=fipsData["Emissions"],by=list(Year=fipsData$year,City=fipsData$county),FUN=sum)
    
    p<-ggplot(aggdata,aes(Year,Emissions)) + geom_line()
    p<-p + labs(title=expression(paste("Total ", PM[2.5], " Emissions For Motor Vehicles by Year")))
    p + facet_grid(City ~ ., scales = "free")
  })
  
})