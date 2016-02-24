source("helper.R")

shinyServer(function(input, output) {
  
    baseYear <- reactive({
        input$yearRange[1]
    })
    
    data <- reactive({
        #Set up parameters for the plot
        years <- input$yearRange
        baseYear <- years[1]
        finalYear <- years[2]
        migration <- gsub("Net Overseas Migration", "NOM", input$migration)
        genderNo <- input$gender
        plotAllYears <- input$firstLastYear
        
        # Filter data on year range
        abs <- abs %>% 
            filter(
                Time >= baseYear, Time <= finalYear,
                Fertility.Assumption == input$fertility, 
                Mortality.Assumption == input$mortality,
                Net.Overseas.Migration == migration
            )

        # Filter between years
        if (!plotAllYears) {
            abs <- abs %>% filter(Time %in% c(baseYear,finalYear))
        }
        
        
        # Shape data based on gender choice
        if (genderNo == 1) abs <- abs %>% filter(gender == "Males")
        else if (genderNo == 2) abs <- abs %>% filter(gender == "Females")
        else if (genderNo == 3) abs <- abs %>% select(-gender) %>% group_by(Time, Age) %>% summarise(count = sum(count))
        
        #remove unused columns
        abs <- select(abs, Time, Age, count)
        
        #return
        abs
    })    
    
    data2 <- reactive({
        data <- data()
        baseYear <- baseYear()
        absBaseYear <- data %>% filter(Time == baseYear) %>% rename(countBase = count)
        absBaseYear$Time <- NULL
        data <- left_join(data, absBaseYear)
        data$delta <- data$count - data$countBase
        
        #return
        data
    })
    
    
  output$totals <- renderPlot({

    p <- data() %>% 
        ggplot() + 
        labs(y = "Number of people") +
        geom_point(aes(y = count, x = Age, color = Time)) +
        scale_x_continuous(breaks = seq(0, 100, 10)) +
        scale_y_continuous(labels = comma)
    
    print(p)
    
    # Clean up abs
    # abs <- abs %>% select(-countBase, -delta)
    
  })

    
  output$absChange <- renderPlot({
      p <- data2() %>% 
          ggplot() + 
          labs(y = I(paste("Change in number of people relative to ",baseYear()))) +
          geom_point(aes(y = delta, x = Age, color = Time)) +
          scale_x_continuous(breaks = seq(0, 100, 10)) +
          scale_y_continuous(labels = comma)
      print(p)
  })
  
  
  output$relChange <- renderPlot({
      # calculate delta
      data3 <- data2()
      data3$rel <- 100*data3$delta/data3$count
      
      p <- data3 %>% 
          ggplot() + 
          labs(y = I(paste("% Change in number of people relative to ",baseYear()))) +
          geom_point(aes(y = rel, x = Age, color = Time)) +
          scale_x_continuous(breaks = seq(0, 100, 10)) +
          scale_y_continuous(labels = comma)
      print(p)
      
  })
    
})