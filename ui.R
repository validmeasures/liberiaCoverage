################################################################################
#
#
#
# This is a Shiny web application to support the implementation of health and
# nutrition coverage surveys in Liberia.
#
# This is the code for the user interface (UI) of the Shiny web application.
#
#
################################################################################


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
          width = 12,
          box(title = "Input data to process",
            solidHeader = TRUE,
            status = "danger",
            width = 4,
            radioButtons(inputId = "rawdata1",
              label = "How will data be inputted?",
              choices = c("Upload data file", 
                          "Get data from ODK server"))
          )
        )
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
