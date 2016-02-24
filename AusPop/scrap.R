output$totalsText <- renderText({
    print("
          Each dot represents the number of Australians in a single age group in a given year.  
          ")
})


output$absChangeText <- renderText({
    print("
          Each dot represents the change in the number of Australians relative to the base year.  
          ")
})

output$relChangeText <- renderText({
    print("
          Each dot represents the percentage change in the number of Australians relative to the base year.  
          ")
})


