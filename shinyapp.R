
library(shiny)
library(base64enc)


gif_data <- base64enc::dataURI(file = "www/happy_birthday.gif", mime = "image/gif")


ui <- fluidPage(
  tags$head(
    tags$style(HTML("
 .centered {
 display: flex;
 flex-direction: column;
 align-items: center;
 justify-content: center;
 text-align: center;
 margin-top: 30px;
 }
 "))
  ),
  
  # Background music (autoplay may be blocked by browser)
  tags$audio(src = "maneskin.mp3", type = "audio/mp3", autoplay = NA, loop = NA),
  
  
  tags$script(HTML("
 document.addEventListener('DOMContentLoaded', function() {
 var button = document.getElementById('giftBtn');
 var audio = document.querySelector('audio');
 if (button && audio) {
 button.addEventListener('click', function() {
 audio.play();
 });
 }
 });
"))
  ,
  
  
  titlePanel("🎂 🎉"),
  
  div(class = "centered",
      tags$img(src = gif_data, height = "200px"),
      br(),
      actionButton("giftBtn", "🎁 Click for a Surprise Gift!"),
      br(), br(),
      textOutput("giftText")
  )
)

server <- function(input, output, session) {
  gifts <- c("🎈 A Bunch of Balloons!", 
             "🍰 A Delicious Cake!", 
             "🎧 A Playlist of Your Favorite Songs!", 
             "🧸 A Cuddly Teddy Bear!", 
             "📚 A Book You’ll Love!")
  
  observeEvent(input$giftBtn, {
    output$giftText <- renderText({
      sample(gifts, 1)
    })
  })
}

shinyApp(ui, server)
