#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
university<-read.csv("university.csv")
university$highest<-factor(university$highest,levels=c('Bachelor','Master','Doctor'),ordered=TRUE)
university$fees<-as.numeric(university$fees)
university$admission_rate<-as.numeric(university$admission_rate)
library(tidyverse)
library(sf)
library(ggmap)
library(RColorBrewer)
library(viridis)
us_shape <- st_read("cb_2018_us_state_500k.shp")%>%
  filter(!(NAME %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))
university%>%filter(!(state %in% c("Alaska", "District of Columbia", "Hawaii", "Puerto Rico")))
my_theme<-theme_minimal(base_size=10)+
  theme(legend.position="bottom",panel.grid.minor = element_blank(), plot.title = element_text(face='bold',size = rel(1.3),color='grey20',family="serif"), plot.caption = element_text(face = "italic", size = rel(0.8), color = "grey20", family='serif',hjust=0.5),
        legend.text = element_text(colour="grey10", size = rel(0.9), face = "italic",family='serif'),plot.subtitle = element_text(face='italic',size = rel(1),color='grey20',family="serif"), legend.title = element_text(colour="grey20", size = rel(0.9), face = "italic",family='serif'))


ui <- fluidPage(theme = shinytheme("journal"),
      h1("U.S. University Finder (Based on 2013 Data)"),
      br(),
      "Help you to find your",
      strong (" best choice."),
      br(),
      br(),
    sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "Degree",
                   label = "Degree Persued",
                   choices = c("Bachelor", "Master",'Doctor')),
      selectInput(inputId = "Region",
                  label = "University District",
                  choices = sort(unique(university$region)),
                  multiple = TRUE),
      sliderInput(inputId = "Tuition",
                  label = "Average Tuition and Fees",
                  min = min(university$fees,na.rm=TRUE),
                  max = max(university$fees, na.rm = TRUE),
                  value = c(min(university$fees, na.rm = TRUE), max(university$fees, na.rm = TRUE)),
                  pre="$"),
      selectInput(inputId = "Category",
                  label = "Institution Category",
                  choices = sort(unique(university$category)),
                  multiple = TRUE)
      ),
    mainPanel(plotOutput("map"),
              plotOutput('hist'),
              br(),
              br(),
              p("Top 15 Universities Recommended for You"),
              tableOutput("choice")
              )
    ))


get_df<-function(region_v,category_v,tuition_v,degree_v){
  university_filtered<-university%>%
    filter(highest>=degree_v,
           fees >=tuition_v[[1]],
           fees<=tuition_v[[2]])
  if(!is.null(region_v)) {
  university_filtered <- filter(university_filtered, region %in% region_v)}
  if(!is.null(category_v)) {
    university_filtered <- filter(university_filtered, category %in% category_v)}
  names(university_filtered)[names(university_filtered) == 'highest'] <- 'highest_degree_provided'
  return(university_filtered)
}

server <- function(input, output) {
  university_filter<-reactive({
    get_df(input$Region,input$Category,input$Tuition,input$Degree)
  })
    
    
  output$map <- renderPlot({
    ggplot(data = us_shape) + 
      geom_sf() +
      geom_point(university_filter(),mapping=aes(lon,lat,color=highest_degree_provided,shape=highest_degree_provided),
                 alpha=0.7)+
      scale_colour_brewer(palette = "Set1")+
      coord_sf(xlim = c(-130, -60),
               ylim = c(20, 50))+
      labs(title='U.S. University that Satisfy Your Requirements(2013)',x='',y='',subtitle='Source: Kaggler Open Source Data')+
      my_theme})
  
  output$hist <- renderPlot({
    ggplot(university_filter(),mapping=aes(admission_rate,fill=category)) +
      geom_histogram(alpha=0.4,bins=30,position='identity')+
      my_theme+
      labs(title='Admission Rate Distribution',x='Admission Rate', subtitle='Calculated Based on Your Search Criteria.')
  })
  
  output$choice <- renderTable({
    university_filter()[order(university_filter()$admission_rate),][,c('name','admission_rate','women_proportion','religion_affiliation','state')][1:15,]
  })
}
    

# Run the application 
shinyApp(ui = ui, server = server)
