library(shiny)

html_result_table <- '<div class="result_table">_html</div>'
html_result <- '<div class="result">
            <div class="left_div">
                <!--<div class="left_top">-->
                <!--    <ul class="ul_label">-->
                 <!--       <li id="fastest">Fastest</li> -->
                  <!--      <li id="cheapest">Cheapest</li> -->
                  <!--  </ul> -->
            <!--    </div>  -->
                <div class="left_middle">
                    <ul class="ul_data">
                        <li id="image">
                            <img id="airasia" src="_imglink">
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
Efile <- "D:\\R language\\DS_grp_assign\\economy.csv"

Bfile <- "D:\\R language\\DS_grp_assign\\business.csv"
img_link  <- c('')
Bdata <- read.csv(Bfile)

Edata <- read.csv(Efile)

Bdata$price <- gsub(',', '', Bdata$price)
Edata$price <- gsub(',', '', Edata$price)
colnames(Edata)[1] <- 'date'
colnames(Bdata)[1] <- 'date'
min <- min(strtoi(Edata$price))
max <- max(strtoi(Bdata$price))
Edata$price <- strtoi(Edata$price)
Bdata$price < -strtoi(Bdata$price)
airline_name <- c("SpiceJet" , "AirAsia"  , "Vistara"  , "GO FIRST"  ,"Indigo"   ,"Air India", "Trujet"   , "StarAir")
image <- c('https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/spicejet.jpg',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/airasia%20logo.png',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/vistara.png',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/go%20first.png',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/indigo.jpg',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/air%20india.png',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/trujet.png',
           'https://raw.githubusercontent.com/PuaZhiXian/DS_grp_assign/main/starair.png')
web_link <- c('https://www.spicejet.com/',
              'https://www.airasia.com/en/gb?gclid=Cj0KCQjw1tGUBhDXARIsAIJx01mvuGbEguIN_vHxsDNYScox9WDYdH94RRdbrMAh9eZZD_GK3ampQjwaAknCEALw_wcB',
              'https://www.airvistara.com/sg/en/vistara-experience/on-ground/check-in/web-check-in',
              'https://www.flygofirst.com/plan-my-trip/web-check-in/',
              'https://www.goindigo.in/',
              'https://www.airindia.in/',
              'https://www.kiwi.com/en/airline/2t/trujet/?utm_source=google&utm_medium=cpc&mkt_form=acquisition&mkt_agency=adwordssearch&affilid=acquisition000performance000sem000airlines&mkt_origin=&si=&mkwid=s-dc_pcrid_493947899896_pkw_trujet_pmt_e_slid__&pgrid=116907743957&ptaid=aud-425340316926:kwd-336371470537&utm_campaign=11812955486&paid_traffic_source=1&gclid=Cj0KCQjw1tGUBhDXARIsAIJx01kunesDQZhKvC-bAy-T7_ZjagbLvZw4gl9Or6gi4_YZgm_MMd5aVNIaAiifEALw_wcB',
              'https://starair.in/')
img_info <- data.frame(airline_name=airline_name,image=image, web_link=web_link)


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
            ),
            selectInput(
              inputId = 'type',
              label = "",
              choices = c('economy', 'business')
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
            choices = c('Price', 'Time taken', 'Departure time'),
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
      type <- input$type
      airline <- input$airline
      sort_para <- input$sort_para
      range_price <-  input$range_price
      temp_dataset <- NULL
      if (type == 'economy') {
        temp_dataset <- Edata[which(Edata$from == origin), ]
        temp_dataset <- temp_dataset[which(temp_dataset$to == destination),]
        temp_dataset <- temp_dataset[which(temp_dataset$date == format(des_date, format="%d/%m/%Y")),]
        print(format(des_date, format="%d/%m/%Y"))
        temp_dataset <- temp_dataset[which(strtoi(temp_dataset$price) > strtoi(range_price[1])),]
        temp_dataset <- temp_dataset[which(strtoi(temp_dataset$price) < strtoi(range_price[2])),]
        temp_dataset <-temp_dataset[which(temp_dataset$airline == airline), ]
        
      } else{
        temp_dataset <- Bdata[which(Bdata$from == origin), ]
        temp_dataset <- temp_dataset[which(temp_dataset$to == destination),]
        temp_dataset <- temp_dataset[which(temp_dataset$date == format(des_date, format="%d/%m/%Y")),]
        print(format(des_date, format="%d/%m/%Y"))
        temp_dataset <- temp_dataset[which(strtoi(temp_dataset$price) > strtoi(range_price[1])),]
        temp_dataset <- temp_dataset[which(strtoi(temp_dataset$price) < strtoi(range_price[2])),]
        temp_dataset <-temp_dataset[which(temp_dataset$airline == airline), ]
      }
      if (sort_para == 'Price') {
        temp_dataset <- temp_dataset[order(temp_dataset$price), ]
      } else if (sort_para == 'Time taken') {
        temp_dataset <- temp_dataset[order(temp_dataset$time_taken), ]
      }
      else if (sort_para == 'Departure time') {
        temp_dataset <- temp_dataset[order(temp_dataset$dep_time), ]
      }
      
      result_contain <- ''
      if(nrow(temp_dataset)!=0){
        for (y in 1:nrow(temp_dataset)) {
          temp <- html_result
          temp <-
            gsub('_location', paste(temp_dataset[y,]$from, paste('to', temp_dataset[y,]$to)), temp)
          temp <- gsub('_price',paste('RM',temp_dataset[y,]$price) , temp)
          temp <- gsub('_period', paste(as.integer(temp_dataset[y,]$time_taken/60), paste("h", paste(as.integer(temp_dataset[y,]$time_taken%%60),'m'))), temp)
          temp <-
            gsub('_time', paste(temp_dataset[y,]$date, paste(temp_dataset[y,]$dep_time,paste(' - ', temp_dataset[y,]$arr_time))), temp)
          temp <- gsub('_imglink',img_info[which(img_info$airline_name == temp_dataset[y,]$airline),]$image,temp)
          temp <- gsub('_airline_website',img_info[which(img_info$airline_name==temp_dataset[y,]$airline),]$web_link,temp)
          result_contain <- paste(result_contain, temp, sep = ' ')
        }
      }
      result_contain <-
        gsub('_html', result_contain, html_result_table)
      HTML(result_contain)
      
    })
    
    
    
  })
}

shinyApp(ui = ui, server = server)
