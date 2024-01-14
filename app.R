source("functions.R") #already sources setup.R, so no need to load again.

ui = fluidPage(
  titlePanel("LENSS Graphs"),
  
  sidebarLayout(
    sidebarPanel(
      dateInput("input_date", "Enter a date between 7/19/23-11/8/23:"),
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

shinyApp(ui, server)

