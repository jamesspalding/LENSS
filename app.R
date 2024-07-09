# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only
rm(list = ls())
minInterval <- 15 #manually set in intervals of 5
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
                      value = as.Date(FIRSTDAY),
                      timeFormat = "%Y-%m-%d"),


          actionButton("leftArrow", "<"),
          actionButton("rightArrow", ">"),


          div(tags$label("Graph Options"),
              checkboxInput("midCheck", "Display midnight line", value = TRUE),
              checkboxInput("moonCheck", "Display moon phase", value = TRUE),
              checkboxInput("sqmCheck", "Display maximum SQM reading"),


              radioButtons("selection", label = "Overlays",
                           choices = list("Bortle scale" = "bortle",
                                          "Cloud cover" = "cloud",
                                          "None" = "noselection"),
                           selected = "noselection")
          )


        )
      ),

      #Right Column
      column(
        width = 8,


        #Graph card
        fluidRow(
          box(title = "Graph",
              status = "primary",
              solidHeader = TRUE,
              width = 12,
              plotOutput("result_plot"))
        )

      )

    ),
    tags$footer(
      "under agpl 3.0 license; view source",
      tags$a(
        href = "https://github.com/jamesspalding/LENSS",
        "here",
        target = "_blank"),
      style = "text-align: center;")
  )
)





##### Output #####
server <- function(input, output, session) {

  input_date <- reactiveVal(as.Date(FIRSTDAY))

  bortleCheck <- reactive({input$selection == "bortle"})

  cloudCheck <- reactive({input$selection == "cloud"})


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
  output$result_plot <- renderPlot({
    suppressWarnings({
      buildGraph(input_date(),
                 midLine = input$midCheck,
                 sqm = input$sqmCheck,
                 bortle = bortleCheck(),
                 phase = input$moonCheck,
                 cloud = cloudCheck())
    })
  })

}

options(shiny.port = 1897, shiny.host = "0.0.0.0")
shinyApp(ui = ui, server = server)
