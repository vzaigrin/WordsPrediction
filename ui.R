library(shiny)

shinyUI(fluidPage(

  titlePanel("Text prediction"),

  br(),
  p("This application try to predict next word in your text input."),
  p("Select the number of variants of word to predict, enter your text and press the Submit button."),
  p("You will see from one to five predicted words. Pressing the button with predicted word, you can add it to your text."),
  p("Check 'Auto insert' to automatically insert first prediction into your text."),
  p("Press the Clear button to clear the input field."),
  br(),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Enter some words for prediction."),
      textInput("words","Input:",value=""),
      actionButton("submit", label = "Submit"),
      sliderInput("n", "Number of words in prediction:", min = 1, max = 5, value = 3),
      checkboxInput("auto", label = "Auto insert", value = FALSE),
      actionButton("clear","Clear input")
    ),

    mainPanel(
      h3("Prediction:"),
#      textOutput("text"),
#      br(),
      uiOutput("prediction")
    )
  )
))
