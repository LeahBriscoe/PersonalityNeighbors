library(shiny)
library("vistime")
# See above for the definitions of ui and server
source("test.R")

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  img(src = "mind_heart.png", height = 72),
  titlePanel("Discov"),
  strong("Feeling bogged down by the monotonous life of quarantine? Need a pick me up?"),
  p("With <AllName> discover new hobbies "),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      div("Mental Health Routine", style = "color:red",a("More info.", 
                                             href = "http://google.com")),
      # Input: Slider for the number of bins ----
      selectInput("timekeeping", 
                  label = "Which describes you",
                  choices = list("I am often early.",
                                 "I am always on time.",
                                 "I am often running late."),
                  selected = "I am often early"),

      sliderInput(inputId = "loneliness",
                                label = "I feel lonely in life.",
                                min = 1,
                                max = 5,
                                value = c(1,5)),
    
                  
      br(),
      br(),
      div("Fitness Routines", style = "color:red",a("More info.",
                                              href = "http://google.com")),
      selectInput("routine_fitness",
                  label = "Choose a fitness routine",
                  choices = list("Yoga stretch","Eat a fruit"),
                  selected = "Yoga stretch"),
    ),
    #   actionButton("action", label = "Add Routine to Rotation"),
    #   br(),
    #   br(),
    #   div("Affirmation Routines", style = "color:red",a("More info.", 
    #                                                 href = "http://google.com")),
    #   sliderInput(inputId = "bins",
    #               label = "Frequency of reminder (every number of hours)",
    #               min = 1,
    #               max = 50,
    #               value = 30),
    #   actionButton("action", label = "Add Routine to Rotation")
    #   
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      #plotOutput(outputId = "distPlot"),
      textOutput(outputId = "mental_var"),
      textOutput(outputId = "mental_range"),
      textOutput(outputId = "num_blocks"),
      textOutput(outputId = "fitness_var")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$mental_var <- renderText({ 
    paste("You have selected this",input$routine_mental)
  })
  output$fitness_var <- renderText({ 
    paste("You have selected this",input$routine_fitness)
  })
  
  # output$mental_range <- renderText({ 
  #   pres <- data.frame(Position = rep(c(input$routine_mental, input$routine_fitness), each = 1),
  #                      Name = c("Mental Health", "Fitness"),
  #                      start = c("2020-01-01", "2020-01-01"),
  #                      end = c("2020-01-15", "2020-01-29"),
  #                      #start = c(as.character(input$mental_range[1]), as.character(input$mental_range[1])),
  #                      #end = c(as.character(input$mental_range[2]),as.character(input$mental_range[2])),
  #                      color = c('#cbb69d', '#603913'),
  #                      fontcolor = c("black", "white"))
  #   vistime(pres,
  #           col.event = "Position",
  #           col.group = "Name",
  #           title = "Routines")
  # })
  
  
}

shinyApp(ui = ui, server = server)