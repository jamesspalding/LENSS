source("functions.R") #already sources setup.R, so no need to load again.


ui <- fluidPage(
    titlePanel("LENSS Graphs"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("input_date",
                        "Select Date:",
                        min = as.Date("2023-07-20"),
                        max = as.Date("2023-11-08"),
                        value = as.Date("2023-07-20"),
                        timeFormat = "%Y-%m-%d"),
            
            checkboxInput("checkbox", "Show maximum SQM reading")
        ),
        
        mainPanel(
             plotOutput("result_plot")
        )
        
    )
)


server = function(input, output, session) {
  output$result_plot = renderPlot({
    if (input$checkbox) {
      result_plot = SQMGraph(as.Date(input$input_date))
      print(result_plot)
    }else{
      result_plot = dateGraph(as.Date(input$input_date))
      print(result_plot)
    }
  })
}


shinyApp(ui = ui, server = server)