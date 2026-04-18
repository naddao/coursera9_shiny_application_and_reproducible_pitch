#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Iris Species Classification"),
    
    h4("This shiny app for species classification from dataset 'iris'. Using value of 'sepal width', 'sepal height', 'petal_width', 'petal_height' as information for prediction of species('setosa', 'versicolor', 'virginica')."), 
    h5("Please adjust slider below for the size of Sepal size and Petal size for prediction:-"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("sepal_width",
                        "Sepal Width:",
                        min = 2.0,
                        max = 4.4,
                        value = 3.1),
            sliderInput("sepal_length",
                        "Sepal Length:",
                        min = 4.3,
                        max = 7.9,
                        value = 4.9),
            sliderInput("petal_width",
                        "Petal Width:",
                        min = 0.1,
                        max = 2.5,
                        value = 0.3),
            sliderInput("petal_length",
                        "Petal Length:",
                        min = 1.0,
                        max = 6.9,
                        value = 1.5),
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
          
            h6("Yellow dot in plot below show the selected value from slider of Sepal size and Petal size. Adjust slider on the left for different position and different species prediction result."),
            plotOutput("iris_classification_plot"),
            
            textOutput("prediction_data"),
            
            h4("Species prediction result:"),
            verbatimTextOutput("prediction_result")
        )
    )
)
