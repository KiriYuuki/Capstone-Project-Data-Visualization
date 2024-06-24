# ui.R

# Include the custom CSS
custom_css <- tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom_styles.css"))

ui <- dashboardPage(title = "Health Complaints",
                    
                    # Header
                    dashboardHeader(title = "Health Complaints", titleWidth = 200,
                                    tags$li(actionLink("LinkedIn", 
                                                       label = "", 
                                                       icon = icon("linkedin"),
                                                       onclick = "window.open('https://www.linkedin.com/in/yuandakrisna/')"),
                                            class = "dropdown")),
                    
                    # Side bar of the Dashboard
                    dashboardSidebar(
                      
                      # Side menu of the Dashboard  
                      sidebarMenu(
                        menuItem(text = "Overview",
                                 icon = icon("chart-line"),
                                 tabName = "overview",
                                 badgeLabel = "Summary",
                                 badgeColor = "green"),
                        
                        menuItem(text = "Trends",
                                 icon = icon("line-chart"),
                                 tabName = "trends",
                                 badgeLabel = "Trends",
                                 badgeColor = "blue"),
                        
                        menuItem(text = "Comparison",
                                 icon = icon("bar-chart"),
                                 tabName = "comparison",
                                 badgeLabel = "Comparison",
                                 badgeColor = "purple"),
                        
                        menuItem(text = "Distribution",
                                 icon = icon("pie-chart"),
                                 tabName = "distribution",
                                 badgeLabel = "Distribution",
                                 badgeColor = "orange"),
                        
                        menuItem("Heatmap", tabName = "heatmap", icon = icon("th")),
                        
                        menuItem("Data Table", tabName = "data_table", icon = icon("table")),
                        
                        menuItem("Source Code", icon = icon("github"), href = "https://github.com/[YourGitHubProfile]/HealthComplaintsDashboard")
                      )
                    ),
                    
                    # The body of the dashboard
                    dashboardBody(
                      tabItems(
                        # Overview Tab
                        tabItem(tabName = "overview",
                                h2(tags$b("Overview of Health Complaints in Indonesia")),
                                br(),
                                fluidRow(
                                  box(width = 12,
                                      solidHeader = T,
                                      background = "light-blue",
                                      sliderInput("dateRange", "Select Year Range:", 
                                                  min = 2009, max = 2023, value = c(2009, 2023), step = 1, sep = "")
                                  )
                                ),
                                fluidRow(
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("gender", "Select Gender:", 
                                                  choices = c("Male", "Female"), selected = "Male")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("area_type", "Select Area Type:", 
                                                  choices = c("Urban", "Rural", "Urban+Rural"), selected = "Urban"))
                                ),
                                fluidRow(
                                  box(width = 12, plotlyOutput("overviewPlot"))
                                )),
                        
                        # Trends Tab
                        tabItem(tabName = "trends",
                                h2(tags$b("Trends in Health Complaints Over the Years")),
                                br(),
                                fluidRow(
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("gender_trends", "Select Gender:", 
                                                  choices = c("Male", "Female"), selected = "Male")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("area_type_trends", "Select Area Type:", 
                                                  choices = c("Urban", "Rural", "Urban+Rural"), selected = "Urban")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("province_trends", "Select Province:", 
                                                  choices = levels(cleaned_dataset$Province))),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      sliderInput("year_trends", "Select Year Range:", 
                                                  min = 2009, max = 2023, value = c(2009, 2023), step = 1, sep = ""))
                                ),
                                fluidRow(
                                  box(width = 12, plotlyOutput("trendPlot"))
                                )),
                        
                        # Comparison Tab
                        tabItem(tabName = "comparison",
                                h2(tags$b("Comparison of Health Complaints Across Provinces")),
                                br(),
                                fluidRow(
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("gender_comp", "Select Gender:", 
                                                  choices = c("Male", "Female"), selected = "Male")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("area_type_comp", "Select Area Type:", 
                                                  choices = c("Urban", "Rural", "Urban+Rural"), selected = "Urban")),
                                  box(width = 12,
                                      solidHeader = T,
                                      background = "light-blue",
                                      sliderInput("year_comp", "Select Year Range:", 
                                                  min = 2009, max = 2023, value = c(2009, 2023), step = 1, sep = ""))
                                ),
                                fluidRow(
                                  box(width = 12, plotlyOutput("provincialPlot"))
                                )),
                        
                        # Distribution Tab
                        tabItem(tabName = "distribution",
                                h2(tags$b("Distribution of Health Complaints by Area Type and Gender")),
                                br(),
                                fluidRow(
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("gender_dist", "Select Gender:", 
                                                  choices = c("Male", "Female"), selected = "Male")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("area_type_dist", "Select Area Type:", 
                                                  choices = c("Urban", "Rural", "Urban+Rural"), selected = "Urban")),
                                  box(width = 12,
                                      solidHeader = T,
                                      background = "light-blue",
                                      sliderInput("year_dist", "Select Year Range:", 
                                                  min = 2009, max = 2023, value = c(2009, 2023), step = 1, sep = ""))
                                ),
                                fluidRow(
                                  box(width = 12, plotlyOutput("distributionPlot"))
                                )),
                        
                        # Heatmap Tab
                        tabItem(tabName = "heatmap",
                                h2(tags$b("Heatmap of Health Complaints Over the Years")),
                                br(),
                                fluidRow(
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("gender_heatmap", "Select Gender:", 
                                                  choices = c("Male", "Female"), selected = "Male")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("area_type_heatmap", "Select Area Type:", 
                                                  choices = c("Urban", "Rural", "Urban+Rural"), selected = "Urban")),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      selectInput("province_heatmap", "Select Province:", 
                                                  choices = levels(cleaned_dataset$Province))),
                                  box(width = 6,
                                      solidHeader = T,
                                      background = "light-blue",
                                      sliderInput("year_heatmap", "Select Year Range:", 
                                                  min = 2009, max = 2023, value = c(2009, 2023), step = 1, sep = ""))
                                ),
                                fluidRow(
                                  box(width = 12, plotlyOutput("heatmapPlot"))
                                )),
                        
                        # Data Table Tab
                        tabItem(tabName = "data_table",
                                fluidRow(
                                  box(width = 12, dataTableOutput(outputId = "table_data"))
                                ))
                      )
                    )
)

