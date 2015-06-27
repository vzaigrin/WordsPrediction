library(shiny)

source("functions.R")

shinyServer(function(input, output, session) {
    
  p <- reactiveValues(data = NULL)
  n <- reactive({input$n})
  auto <- reactive({input$auto})
  
  observeEvent(input$submit, {
       if( input$words != "" )  p$data<-pstring( input$words, n() )   
       if( auto() )  updateTextInput(session,"words","Input:",value=paste(isolate(input$words),p$data[1],sep=" "))
  })
    
#  output$text <- renderText({
#      if( auto() )  updateTextInput(session,"words","Input:",value=paste(isolate(input$words),p$data[1],sep=" "))
#      p$data
#  })
  
  output$prediction <- renderUI({
      lapply(1:n(), function(i) actionButton( paste("p",i,".button",sep=""), p$data[i] ))
  })

  
  observeEvent(input$clear, {
      updateTextInput(session,"words","Input:",value="")
  })
  
  observeEvent(input$p1.button, {
      updateTextInput(session,"words","Input:",value=paste(input$words,p$data[1],sep=" "))
  })

  observeEvent(input$p2.button, {
      updateTextInput(session,"words","Input:",value=paste(input$words,p$data[2],sep=" "))
  })
  observeEvent(input$p3.button, {
      updateTextInput(session,"words","Input:",value=paste(input$words,p$data[3],sep=" "))
  })
  observeEvent(input$p4.button, {
      updateTextInput(session,"words","Input:",value=paste(input$words,p$data[4],sep=" "))
  })
  observeEvent(input$p5.button, {
      updateTextInput(session,"words","Input:",value=paste(input$words,p$data[5],sep=" "))
  })
})

