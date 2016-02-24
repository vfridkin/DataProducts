shinyUI(fluidPage(
  
  titlePanel("Australian population projections"),
  em("Vlad Fridkin"), p(),
  p(strong("Source:"), "Australian Bureau of Statistics ",
  a("Population Projections, Australia, 2012-2022",  
    href="http://stat.abs.gov.au/Index.aspx?DatasetCode=POP_PROJ_2011"
    )
  ),
  p("Here you can visualise the population projections from ABS (Australian Bureau of Statistics),
    alter assumptions, choose year ranges and see the effects on predicted populations.  
    It's common knowledge in Australia that the proportion of elderly people is increasing.
    This effect is easily seen by viewing the", em('change'), "plots.
    However there are other interesting effects to discover too, such as how migration assumptions 
    have a profound effect on the demographics of younger age groups.
    "),
  p("One of the uses of this visualisation is for developing business strategy for industries that depend on 
    demographics.  For example, with default", em('medium'), "assumptions, one can see in the", em('Percentage change'), "chart that the the 
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
                  tabPanel("Totals by age", plotOutput("totals")),
                  tabPanel("Change", plotOutput("absChange")), 
                  tabPanel("Percentage change", plotOutput("relChange"))
      )
    )
  )
))