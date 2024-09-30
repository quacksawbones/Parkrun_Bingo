#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

mypackages <- c("shiny", "rvest", "dplyr")
checkpkg <- mypackages[!(mypackages %in% installed.packages()[,"Package"])]
if(length(checkpkg)) install.packages(checkpkg, dependencies = TRUE)
                       

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Welcome to ParkRun Bingo"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(position = "left",
        sidebarPanel(
          p("Enter your ParkRun ID (just the number) below to see if you've got a Parkrun Bingo!"),
          textInput(
            "RunnerId",
            label="ParkRun ID",
          ),
          submitButton("Submit", icon("user"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("bingoPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$bingoPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        test_times_set <- sample(c(0:59), sample(c(5:200),1),replace = T)
        bins <- 60

        # draw the histogram with the specified number of bins
        hist(test_times_set, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
