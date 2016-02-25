shinyUI(fluidPage(
  
  titlePanel("Australian population projections"),
  em("Vlad Fridkin"), p(),
  p(strong("Source:"), "Australian Bureau of Statistics ",
  a("Population Projections, Australia, 2012-2022",  
    href="http://stat.abs.gov.au/Index.aspx?DatasetCode=POP_PROJ_2011"
    )
  ),
  p("Visualise population projections from ABS (Australian Bureau of Statistics),
    alter assumptions, choose year ranges and see the effects on predicted populations.  
    It's common knowledge in Australia that the proportion of elderly people is increasing.
    Assuming", em("zero net migration"), "this is clearly visible in the", em('Changes'), "plots below.
    Other interesting effects to discover include how migration assumptions 
    have a profound effect on younger age groups.
    "),
  p("Uses of this visualisation include informing business strategy that targets age groups. 
    With", em('medium'), "assumptions, the", em('Percentage change'), "chart indicates that the 
    20 year old group changes about 5% over 10 years compared to a growth of over 20% for the 35 year olds."),
  p(strong("Instructions:"), "Choose the year range with the slider.  By default, only values for the first and last year are shown.
    Change this by checking", em("Plot all years."), "Alter assumptions using the drop down boxes.  You can focus on genders seperately
    by using the", em("Gender"), "radio buttons.  To view different plots, click on the tabs above the chart area."),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange", 
                  label = h4("Year range"), 
                  min = 2012, 
                  max = 2022, 
                  value = c(2012,2022),
                  sep = '',
                  step = 1,
                  ticks = FALSE
      ),
      checkboxInput("firstLastYear", label = "Plot all years", value = FALSE),
      br(),
      h4("Assumptions"),
      
      selectInput(inputId = "fertility",
                  label = NULL,
                  choices = c("High fertility", "Medium fertility", "Low fertility"),
                  selected = "Medium fertility"),
      selectInput(inputId = "mortality",
                  label = NULL,
                  choices = c("High life expectancy", "Medium life expectancy"),
                  selected = "Medium life expectancy"),
      selectInput(inputId = "migration",
                  label = NULL,
                  choices = c("High Net Overseas Migration", "Medium Net Overseas Migration", "Low Net Overseas Migration", "Zero Net Overseas Migration"),
                  selected = "Medium Net Overseas Migration"),
      radioButtons("gender", choices = list("female" = 1, "male" = 2, "both" = 3),
                    label = h4("Gender"),
                    selected = 3)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Totals", plotOutput("totals")),
                  tabPanel("Changes", plotOutput("absChange")), 
                  tabPanel("Percentage changes", plotOutput("relChange"))
      )
    )
  ),
  
  p(strong("Totals:"), "each dot represents the number of people at the same age in a given year.  
    When multiple years are shown, these dots trace out lines.  These lines represent the same group of people
    getting older through time.  With zero migration, the younger groups move horizontally as expected, i.e.
    new people don't appear out of thin air.  The older groups slope downwards as the death rate increases.
    When it is above the slope of differences between successive age groups, this indicates an 
    increasing life expectancy."),
  p(strong("Changes:"), "each dot represents the change in the number of people at the same age in a given year
    from the base year.  The base year is the first year chosen in the year range slider.  
    When multiple years are shown, with some effort, one can make out fluctuations.
    With zero migration, the bias towards an increase in the aging population is clearly visible."),
  p(strong("Percentage changes:"), "is the percentage change relative to the base year.  
    Small changes may show large effects if they are large relative to the base year.")
  
  

  
  
))