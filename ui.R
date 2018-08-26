################################################################################
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
                    lib = "font-awesome",
                    class = "fa-lg")),
      menuItem(text = "Collect", 
        tabName = "collect",
        icon = icon(name = "tablet",
                    lib = "font-awesome",
                    class = "fa-lg")),
      menuItem(text = "Process", 
        tabName = "process",
        icon = icon(name = "database",
                    lib = "font-awesome",
                    class = "fa-lg")),
      menuItem(text = "Analyse", 
        tabName = "analyse",
        icon = icon(name = "line-chart",
                    lib = "font-awesome",
                    class = "fa-lg")),
      menuItem(text = "Report", 
        tabName = "report",
        icon = icon(name = "file-text",
                    lib = "font-awesome",
                    class = "fa-lg"))
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
        h2("Design"),
        hr(),
        fluidRow(
          box(title = "Indicators",
            solidHeader = TRUE,
            status = "danger",
            width = 4,
            checkboxGroupInput(inputId = "designIndicators",
              label = "Which indicators are to be assessed?",
              choices = c("IMAM coverage" = "imam", 
                          "Vitamin A supplementation coverage" = "vita",
                          "FeFol supplementation coverage" = "fefol",
                          "Micronutrient powder supplementation coverage" = "mnp",
                          "Infant and young child feeding counselling coverage" = "iycf"),
              selected = c("imam", "vita", "fefol", "mnp", "iycf")
            )
          ),
          tabBox(selected = "IMAM",
            title = "Description",
            width = 8,
            height = 500,
            side = "right",
            tabPanel(title = "IYCF",
              withMathJax(),
              uiOutput("descriptionIycf")),
            tabPanel(title = "MNP",
              withMathJax(),
              uiOutput("descriptionMnp")),
            tabPanel(title = "FeFol",
              withMathJax(),
              uiOutput("descriptionFefol")),
            tabPanel(title = "Vitamin A",
              withMathJax(),
              uiOutput("descriptionVita")),
            tabPanel(title = "IMAM",
              withMathJax(),
              uiOutput("descriptionImam"))
          )
        ),
        hr(),
        fluidRow(
          box(title = "Sample size parameters",
            solidHeader = TRUE,
            status = "danger",
            width = 4,
            selectInput(inputId = "zValue",
              label = "Confidence interval",
              choices = list("96% CI ( z-value: 2.05 )" = "2.05",
                             "95% CI ( z-value: 1.96 )" = "1.96",
                             "92% CI ( z-value: 1.75 )" = "1.75",
                             "90% CI ( z-value: 1.645 )" = "1.645"),
              selected = "1.96"),
            sliderInput(inputId = "sampSizeProp",
              label = "Proportion/prevalence (p)",
              min = 0, max = 1, value = 0.50, step = 0.01),
            sliderInput(inputId = "sampSizePrec",
              label = "Level of precision (c)",
              min = 0.03, max = 0.15, value = 0.10, step = 0.01),
            hr(),
            checkboxInput(inputId = "sampSizeFpc",
              label = "Apply finite population correction",
              value = FALSE),
            conditionalPanel(condition = "input.sampSizeFpc",
              numericInput(inputId = "sampSizeFpcPop",
                label = "Population size",
                value = 10000,
                min = 1, max = 100000, step = 1)
            ),
            hr(),
            radioButtons(inputId = "inputDeffType",
              label = "Specify/calculate design effect (DEFF)",
              choices = c("Specify" = "specify", 
                          "Calculate" = "calculate"),
              selected = "specify",
              inline = TRUE),
            conditionalPanel(condition = "input.inputDeffType == 'specify'",
              sliderInput(inputId = "inputDeffValue",
                label = "Specify design effectd (DEFF)",
                value = 2.0,
                min = 1.0, max = 10.0, step = 0.1)
            ),
            conditionalPanel(condition = "input.inputDeffType == 'calculate'",
              fileInput(inputId = "inputDeffFile",
                label = "Upload CSV dataset file for DEFF calculation",
                accept = c("text/csv", 
                           "text/comma-separated-values,text/plain", 
                           ".csv")),
              selectInput(inputId = "inputDeffVar",
                label = "Select variable name of indicator to test",
                choices = c("Select variable name" = "")),
              selectInput(inputId = "inputDeffCluster",
                label = "Select variable name of survey cluster",
                choices = c("Select variable name" = "")),
              sliderInput(inputId = "inputDeffClusterSize",
                label = "No. of samples per cluster planned for survey",
                min = 0, max = 30, step = 1, value = 10)
            ),
            br(),
            actionButton(inputId = "calcSampSize",
              label = "Calculate",
              icon = icon(name = "calculator", 
                          lib = "font-awesome", 
                          class = "fa-lg")
            ),
            actionButton(inputId = "calcSampSizeReset",
              label = "Reset",
              icon = icon(name = "refresh",
                          lib = "font-awesome",
                          class = "fa-lg")
            )
          ),
          box(title = "Sample size calculations",
            solidHeader = TRUE,
            status = "danger",
            width = 8,
            withMathJax(),
            uiOutput("sampSizeCalculations"),
            hr(),
            shinyjs::useShinyjs(),
            conditionalPanel(condition = "input.calcSampSize != 0",
              h4(textOutput("sampSizeHeader"))
            ),
            valueBoxOutput("confIntBox"),
            valueBoxOutput("precisionBox"),
            valueBoxOutput("clusterSizeBox"),
            valueBoxOutput("iccBox"),
            valueBoxOutput("deffBox"),
            valueBoxOutput("sampSizeBox")
          )
        ),
        hr(),
        fluidRow(
          box(title = "Stage 1 sampling parameters",
            solidHeader = TRUE,
            status = "danger",
            width = 4,
            shinyjs::useShinyjs(),            
            selectInput(inputId = "mapSamplingAreaType",
              label = "Select area type to sample",
              choices = list("Choose one" = "",
                             "Country" = "country",
                             "County" = "county",
                             "District" = "district"),
              selected = NULL),
            conditionalPanel(condition = "input.mapSamplingAreaType == 'county'",
              selectInput(inputId = "mapSamplingCounty",
                label = "Select counties to sample",
                choices = list("Select county" = "",
                               "Counties" = counties$admin1name),
                selected = NULL)
            ),
            conditionalPanel(condition = "input.mapSamplingAreaType == 'district'",
              selectInput(inputId = "mapSamplingDistrict",
                label = "Select districts to sample",
                choices = list("Select district" = "",
                               "Districts" = districts$admin2Name),
                selected = NULL)
            ),
            conditionalPanel(condition = "input.mapSamplingAreaType != '' | input.mapSamplingCounty != '' | input.mapSamplingDistrict != ''",
              hr(),
              h5("Spatial sample settings"),
              selectInput(inputId = "mapSamplingSpec",
                label = "Specify spatial grid parameter to use",
                choices = c("Grid area" = "area",
                            "Number of grids" = "n",
                            "Max distance to sampling point" = "d"),
                selected = "area"),
              conditionalPanel(condition = "input.mapSamplingSpec == 'area'",
                numericInput(inputId = "mapSamplingGridArea",
                  label = "Set grid area size (in sq kms)",
                  value = 100, min = 5, max = 500, step = 5),
                numericInput(inputId = "mapSamplingSettlementsNumber",
                             label = "No. of settlements per sampling point",
                             value = 1, min = 1, max = 10, step = 1)
              ),
              conditionalPanel(condition = "input.mapSamplingSpec == 'n'",
                numericInput(inputId = "mapSamplingGridNumber",
                  label = "Set grid number",
                  value = 20, min = 16, max = 30, step = 1),
                numericInput(inputId = "mapSamplingSettlementsNumber",
                             label = "No. of settlements per sampling point",
                             value = 1, min = 1, max = 10, step = 1)
              ),
              conditionalPanel(condition = "input.mapSamplingSpec == 'd'",
                numericInput(inputId = "mapSamplingGridDist",
                  label = "Set max distance to sampling point (in kms)",
                  value = 10, min = 5, max = 30, step = 1),
                numericInput(inputId = "mapSamplingSettlementsNumber",
                  label = "No. of settlements per sampling point",
                  value = 1, min = 1, max = 10, step = 1)
              ),
              conditionalPanel(condition = "input.mapSamplingAreaType == 'country'",
                actionButton(inputId = "mapSamplingPlotCountry",
                  label = "Plot",
                  icon = icon(name = "th",
                              lib = "font-awesome",
                              class = "fa-lg")
                ),
                actionButton(inputId = "mapSamplingPlotCountryReset",
                  label = "Reset",
                  icon = icon(name = "refresh",
                              lib = "font-awesome",
                              class = "fa-lg")
                )
              ),
              conditionalPanel(condition = "input.mapSamplingAreaType == 'county'",
                actionButton(inputId = "mapSamplingPlotCounty",
                  label = "Plot",
                  icon = icon(name = "th",
                              lib = "font-awesome",
                              class = "fa-lg")
                ),
                actionButton(inputId = "mapSamplingPlotCountyReset",
                  label = "Reset",
                  icon = icon(name = "refresh",
                              lib = "font-awesome",
                              class = "fa-lg")
                )
              ),
              conditionalPanel(condition = "input.mapSamplingAreaType == 'district'",
                actionButton(inputId = "mapSamplingPlotDistrict",
                  label = "Plot",
                  icon = icon(name = "th",
                              lib = "font-awesome",
                              class = "fa-lg")
                ),
                actionButton(inputId = "mapSamplingPlotDistrictReset",
                  label = "Reset",
                  icon = icon(name = "refresh",
                              lib = "font-awesome",
                              class = "fa-lg")
                )
              ),
              hr(),
              h5("Spatial sample plot settings"),
              uiOutput("mapSamplingPointPlot"),
              uiOutput("mapSamplingGridPlot"),
              uiOutput("mapSettlementsPlot"),
              br(),
              actionButton(inputId = "mapSample",
                label = "Sample",
                icon = icon(name = "th",
                            lib = "font-awesome",
                            class = "fa-lg")
              ),
              actionButton(inputId = "mapSampleReset",
                label = "Reset",
                icon = icon(name = "refresh",
                            lib = "font-awesome",
                            class = "fa-lg")
              )
            )
          ),
          box(title = "Stage 1 sample",
            solidHeader = TRUE,
            status = "danger",
            width = 8,
            leafletOutput("mapSampling", height = 600)
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
          side = "right",
          width = 12,
          tabPanel(title = "Process Indicators",
            fluidRow(
              box(title = "Indicators",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
                checkboxGroupInput(inputId = "inputIndicators",
                  label = "Which indicators are to be assessed?",
                  choices = c("IMAM coverage", 
                              "Vitamin A supplementation coverage",
                              "FeFol supplementation coverage",
                              "Micronutrient powder supplementation coverage",
                              "Infant and young child feeding counselling coverage"),
                  selected = c("IMAM coverage", 
                               "Vitamin A supplementation coverage",
                               "FeFol supplementation coverage",
                               "Micronutrient powder supplementation coverage",
                               "Infant and young child feeding counselling coverage")
                ),
                br(),
                actionButton(inputId = "inputProcessAction",
                  label = "Process",
                  icon = icon(name = "database", 
                              lib = "font-awesome",
                              class = "fa-lg"))
              )
            )
          ),
          tabPanel(title = "Check Raw Data"),
          tabPanel(title = "Input Raw Coverage Data",
            fluidRow(
              box(title = "Input Raw Coverage Data",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
                radioButtons(inputId = "inputDataType2",
                  label = "How will coverage data be inputted?",
                  choices = c("Upload data file" = "upload", 
                              "Get data from ODK server" = "odk")),
                br(),
                conditionalPanel(condition = "input.inputDataType2 == 'upload'",
                  fileInput(inputId = "inputDataRaw2",
                  label = "Upload raw coverage data to process",
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv")),
                  actionButton(inputId = "inputDataAction2",
                    label = "Upload data",
                    icon = icon(name = "upload", 
                                lib = "font-awesome",
                                class = "fa-lg"))
                ),
                conditionalPanel(condition = "input.inputDataType2 == 'odk'",
                  radioButtons(inputId = "inputOdkData2",
                    label = "Pull data from ODK remote or local?",
                    choices = c(Remote = "remote", Local = "local")),
                  br(),
                  conditionalPanel(condition = "input.inputOdkData2 == 'remote'",
                    textInput(inputId = "inputOdkUrl2",
                      label = "Remote URL",
                      placeholder = "https://odk.ona.io"),
                    textInput(inputId = "inputOdkUsername2",
                      label = "Username"),
                    textInput(inputId = "inputOdkPassword2",
                      label = "Password"),
                    textInput(inputId = "inputOdkFormId2",
                      label = "Form ID")
                  ),
                  conditionalPanel(condition = "input.inputOdkData2 == 'local'",
                    textInput(inputId = "inputOdkDirectory2",
                      label = "Where is the local ODK directory located?",
                      value = getwd()),
                    textInput(inputId = "inputOdkFormId2",
                      label = "Form ID")
                  ),
                  conditionalPanel(condition = "input.inputOdkFormId2 == ' '",
                    actionButton(inputId = "inputDataAction2",
                      label = "Pull data",
                      icon = icon(name = "arrow-down",
                                  lib = "font-awesome", 
                                  class = "fa-lg"))
                  )
                )
              ),
              conditionalPanel(condition = "input.inputDataAction2 > 0",
                box(title = "Raw Coverage Data",
                  solidHeader = TRUE,
                  status = "danger",
                  width = 8)
              )
            )
          ),
          tabPanel(title = "Input Raw Village Data",
            fluidRow(
              box(title = "Input Raw Village Data",
                solidHeader = TRUE,
                status = "danger",
                width = 4,
                radioButtons(inputId = "inputDataType1",
                  label = "How will village data be inputted?",
                  choices = c("Upload data file" = "upload", 
                              "Get data from ODK server" = "odk")),
                br(),
                conditionalPanel(condition = "input.inputDataType1 == 'upload'",
                  fileInput(inputId = "inputDataRaw1",
                    label = "Upload raw coverage data to process",
                    accept = c("text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv")),
                  actionButton(inputId = "inputDataAction1",
                    label = "Upload data",
                    icon = icon(name = "upload", 
                                lib = "font-awesome",
                                class = "fa-lg"))
                ),
                conditionalPanel(condition = "input.inputDataType1 == 'odk'",
                  radioButtons(inputId = "inputOdkData1",
                    label = "Pull data from ODK remote or local?",
                    choices = c(Remote = "remote", Local = "local")),
                  br(),
                  conditionalPanel(condition = "input.inputOdkData1 == 'remote'",
                    textInput(inputId = "inputOdkUrl1",
                      label = "Remote URL",
                      placeholder = "https://odk.ona.io"),
                    textInput(inputId = "inputOdkUsername1",
                      label = "Username"),
                    textInput(inputId = "inputOdkPassword1",
                      label = "Password"),
                    textInput(inputId = "inputOdkFormId1",
                      label = "Form ID")
                  ),
                  conditionalPanel(condition = "input.inputOdkData1 == 'local'",
                    textInput(inputId = "inputOdkDirectory1",
                      label = "Where is the local ODK directory located?",
                      value = getwd()),
                    textInput(inputId = "inputOdkFormId1",
                      label = "Form ID")
                  ),
                  conditionalPanel(condition = "input.inputOdkFormId1 == ' '",
                    actionButton(inputId = "inputDataAction1",
                      label = "Pull data",
                      icon = icon(name = "arrow-down", 
                                  lib = "font-awesome",
                                  class = "fa-lg"))
                  )
                )
              ),
              conditionalPanel(condition = "input.inpuDataAction1 > 0",
                box(title = "Raw Village Data",
                  solidHeader = TRUE,
                  status = "danger",
                  width = 8)
              )
            )
          )
        )
      ),
      #
      # Body output when 'analyse' menu is selected
      #
      tabItem(tabName = "analyse",
        box(title = "Analyse",
          solidHeader = FALSE,
          status = "danger",
          width = 12,
          fluidRow(
            box(title = "Analysis Parameters",
              solidHeader = TRUE,
              status = "danger",
              width = 4,
              checkboxGroupInput(inputId = "analysisIndicators",
                label = "Select indicators to analyse",
                choices = c("IMAM coverage", 
                            "Vitamin A supplementation coverage",
                            "FeFol supplementation coverage",
                            "Micronutrient powder supplementation coverage",
                            "Infant and young child feeding counselling coverage"),
                selected = c("IMAM coverage", 
                             "Vitamin A supplementation coverage",
                             "FeFol supplementation coverage",
                             "Micronutrient powder supplementation coverage",
                             "Infant and young child feeding counselling coverage")
              ),
              br(),
              numericInput(inputId = "replicates",
                label = "No. of bootstrap replicates",
                value = 399,
                min = 399,
                step = 100),
              br(),
              actionButton(inputId = "analysisAction",
                label = "Analyse",
                icon = icon(name = "line-chart", 
                            lib = "font-awesome",
                            class = "fa-lg"))
            )
          )
        )
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
