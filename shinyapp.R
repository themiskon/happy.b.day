
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

 .centered-title {
 text-align: center;
 font-size: 2.5em;
 margin-top: 20px;
 
color: #ff4081;
font-weight: bold;
 text-shadow: 2px 2px #ffe6f0;

 }

.balloon, .heart {
 position: absolute;
 bottom: -100px;
 animation: float 10s infinite ease-in;
 font-size: 2em;
}
 
.heart {
 color: red;
 }


 @keyframes float {
 0% { transform: translateY(0); opacity: 1; }
 100% { transform: translateY(-120vh); opacity: 0; }
 }

 .balloon-container {
 position: fixed;
 width: 100%;
 height: 100%;
 overflow: hidden;
 z-index: -1;
}
 "))
  ),
  
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
 ")),
  
  div(class = "centered-title", h1("🎂 Dimitra, min skat-iara 🎉")),
  
  
  div(class = "balloon-container",
      # Balloons
      lapply(1:10, function(i) {
        tags$div(class = "balloon", style = paste0("left:", sample(0:100, 1), "%; animation-delay:", runif(1, 0, 5), "s;"),
                 "🎈")
      }),
      # Hearts
      lapply(1:10, function(i) {
        tags$div(class = "heart", style = paste0("left:", sample(0:100, 1), "%; animation-delay:", runif(1, 0, 5), "s;"),
                 "❤️")
      })
  )
  ,
  
  div(class = "centered",
      tags$img(src = gif_data, height = "200px"),
      br(),
      actionButton("giftBtn", "🎁 Click for a Surprise Gift!"),
      br(), br(),
      textOutput("giftText")
  )
)

server <- function(input, output, session) {
  gifts <- c("🏋️ A Set of Dumbbells!", 
             "💆️ A Full Body Massage!", 
             "🍽️ A Very Fancy Dinner!", 
             "🏄 An Extreme Sports Experience!", 
             "✈️ A Travel Adventure with a Friend!")
  
  observeEvent(input$giftBtn, {
    output$giftText <- renderText({
      sample(gifts, 1)
    })
  })
}

shinyApp(ui, server)
