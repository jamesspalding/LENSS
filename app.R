source("setup.R")

ui = dashboardPage(
  dashboardHeader(title = "LENSS Graphs"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      
      ##### Left Column #####
      column(
        width = 4,
        
        ##### Input card #####
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
      
      ##### Right Column #####
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
  
  
  ##### plot #####
  output$result_plot = renderPlot({
    sqmVal = input$sqmCheck
    midVal = input$midCheck
    bortleVal = input$bortleCheck
    
    buildGraph(as.Date(input$input_date), midVal, sqmVal, bortleVal)
  })
  
  
  ##### phase emoji #####
  output$phaseEmoji = renderText({
    phaseDate = as.character(input$input_date)
      phaseY = as.numeric(strsplit(phaseDate,"-")[[1]][1])
      phaseM = as.numeric(strsplit(phaseDate,"-")[[1]][2])
      phaseD = as.numeric(strsplit(phaseDate,"-")[[1]][3])
    
    moon_emoji(
      moon_phase(phaseY, phaseM, phaseD)
    )
  })
  
}

shinyApp(ui = ui, server = server)