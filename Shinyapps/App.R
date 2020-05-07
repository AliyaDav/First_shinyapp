library(shiny)
library(shinyBS)
library(rsconnect)
library(tidyverse)
library(Hmisc)
library(magrittr)
library(base)
library(stringr)
library(ggplot2)
library(ggthemes)
library(ggfortify)
library(reshape2)
library(plyr)
library(RColorBrewer)
library(viridis)
library(readxl)
library(rworldmap)
library(maps)
library(mapdata)
library(mapproj)
library(gapminder)
library(ggalt)
library(PerformanceAnalytics)

source("global.R")

ui <- fluidPage(
  HTML('<script> document.title = "Economic growth"; </script>'),
  titlePanel(h3("How has the world changed over the last half a century?", align = "center")),
  tabsetPanel(
    tabPanel("World data", 
             # sidebarLayout(
             #   sidebarPanel(
             #selectInput("factor1", "Choose a value:", choices = c("GDPpc", "Family","Life.Expectancy","Freedom", "Generosity", "Trust"), selected = "Family"), 
             fluidRow(column(12, plotOutput("plot3", width = "90%", height = 600))),
             fluidRow(
               column(5, offset = 4,
               sliderInput(inputId = "year1", label = "Income per capita in...", 
                           min = 1960, max = 2011, value = 1998, step = 1)
               )
               ),
             fluidRow(column(12, plotOutput("plot4", width = "90%", height = 600))),
               fluidRow(
                 column(width = 7, offset = 4,
                        sliderInput(inputId = "year2", label = "Life expectancy in...", 
                                    min = 1919, max = 2011, value = 1930, step = 1)
                 )
               ),
             fluidRow(
               column(6, plotOutput("plot1") ),
               column(6, plotOutput("plot2") )
             ),
             fluidRow(
               column(2, 
                      selectInput("status", "Choose income group", choices = c("Low"="low", 
                                                                               "Lower-middle"="lower_middle",
                                                                               "Higher-middle"="upper_middle"
                                                                               ))
             ),
             column(8, plotOutput("matrix",  width = "100%", height = 500))
             ),
             # fluidRow(
             #   column(2, 
             #          selectInput("variables", "Choose an indicator", choices = c("Child mortality"="child_mortality", 
             #                                                                   "Sanitary access"="sanit_access",
             #                                                                   "Primary school completion"="prime_school"
             #          )),
             #          sliderInput(inputId = "year3", label = "Select year", 
             #                      min = 1980, max = 2015, value = 1998, step = 1)
             #          ),
             #   column(5, plotOutput("boxplot"))
             # ),
             fluidRow(
               column(5, plotOutput("aid")),
               column(7, plotOutput("mostaid"))
             )
             ),
               #actionButton("button1", "Update")
    tabPanel("Data by region", 
             fluidRow(
               column(2, 
                      selectInput("group", "Choose region", choices = c("Latin America", 
                                                                              "West Asia",
                                                                              "Africa"))
                    ),
               column(7, offset = 1, plotOutput("columns"))
               ),
             fluidRow(
               column(5, plotOutput("incchange", width = "100%", height = 700)),
               column(7, plotOutput("incdiff", width = "100%", height = 700))
             ),
             fluidRow(
               column(10,  offset = 1, plotOutput("aidreceived", width = "100%", height = 500))
             ),
             fluidRow(
               column(8, offset = 2, plotOutput("topaid", width = "100%", height = 700))
             ),
             fluidRow(
               # column(2, 
               # selectInput("variables", "Choose an indicator", choices = c("Child mortality"="child_mortality", 
               #                                                             "Sanitary access"="sanit_access",
               #                                                             "Primary school completion"="prime_school"))),
               column(8, offset = 2, plotOutput("top6", width = "100%", height = 500))
             ),
             fluidRow(
               column(6, plotOutput("health", width = "95%")),
               column(6, plotOutput("life", width = "95%"))
             ),
             fluidRow(
               column(6, plotOutput("sanitary", width = "95%")),
               column(6, plotOutput("child", width = "95%"))
             )
               
             )
            
    )
)

server <- function(input, output, session) {
  
  output$plot1 <- renderPlot({
    all_data %>% 
      dplyr::filter(year >= 1960) %>% 
      dplyr::select(year, status) %>% 
      drop_na() %>%
      dplyr::group_by(year) %>% plyr::count() %>% 
      ggplot(aes(x = year, y = freq, fill = status)) + geom_col(position = "fill") +
      theme(axis.text.x = element_text(size = 14, angle = 45, hjust = 1),
            axis.text.y = element_text(size = 14),
            plot.title = element_text(lineheight = 1, hjust = 0.5, size = 16, face = "bold")) +
      scale_fill_viridis_d() +
      labs(y = "Proportion") + xlab(NULL)+
      labs(title = " The number of high-income countries had been \n increasing till 1980")
  })
  
  output$plot2 <- renderPlot({
    all_data %>% 
      filter(year %in% 1960:2011 & !is.na(status) & !is.na(income)) %>%
      dplyr::group_by(year, status) %>% 
      dplyr::mutate(avg_inc = mean(income)) %>%
      ggplot(aes(x = year, y = avg_inc, group = status)) + 
      geom_line(aes(color = status)) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            plot.title = element_text(lineheight = 1, hjust = 0.5, size = 16, face = "bold"),
            legend.position = "none") +
      facet_wrap(~ status, scales = "free_y") + 
      scale_color_viridis_d()+
      labs(title = "Change in average income level \n among different groups", 
           y = "Average income") + xlab(NULL)
  })
  
  df1 <- reactive({
    all_data %>%
      filter(year == input$year1)
  })
  
  # 1st map
  sPDF <- getMap()  
  map_inc_data = reactive({
    joinCountryData2Map(df1(), joinCode = "NAME", 
                        nameJoinColumn = "country") 
  })
  inc_map = reactive({
    mapCountryData(map_inc_data(), nameColumnToPlot = "income", 
                   catMethod = "pretty",
                   colourPalette = rev(viridis(256)),
                   mapTitle = paste0("Income per cap in ", input$year1))
  })
  output$plot3 <- renderPlot({
    do.call(addMapLegend, c(inc_map(), legendLabels = "all" ))
  },height = 600)
  
  
  
  # 2nd map 
  df2 <- reactive({
    all_data %>%
      filter(year == input$year2)
  })
  map_lifeEx_data = reactive({
    joinCountryData2Map(df2(), joinCode = "NAME", 
                        nameJoinColumn = "country")
  })
  map_lifeEx = reactive({
    mapCountryData(map_lifeEx_data(), nameColumnToPlot = "life_exp",
                   colourPalette = viridis(256, option = "A", direction = -1),
                   mapTitle = paste0("Income per cap in ", input$year2),
                   catMethod = "pretty", addLegend = F)
  })
  output$plot4 <- renderPlot({
    do.call(addMapLegend, c(map_lifeEx(), legendLabels = "all" ))
  }, height = 600)
  
  
  # cormatrix
  
  no = reactive({
    noNA = all_data %>% 
      filter(status == input$status) %>%
    select(-country,-status,-pop,-child_mortality,-year) %>%  
    drop_na() %>% cor()
  })
  output$matrix <- renderPlot({
     corrplot::corrplot(no(), order = "AOE", col = viridis(100), 
                        tl.col = "black", tl.cex = 1.2, cl.cex = 1, tl.srt=45,
                        addCoef.col = "black", type = "upper", diag = FALSE)
  })
  
  
  # boxplot
  
  # box_plot <- reactive({
  #   box = all_data %>% 
  #   drop_na(input$variables, status) %>% 
  #   filter(year == input$year3)
  #   indicator = box[,!!input$variables]
  # })
  # output$boxplot <- renderPlot({
  #     ggplot(box_plot(), aes(fill = status)) +
  #     geom_boxplot(aes(x = status, y = indicator)) +
  #     scale_fill_viridis_d() +
  #     labs(title = paste0(input$variables, " in ", input$year3))
  # })
  
  # graphs and column chart 
  
  output$aid <- renderPlot({
    avg_aid %>%
    ggplot(aes(year, avg_aid, group = status)) + 
    geom_line(aes(color = status), lwd = 1, alpha = 0.8) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          plot.title = element_text(lineheight = 1, hjust = 0.5, size = 16, face = "bold"), 
          legend.position = "none") +
    facet_wrap(~ status) + 
    scale_color_viridis_d()+
    labs(title = "Foreign aid distribution",
         y = "Average aid per capita") + xlab(NULL)
  })
  most_aid = all_data %>% filter(pop > 1000000) %>% dplyr::count(country, wt = aid, sort = T) %>% 
    top_n(20) %>% arrange(n) # countries received most aid
  most_aid$country = factor(most_aid$country, levels = most_aid$country)
  output$mostaid <- renderPlot({
    most_aid %>% 
    ggplot(aes(country,n, fill = country)) + geom_col() + 
    coord_flip() + 
    theme(legend.position = "none", 
          plot.title = element_text(lineheight = 1, hjust = 0.5, size = 16, face = "bold")) + 
    viridis::scale_fill_viridis(discrete = T) + 
    labs(title = "Countries which received most aid per cap \n from 1960 to 2010") +
      xlab(NULL) + ylab("Cumulative aid")
  })

  
  # second tab, data by region

  datasetInput <- reactive({
    switch(input$group,
           "Latin America"=latin, 
           "West Asia"=west_asia,
           "Africa"=africa)
  })
  # region <- reactive( { input$group} )
  # region_df <- reactive({
  #   all_data %>%
  #     filter(country %in% all_regions$region())
  # })
  # observeEvent(input$group, {rv$region_df = input$group})
  output$columns <- renderPlot({ income_col(datasetInput()) })

  output$incchange <- renderPlot({ gg(df_for_gg(datasetInput()))})
  output$incdiff <- renderPlot( { divchart(df_for_barchart(datasetInput()))})
  output$topaid <- renderPlot( { aid_col_sum(datasetInput())})
  output$aidreceived <- renderPlot( {aid_by_groups(datasetInput()) })
  output$top6 <- renderPlot( {top6_aid(datasetInput()) })
  
  # output$health <- renderPlot({
  #   datasetInput() %>% 
  #     filter(country %in% most_aid_table(datasetInput())$country & year %in% c(1995:2011)) %>%
  #     ggplot(aes(x = year, y = !!input$variables)) +
  #     geom_line(aes(color = country), lwd = 1, alpha = 0.8) + 
  #     scale_colour_viridis_d() +
  #     facet_wrap(~country) + 
  #     labs(title = "Life expentancy in 1970-2011")
  # })
  output$health <- renderPlot( { top6_health(datasetInput())})
  output$sanitary <- renderPlot( {top6_sanit(datasetInput()) })
  output$child <- renderPlot( { top6_child(datasetInput())})
  output$life <- renderPlot( {top6_life(datasetInput()) })
  
}

shinyApp(ui = ui, server = server)