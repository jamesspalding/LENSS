source("setup.R")
source("buildGraph.R")


ui = fluidPage(
       titlePanel("LENSS Graphs"),
       sidebarLayout(
          sidebarPanel(
              sliderInput("input_date",
                          "Select Date:",
                          min = as.Date("2023-07-20"), #First available date
                          max = as.Date("2023-11-08"), #Last available date
                          value = as.Date("2023-07-20"),
                          timeFormat = "%Y-%m-%d"),
              
              checkboxInput("midCheck", "Show midnight line"),
              checkboxInput("sqmCheck", "Show maximum SQM reading"),
              checkboxInput("bortleCheck", "Show Bortle scale")
              
          ),
          
          mainPanel(
               plotOutput("result_plot")
          )
          
       )
     )


server = function(input, output, session) {
  output$result_plot = renderPlot({
    
    sqmVal = input$sqmCheck
    midVal = input$midCheck
    bortleVal = input$bortleCheck
    
    print(buildGraph(as.Date(input$input_date),
                     midVal,
                     sqmVal,
                     bortleVal))
  })
}


shinyApp(ui = ui, server = server)