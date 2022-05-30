library(shiny)

html_result_table <- '<div class="result_table">_html</div>'
html_result <- '<div class="result">
            <div class="left_div">
                <div class="left_top">
                    <ul class="ul_label">
                        <li id="fastest">Fastest</li>
                        <li id="cheapest">Cheapest</li>
                    </ul>
                </div>
                <div class="left_middle">
                    <ul class="ul_data">
                        <li id="image">
                            <img id="airasia" src="data:image/png;base64,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">
                        </li>
                        <li id="time">
                            _time
                        </li>
                        <li id="period">
                            _period
                        </li>
                    </ul>
                </div>
                <div class="left_bottom">
                    _location
                </div>
            </div>
            <div class="right_div">
                <p>_price<p>
                <a href="_airline_website" target="_blank">
                    <button>
                        Buy
                    </button>
                </a>
            </div>
        </div>'
Efile <- "D:\\R language\\Datascience\\R\\assignment\\economy.csv"

Bfile <- "D:\\R language\\Datascience\\R\\assignment\\business.csv"

Bdata <- read.csv(Bfile)

Edata <- read.csv(Efile)

Bdata$price <- gsub(',', '', Bdata$price)
Edata$price <- gsub(',', '', Edata$price)
colnames(Edata)[1] <- 'date'
colnames(Bdata)[1] <- 'date'
min <- min(strtoi(Edata$price))
max <- max(strtoi(Bdata$price))



total_origin <- unique(Edata$from)
total_destination <- unique(Edata$to)
total_airline <- unique(Edata$airline)

ui <- fluidPage(
  # includeCSS("https://raw.githubusercontent.com/PuaZhiXian/doge_webapplication/main/css_file/login_page_css.css"),
  
  includeCSS("D:/R language/Datascience/R/assignment/temp.css"),
  tabsetPanel(
    tabPanel(
      "Main Page ",
      tags$div(
        class = "container",
        HTML(
          '<video src = "https://video.wixstatic.com/video/11062b_83535061d55d4d798b215a143f3cc140/1080p/mp4/file.mp4"
              type = "video/mp4" width = "100%""
              autoplay muted loop></video>'
        ),
        div(
          class = 'input_bar',
          div(
            class = 'a',
            selectInput(
              inputId = "origin",
              label = "choose a location",
              choices = total_origin
            ),
            selectInput(
              inputId = 'destination',
              label = "choose a location",
              choices = total_destination
            ),
            dateInput(
              inputId = 'des_date',
              label = "Date:",
              format = "dd/mm/yyyy"
            )
          ),
          fluidRow(
            column(
              4,
              selectInput(
                inputId = 'way',
                label = "",
                choices = c('one-way', 'two-way'),
                width = "120px"
              ),
            ),
            column(
              4,
              selectInput(
                inputId = "ppl",
                label = "",
                choices = c('adult', 'children'),
                width = "120px"
              ),
            ),
            column(
              4,
              selectInput(
                inputId = 'type',
                label = "",
                choices = c('economy', 'business'),
                width = "120px"
              ),
            ),
            
          ),
        ),
      ),
      fluidRow(
        column(
          3,
          checkboxGroupInput(
            inputId = 'airline',
            label = "choose airline",
            choiceNames = total_airline,
            choiceValues = total_airline
          )
        ),
        column(
          3,
          sliderInput(
            inputId = 'range_price',
            label = 'Range Price',
            value = c(min, max),
            min = min,
            max = max,
            dragRange = TRUE
          )
        ),
        column(
          3,
          selectInput(
            inputId = 'sort_para',
            label = '',
            choices = c('Price', 'Time taken', 'Departure time', 'Arrival time'),
            width = '150px'
          )
        ),
        
        column(3, actionButton(
          inputId = 'sort',
          label = "sort",
          width = '100px'
        ))
      ),
      uiOutput("below_table")
    ),
    tabPanel("tab 2", "contents"),
    tabPanel("tab 3", "contents")
  )
)

server <- function(input, output) {
  observeEvent(input$sort,  {
    output$below_table <- renderUI({
      origin <- input$origin
      destination <- input$destination
      des_date <- input$des_date
      way <- input$way
      ppl <- input$ppl
      type <- input$type
      airline <- input$airline
      sort_para <- input$sort_para
      range_price <-  input$range_price
      temp_dataset <- NULL
      row <- 0
      if (type == 'economy') {
        temp_dataset <- Edata[which(
          Edata$from == origin &
            Edata$to == destination &
            Edata$date == format(des_date, format='%d/%m/%Y')&
            Edata$price > range_price[1] &
            Edata$price < range_price[2]
        ), ]
        temp_dataset <-
          temp_dataset[which(temp_dataset$airline == airline), ]
      } else{
        temp_dataset <- Bdata[which(
          Bdata$from == origin &
            Bdata$to == destination &
            Bdata$date == format(des_date,format='%d/%m/%Y')&
            Bdata$price > range_price[1] &
            Bdata$price < range_price[2]
        ),]
        temp_dataset <-
          temp_dataset[which(temp_dataset$airline == airline), ]
        
      }
      if (sort_para == 'Price') {
        temp_dataset <- temp_dataset[order(temp_dataset$price), ]
      } else if (sort_para == 'Time taken') {
        tetemp_dataset <- temp_dataset[order(temp_dataset$time_taken), ]
      }
      else if (sort_para == 'Departure time') {
        temp_dataset <- temp_dataset[order(temp_dataset$dep_time), ]
      }
      else if (sort_para == 'Arrival time') {
        temp_dataset <- temp_dataset[order(temp_dataset$arr_time), ]
      }
      result_contain <- ''
      for (y in 1:nrow(temp_dataset)) {
        temp <- html_result
        temp <-
          gsub('_location', paste(temp_dataset[y,]$from, paste('to', temp_dataset[y,]$to)), temp)
        temp <- gsub('_price', temp_dataset[y,]$price, temp)
        temp <- gsub('_period', temp_dataset[y,]$time_taken, temp)
        temp <-
          gsub('_time', paste(
            temp_dataset[y,]$dep_time,
            paste(' - ', temp_dataset[y,]$arr_time)
          ), temp)
        result_contain <- paste(result_contain, temp, sep = ' ')
      }
      result_contain <-
        gsub('_html', result_contain, html_result_table)
      HTML(result_contain)
      
    })
    
    
    
  })
}

shinyApp(ui = ui, server = server)
