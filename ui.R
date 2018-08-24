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
    #
    # Sidebar menu
    #
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
    #
    # Specify a custom.css
    #
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    #
    # Body outputs for every menu item on sidebar
    #
    tabItems(
      #
      # Body output when 'design' menu is selected
      #
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
      #
      # Body output when 'collect' menu is selected
      #
      tabItem(tabName = "collect",
        tabBox(selected = "PAPI",
          title = "Collect",
          width = 12,
          side = "right",
          tabPanel(title = "CAPI"),
          tabPanel(title = "PAPI")
        )
      ),
      #
      # Body output when 'process' menu is selected
      #
      tabItem(tabName = "process",
        tabBox(title = "Process",
          selected = "Input Raw Village Data",
          #solidHeader = FALSE,
          #status = "danger",
          side = "right",
          width = 12,
          height = 600,
          tabPanel(title = "Input Raw Coverage Data",
            box(title = "Input data to process",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              radioButtons(inputId = "inputDataType",
                label = "How will data be inputted?",
                choices = c("Upload data file" = "upload", 
                            "Get data from ODK server" = "odk")),
              br(),
              conditionalPanel(condition = "input.inputDataType == 'upload'",
                fileInput(inputId = "inputDataRaw",
                  label = "Upload raw data to process",
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv"))
              ),
              conditionalPanel(condition = "input.inputDataType == 'odk'",
                radioButtons(inputId = "inputOdkType",
                  label = "Pull data from ODK remote or local?",
                  choices = c(Remote = "remote", Local = "local")),
                br(),
                conditionalPanel(condition = "input.inputOdkType == 'remote'",
                  textInput(inputId = "inputOdkUrl",
                    label = "Remote URL",
                    placeholder = "https://odk.ona.io"),
                  textInput(inputId = "inputOdkUsername",
                    label = "Username"),
                  textInput(inputId = "inputOdkPassword",
                    label = "Password"),
                  textInput(inputId = "inputOdkFormId",
                    label = "Form ID")
                ),
                conditionalPanel(condition = "input.inputOdkType == 'local'",
                  textInput(inputId = "inputOdkDirectory",
                    label = "Where is the local ODK directory located?",
                    value = getwd()),
                  textInput(inputId = "inputOdkFormId",
                    label = "Form ID")
                )
              )
            ),
            box(title = "Input Raw coverage data",
              solidHeader = TRUE,
              status = "danger",
              width = 8)),
          tabPanel(title = "Input Raw Village Data")
        )
      ),
      #
      # Body output when 'analyse' menu is selected
      #
      tabItem(tabName = "analyse",
        box(title = "Analyse",
          solidHeader = FALSE,
          status = "danger",
          width = 12)
      ),
      #
      # Body output when 'report' menu is selected
      #
      tabItem(tabName = "report",
        box(title = "Report",
          solidHeader = FALSE,
          status = "danger",
          width = 12)
      )
    )
  )
)
