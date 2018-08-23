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
    tabItems(
      tabItem(
        tabName = "design",
        tabBox(
          width = 12,
          title = "Design",
          selected = "Indicators",
          tabPanel("Indicators"),
          tabPanel("Stage 1"),
          tabPanel("Stage 2")
        )
      ),
      tabItem(
        tabName = "collect"
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

