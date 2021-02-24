library(shiny)
library(devtools)
# chooseCRANmirror()
# install.packages(pkgs = "foreign",repos ="https://svn.r-project.org/R-packages/trunk/foreign/")
# options("repos" = c("CRAN" = "https://cran.rstudio.com", 
#                     "svn.r-project" = "https://svn.r-project.org/R-packages/trunk/foreign"))
# See above for the definitions of ui and server
#source("test.R")
source("process_user_input.R")

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  img(src = "mind_heart.png", height = 72),
  titlePanel("Discover your personality neighbors"),
  strong("Feeling bogged down by the monotonous life of quarantine? Need a pick me up?"),
  p("Discover new hobbies by learning from people who answer questions like you do.  "),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      # div("Mental Health Routine", style = "color:red",a("More info.", 
      #                                        href = "http://google.com")),
      # Input: Slider for the number of bins ----
      selectInput("onlychild", 
                  label = "Are you an only child?",
                  choices = list("no","yes"),
                  selected = "no"),
      
      selectInput("timekeeping", 
                  label = "Which describes your habit in timekeeping?",
                  choices = list("I am often early",
                                 "I am always on time",
                                 "I am often running late"),
                  selected = "I am often early"),
      sliderInput("dreams",
                  label = "Do you always good dreams ? (1 not at all, 5 always)",
                  min = 1,
                  max = 5,
                  value = 3),
      
      selectInput("smoking", 
                  label = "How often do you smoke?",
                  choices = list("current smoker" ,"former smoker", 
                                 "never smoked", "tried smoking"),
                  selected = "never smoked"),
      selectInput("edu", 
                  label = "What degree have you completed?",
                  choices = list("college/bachelor degree" ,"currently a primary school pupil", 
                                 "doctorate degree", "masters degree","primary school","secondary school"),
                  selected = "college/bachelor degree"),
     
      selectInput("alcohol", 
                  label = "How often do you drink?",
                  choices = list("drink a lot","never", "social drinker" ),
                  selected = "social drinker"),
      selectInput("internet_use", 
                  label = "How many hours a day do you use the internet?",
                  choices = list("few hours a day", "less than an hour a day","most of the day",
                      "no time at all" ),
                  selected = "few hours a day"),
      sliderInput("lonely",
                                label = "How lonely do you feel?",
                                min = 1,
                                max = 5,
                                value = 3),

      selectInput("lying", 
                  label = "How often do you lie?",
                  choices = list("everytime it suits me", "never","only to avoid hurting someone",
                          "sometimes" ),
                  selected = "everytime it suits me"),
      selectInput("handedness", 
                  label = "What is your dominant hand?",
                  choices = list("left handed", "right handed" ),
                  selected = "everytime it suits me")
      
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
      plotOutput(outputId = "plot_hobbies")
      #textOutput(outputId = "lonely_out")
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
  # output$lonely_out <- renderText({
  #   #paste("You have selected this",input$timekeeping)
  #   #print(paste("Dreams",input$dreams))
  #   process_input(input$lonely)
  # })
  # output$timekeeping_out <- renderText({
  #   #paste("You have selected this",input$timekeeping)
  #   print(paste("Dreams",input$dreams))
  #  result = get_recommendation(input$timekeeping,input$smoking,input$edu,input$onlychild,input$alcohol,
  #                  input$internet_use,input$lonely,input$dreams,input$lying,input$handedness)
  #  #result
  #   #process_input(input$dreams)
  # })
  output$plot_hobbies<- renderPlot({
    #paste("You have selected this",input$timekeeping)
    #print(paste("Dreams",input$dreams))
    get_recommendation(input$timekeeping,input$smoking,input$edu,input$onlychild,input$alcohol,
                                input$internet_use,input$lonely,input$dreams,input$lying,
                       input$handedness,"hobbies")
    #result
    #process_input(input$dreams)
  })
  # output$plot_music<- renderPlot({
  #   #paste("You have selected this",input$timekeeping)
  #   #print(paste("Dreams",input$dreams))
  #   get_recommendation(input$timekeeping,input$smoking,input$edu,input$onlychild,input$alcohol,
  #                      input$internet_use,input$lonely,input$dreams,input$lying,
  #                      input$handedness,"music")
  #   #result
  #   #process_input(input$dreams)
  # })



  
}

shinyApp(ui = ui, server = server)