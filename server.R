
#server
server <- function(input,output,session){
  
  output$results_lm <- renderPrint({
    date <- ymd(input$date)
    ds1 <- total %>% filter(Travel.Date == date) %>% select(-Travel.Date, -bookings)
    
    lm_prediction <- predict(lm_total, data.frame(ds1))
    lm_prediction <- round(lm_prediction*10)
    
    cat(paste('$',lm_prediction))
  })
  
  output$results_rf <- renderPrint({
    date <- ymd(input$date)
    ds1 <- total %>% filter(Travel.Date == date) %>% select(-Travel.Date, -bookings)
    
    
    rf_prediction <- predictions(predict(rf, data.frame(ds1)))
    rf_prediction <- round(rf_prediction*10)
    
    
    cat(paste('$',rf_prediction))
  })
  
  # Fill in the spot we created for a plot
  output$icg.plot1 <- renderPlot({
    date <- ymd(input$date)
    ds1 <- total %>% filter(Travel.Date == date) %>% select(-Travel.Date, -bookings)
    
    df <- data.frame(Factors = c('Seasonal','Weather','External Source') , increase.rate  = c(
      ((predict(lm_seasonal,ds1) - mean(total$bookings, na.rm =T) )/mean(total$bookings, na.rm =T))*100,
      ((predict(lm_weather,ds1) - mean(total$bookings, na.rm =T) )/mean(total$bookings, na.rm =T))*100,
      as.numeric(((airport[month(date),'bookings'] - mean(total$bookings, na.rm =T) )/mean(total$bookings, na.rm =T))*100)
    ))
      
    df %>% ggplot(aes(x=Factors, y=increase.rate))+
      geom_bar(stat="identity",aes(fill=Factors), width=.5) + coord_flip()+ ylim(-200,200) +
      xlab("Factors") + ylab("Passenger Increase Rate(%)") + scale_fill_discrete(name = "Factors")
    
  })
  
}
 
shinyApp(ui, server) 
  
  
  
