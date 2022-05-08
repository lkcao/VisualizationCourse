library(shiny)
library(tidyverse)

employ <- read_csv("employees-wage.csv")

ui <- fluidPage(
  titlePanel("City of Chicago Wage Employees"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "wage",
                  label = "Wage range",
                  min = 0,
                  max = max(employ$wage, na.rm = TRUE),
                  value = c(0, max(employ$wage, na.rm = TRUE)),
                  pre = "$"),
      radioButtons(inputId = "full_time",
                   label = "Full or part-time",
                   choices = c("Full-Time", "Part-Time")),
      uiOutput("jobTitle"),
      selectInput(inputId = "department",
                  label = "Department",
                  choices = sort(unique(employ$department)),
                  multiple = TRUE)
    ),
    mainPanel(plotOutput("hourlyPlot"),
              tableOutput("employTable"))
  )
)

server <- function(input, output) {
  employ_filter <- reactive({
    employees <- employ
    
    # filter by department
    if(!is.null(input$department)) {
      employees <- filter(employees, department %in% input$department)
    }
    
    # filter by job title
    if(!is.null(input$jobTitle)) {
      employees <- filter(employees, job_title %in% input$jobTitle)
    }
    
    # filter by full or part-time
    employees <- filter(employees, full_time == input$full_time)
    
    # filter by hourly wage
    employees <- filter(employees,
                        wage >= input$wage[[1]],
                        wage <= input$wage[[2]])
  })
  
  output$jobTitle <- renderUI({
    employees <- employ
    
    # filter by department
    if(!is.null(input$department)) {
      employees <- filter(employees, department %in% input$department)
    }
    
    # filter by full or part-time
    employees <- filter(employees, full_time == input$full_time)
    
    # filter by hourly wage
    employees <- filter(employees,
                        wage >= input$wage[[1]],
                        wage <= input$wage[[2]])
    
    selectInput(inputId = "jobTitle",
                label = "Job Title",
                choices = sort(unique(employees$job_title)),
                multiple = TRUE)
  })
  
  output$hourlyPlot <- renderPlot({
    ggplot(employ_filter(), aes(wage)) +
      geom_histogram()
  })
  
  output$employTable <- renderTable({
    employ_filter() %>%
      count(department)
  })
}

shinyApp(ui = ui, server = server)
