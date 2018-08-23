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
  skin = "green",
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
      menuItem("Design", tabName = "design"),
      menuItem("Collect", tabName = "collect"),
      menuItem("Process", tabName = "process"),
      menuItem("Analyse", tabName = "analyse"),
      menuItem("Report", tabName = "report")
    )
  ),
  #
  # Body
  #
  dashboardBody()
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

