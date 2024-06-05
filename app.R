source("setup.R")

ui = dashboardPage(
  dashboardHeader(title = "LENSS Graphs"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      
      
      ##### Input card #####
      column(
        width = 4,
        box(
          title = "Controls",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          sliderInput("input_date",
                      "Select Date:",
                      min = as.Date("2023-07-20"), # First available date
                      max = as.Date("2023-11-08"), # Last available date
                      value = as.Date("2023-07-20"),
                      timeFormat = "%Y-%m-%d"),
          checkboxInput("midCheck", "Show midnight line"),
          checkboxInput("sqmCheck", "Show maximum SQM reading"),
          checkboxInput("bortleCheck", "Show Bortle scale")
        )
      ),
      
      column(
        width = 8,
        
        
        ##### Graph card #####
        fluidRow(
          box(
            title = "Graph",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotOutput("result_plot")
          )
        ),
        
        
        ##### Moon/weather card #####
        fluidRow(
          box(
            title = "Moon Phase",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            textOutput("phaseEmoji")
          )
          
          
        )
      )
    )
  )
)

server = function(input, output, session) {
  
  output$result_plot = renderPlot({
    sqmVal = input$sqmCheck
    midVal = input$midCheck
    bortleVal = input$bortleCheck
    
    buildGraph(as.Date(input$input_date), midVal, sqmVal, bortleVal)
  })
  
  output$phaseEmoji = renderText({
    moon_phase(as.Date(input$input_date))
  })
  
}

shinyApp(ui = ui, server = server)