shinyUI(fluidPage(
  
  titlePanel("Australian population projections"),
  p("Source: Australian Bureau of Statistics ",
  a("Population Projections, Australia, 2012-2101",  
    href="http://stat.abs.gov.au/Index.aspx?DatasetCode=POP_PROJ_2011"
    )
  ),
  
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
      checkboxInput(inputId = "genderSplit",
                    label = "Show by gender",
                    value = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Totals", plotOutput("totals")) 
                  #tabPanel("Absolute change", verbatimTextOutput("absChange")), 
                  #tabPanel("Relative change", tableOutput("relChange"))
    )
  )

))