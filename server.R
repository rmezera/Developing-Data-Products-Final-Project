#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$MarketSharePlot <- renderPlot({
    
    # generate market share based on input$Price, input$Count, input$Color and
    # input$Quality from ui.R.  This uses a regression model that I basically
    # made up for this example
    
    #Set up data for multiplying by coefficients
    price <- input$Price
    count <- input$Count
    color <- matrix(data=0, nrow=1,ncol=4)
    if(input$Color=="Blue") color[1,1] <- 1
    if(input$Color=="Red") color[1,2] <- 1
    if(input$Color=="Green") color[1,3] <- 1
    if(input$Color=="Purple") color[1,4] <- 1
    quality <- matrix(data=0,nrow=1,ncol=3)
    if(input$Quality=="Good") quality[1,1] <- 1
    if(input$Quality=="Better") quality[1,2] <- 1
    if(input$Quality=="Best") quality[1,3] <- 1
    
    values <- cbind(1,price,count,color,quality)
    #Coefficients
    mktsharecoefs <- c(10,-3,2,12,8,15,6,0,5,10)
    #Create Market Share numbers and name them
    marketshare<-values%*%mktsharecoefs
    marketshare2 <-cbind(marketshare,100-marketshare)
    names(marketshare2)<-c("Product Share", "Other Products Share")
    
    # draw the bars indicating shares for our product and other products
    barplot(marketshare2,names.arg=c("Our Product", "All Other Products"),main="Market Share of your Product")
    output$marketshare <- renderText(marketshare2[1])
  })

})
