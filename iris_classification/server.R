#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
#list_libraries <- c("shiny", "dplyr", "caret", "gridExtra", "kernlab")
#for (package_name in list_libraries){
  
#  if(!require(package_name, character.only = TRUE) ){
    
#    install.packages(package_name, dependencies = TRUE)
#    library(package_name, character.only = TRUE)
#}
#}
library(shiny)
library(dplyr)
library(caret)
library(gridExtra)
library(kernlab)

# Define server logic required to draw a histogram
function(input, output, session) {

    model_svm <- readRDS("model_svm.rds")
    pre_obj_normalized <- readRDS("pre_obj_normalized.rds")
    
    output$iris_classification_plot <- renderPlot({

        sepal_width <- input$sepal_width
        sepal_length <- input$sepal_length
        petal_width <- input$petal_width
        petal_length <- input$petal_length
        
        data_validation <- data.frame(sepal_length, sepal_width, petal_length, petal_width)
        names(data_validation) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
        
        normalized_validation_data <- predict(pre_obj_normalized, data_validation)
        prepared_data_validation <- normalized_validation_data
        
        prediction_result <- predict(model_svm, prepared_data_validation, na.action = na.omit)
        
        output$prediction_result <- renderText( { paste("Prediction species:", prediction_result)} )
        output$prediction_data <- renderText( {paste("{ Sepal Length:", sepal_length, ", Sepal width:", sepal_width, ", Petal Length:", petal_length, ", Petal Width:", petal_width, "}")} )

        g1 <- ggplot(iris, aes(x=Sepal.Width, y=Sepal.Length, color=Species)) + 
              geom_point()+ 
              annotate("point", x = sepal_width, y = sepal_length, color = "yellow", size = 5)+
              labs(title = "Sepal size", subtitle = "")
        g2 <- ggplot(iris, aes(x=Petal.Width, y=Petal.Length, color=Species)) + 
              geom_point() + 
              annotate("point", x = petal_width, y = petal_length, color = "yellow", size = 5)+
              labs(title = "Petal size", subtitle = "")
        grid.arrange(g1, g2, nrow=2)
    })
}
