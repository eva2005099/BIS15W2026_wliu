library(tidyverse)
library(janitor)
library(shiny)
library(shinydashboard)
library(RColorBrewer)


ui <- dashboardPage(
  dashboardHeader(title="Elephant Biometrics"),
  dashboardSidebar(selectInput("y",
                               "Select Your Variable",
                               choices=c("age",
                                         "height"),
                               selected="age")),
  dashboardBody(
    plotOutput("plot",width="500px",height="400px")
  )
  
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    elephants %>% 
      filter(sex!="NA") %>% 
      ggplot(aes(x=sex,
                 y=.data[[input$y]],
                 fill=sex))+
      geom_boxplot()+
      scale_fill_brewer(palette="Accent")+
      labs(title="Age & Height Analysis by Sex",x="Sex")
  })
  
}

shinyApp(ui, server)
