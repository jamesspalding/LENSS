# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
rm(list = ls())
source("setup.R")



##### Inupt #####
ui <- dashboardPage(
  dashboardHeader(title = "LENSS Graphs"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(

      #Left Column
      column(
        width = 4,

        #Input card
        box(
          title = "Controls",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          
          
          sliderInput("sliderDate",
                      "Select Date:",
                      min = FIRSTDAY,
                      max = LASTDAY,
                      value = as.Date("2023-07-20"),
                      timeFormat = "%Y-%m-%d"),
          
          
          checkboxInput("midCheck", "Show midnight line"),
          checkboxInput("sqmCheck", "Show maximum SQM reading"),
          checkboxInput("bortleCheck", "Show Bortle scale", value = T),
          checkboxInput("moonCheck", "Display moon phase", value = T),
          
          
          actionButton("leftArrow", "<"),          
          actionButton("rightArrow", ">")
          
        )
      ),

      #Right Column
      column(
        width = 8,


        #Graph card
        fluidRow(
          box(
            title = "Graph",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotOutput("result_plot")
          )
        )
      )
      
      
    )
  )
)





##### Output #####
server <- function(input, output, session) {

  input_date = reactiveVal(as.Date("2023-07-20"))
  
  #Slider
  observeEvent(input$sliderDate, {
    input_date(as.Date(input$sliderDate))
  })

  
  #Arrows
    observeEvent(input$leftArrow, {
    if(input_date() != FIRSTDAY){
      input_date(input_date() - 1)
    } else {
      input_date(input_date())
    }
  })
    
  observeEvent(input$rightArrow, {
    if(input_date() != LASTDAY){
      input_date(input_date() + 1)
    } else {
      input_date(input_date())
    }
  })
  
  
  #Plot
  output$result_plot = renderPlot({
    buildGraph(input_date(), 
               input$midCheck,
               input$sqmCheck,
               input$bortleCheck,
               input$moonCheck)
  })

}

options(shiny.port = 1897)
shinyApp(ui = ui, server = server)
