################################################################################
#
#
#
# This is a Shiny web application to support the implementation of health and
# nutrition coverage surveys in Liberia
#
#
#
################################################################################


################################################################################
#
# Set-up
#
################################################################################
#
# Load libraries
#
if(!require(shiny)) install.packages("shiny")
if(!require(shinydashboard)) install.packages("shinydashboard")
if(!require(devtools)) install.packages("devtools")
if(!require(liberia)) install_github("liberia")
if(!require(spatialsampler)) install_github("spatialsampler")
if(!require(odkr)) install_github("odkr")


################################################################################
#
# UI for web application
#
################################################################################
#
# Define UI for application
#
ui <- dashboardPage(
  skin = "red",
  #
  # Header
  #
  dashboardHeader(
    title = "Liberia Coverage Surveys",
    titleWidth = 300),
  #
  # Sidebar
  #
  dashboardSidebar(
    width = 300,
    sidebarSearchForm(
      textId = "searchText",
      buttonId = "searchButton"
    ),
    sidebarMenu(
      id = "tabs",
      menuItem(text = "Design", 
               tabName = "design", 
               icon = icon(name = "pencil", 
                           lib = "font-awesome")),
      menuItem(text = "Collect", 
               tabName = "collect",
               icon = icon(name = "tablet",
                           lib = "font-awesome")),
      menuItem(text = "Process", 
               tabName = "process",
               icon = icon(name = "database",
                           lib = "font-awesome")),
      menuItem(text = "Analyse", 
               tabName = "analyse",
               icon = icon(name = "line-chart",
                           lib = "font-awesome")),
      menuItem(text = "Report", 
               tabName = "report",
               icon = icon(name = "file-text",
                           lib = "font-awesome"))
    )
  ),
  #
  # Body
  #
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      tabItem(tabName = "design",
        tabBox(selected = "Indicators",
          title = "Design",
          width = 12,
          height = 600,
          side = "right",
          tabPanel(title = "Stage 2"),
          tabPanel(title = "Stage 1"),
          tabPanel(title = "Sample size"),
          tabPanel(title = "Indicators",
            box(title = "Select indicators",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              checkboxGroupInput(inputId = "indicators1",
                label = "Which indicators are to be assessed?",
                choices = c("IMAM coverage", "Vitamin A supplementation coverage",
                            "FeFol supplementation coverage",
                            "Micronutrient powder supplementation coverage",
                            "Infant and young child feeding counselling coverage"),
                selected = NULL)
            ),
            box(title = "Description",
              solidHeader = TRUE,
              status = "danger",
              width = 8)
          )
        )
      ),
      tabItem(tabName = "collect",
        tabBox(selected = "PAPI",
          title = "Collect",
          width = 12,
          side = "right",
          tabPanel(title = "CAPI"),
          tabPanel(title = "PAPI")
        )
      ),
      tabItem(tabName = "process",
        box(title = "Process",
          solidHeader = FALSE,
          status = "danger",
          width = 12)
      ),
      tabItem(tabName = "analyse",
        box(title = "Analyse",
          solidHeader = FALSE,
          status = "danger",
          width = 12)
      ),
      tabItem(tabName = "report",
        box(title = "Report",
          solidHeader = FALSE,
          status = "danger",
          width = 12)
      )
    )
  )
)


################################################################################
#
# Server logic for web application
#
################################################################################
#
# Define server logic for application
#
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)

