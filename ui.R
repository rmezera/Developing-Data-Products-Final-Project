#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Estimating Market Share by Attribute levels"),
  
  # Sidebar with a slider input for inputing Price
  sidebarLayout(
 
    # Sidebar with a slider input for inputing Price & Count and a select input
    # for color and quality
      sidebarPanel(
        em("This Shiny Application takes inputs on different attributes of a product:"),
        em("Price, Count, Color and Quality. "),
        em("Then, those inputs are multiplied by a set of coefficients to get to Market Share. "),
        em("Finally, the market share values are displayed in the graph to the right. "),
        em("See if you can figure out which prices, counts, colors and quality levels are the best."),
        
        sliderInput("Price",
                   "Price:",
                   min = 1.00,
                   max = 4.00,
                   value = 2.50,step=0.10),
       sliderInput("Count",
                   "Number of items in package:",
                   min = 1,
                   max = 10,
                   value = 3,step=1),
       
       selectInput(inputId = "Color",
                   label = "What Color is your product:",
                   choices = c("Blue", "Red", "Green", "Purple"),
                   selected = "Blue"),
       selectInput(inputId = "Quality",
                   label = "Select the quality of your product:",
                   choices = c("Good", "Better", "Best"),
                   selected = "Good")  
    ),
    # Show a plot of the generated distribution
       mainPanel(
         h3("The Plot Showing Market Share"),
         plotOutput("MarketSharePlot"),
         "Estimated Market Share is:", 
         textOutput("marketshare")
    )
  )
))
