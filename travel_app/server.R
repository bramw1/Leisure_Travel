
function(input, output) {
  dest_by_month <- reactive({
    topcountries <<- travel %>%
    filter(arrival_date_month == input$arrival_date_month) %>%
    count(country) %>% arrange(desc(n)) 
    
    country_topten <<- topcountries[1:10,]
    country_topten <<- country_topten[!grepl("NULL", country_topten$country),]
    
    country_topten <<- as.vector(country_topten[,1]) 
    new_travel <<- travel %>% filter(arrival_date_month == input$arrival_date_month) %>%
    filter(country %in% country_topten) 
  })
  
  avg_lead <- reactive({
    travel %>% filter(arrival_date_month == input$arrival_date_month)
  })
  
  
  output$count <- renderPlot(
    dest_by_month() %>%
      ggplot(., aes(x = stays_in_week_nights)) + 
      geom_histogram(aes(fill = country), binwidth = 0.5, position = position_stack(reverse=TRUE)) +
      theme_gdocs() + scale_fill_gdocs() + scale_x_continuous(limits = c(0, 15)) +
      ggtitle('Top destinations by stay duration') + xlab('Stay length (weekday nights)') +
      ylab('# of Bookings') + labs(fill = "Country") + theme(plot.title = element_text(hjust = 0.5)) +
      guides(fill = guide_legend(reverse=TRUE))
  )
  
  
  output$lead <- renderPlot(
    avg_lead() %>%
      ggplot(., aes(x = arrival_date_month, y = lead_time)) + 
      geom_boxplot() + ggtitle('Advance Booking for Top Destinations') +
      ylab('Lead time (days)') + 
      theme(axis.text.x = element_text(size = 12), axis.title.x = element_blank(), plot.title = element_text(hjust = 0.5), panel.background = element_rect(fill = 'white', color = 'black'), axis.line = element_line(colour = 'black'))
  )
  
  
  
}