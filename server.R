# server.R

server <- function(input, output) { 
  
  showNotification("Interactive Health Complaints Dashboard created by Yuanda Krisna", duration = NULL, type = "message")
  
  # Reactive data for overview
  reactive_data_overview <- reactive({
    cleaned_dataset %>%
      filter(Year >= input$dateRange[1], Year <= input$dateRange[2],
             Gender == input$gender, Area_Type == input$area_type)
  })
  
  # Reactive data for trends
  reactive_data_trends <- reactive({
    cleaned_dataset %>%
      filter(Year >= input$year_trends[1], Year <= input$year_trends[2],
             Gender == input$gender_trends, Area_Type == input$area_type_trends,
             Province == input$province_trends)
  })
  
  # Reactive data for comparison
  reactive_data_comparison <- reactive({
    cleaned_dataset %>%
      filter(Year >= input$year_comp[1], Year <= input$year_comp[2],
             Gender == input$gender_comp, Area_Type == input$area_type_comp)
  })
  
  # Reactive data for distribution
  reactive_data_distribution <- reactive({
    cleaned_dataset %>%
      filter(Year >= input$year_dist[1], Year <= input$year_dist[2],
             Gender == input$gender_dist, Area_Type == input$area_type_dist)
  })
  
  # Reactive data for heatmap
  reactive_data_heatmap <- reactive({
    cleaned_dataset %>%
      filter(Year >= input$year_heatmap[1], Year <= input$year_heatmap[2],
             Gender == input$gender_heatmap, Area_Type == input$area_type_heatmap,
             Province == input$province_heatmap)
  })
  
  # Overview Plot (Bar Chart)
  output$overviewPlot <- renderPlotly({
    plot_data <- reactive_data_overview()
    
    # Define a custom color palette
    custom_colors <- colorRampPalette(c("#00B9AD", "#CDDC29"))(length(unique(plot_data$Province)))
    
    plot <- ggplot(plot_data, aes(x = Province, y = Percentage, fill = Province)) +
      geom_bar(stat = "identity", position = "dodge") +
      xlab("Province") +
      ylab("Percentage") +
      ggtitle(paste("Health Complaints in", paste(range(input$dateRange), collapse = "-"), 
                    "(", input$gender, "-", input$area_type, ")")) +
      theme_minimal(base_family = "Arial", base_size = 15) +
      theme(plot.title = element_text(color = "#60C0D0"), axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_fill_manual(values = custom_colors)
    
    ggplotly(plot)
  })
  
  # Trend Plot
  output$trendPlot <- renderPlotly({
    plot_data <- reactive_data_trends()
    
    plot <- ggplot(plot_data, aes(x = Year, y = Percentage, color = Province)) +
      geom_line(linewidth = 1) +
      xlab("Year") +
      ylab("Percentage") +
      ggtitle(paste("Trends in Health Complaints (", input$gender_trends, "-", input$area_type_trends, ") Over the Years")) +
      theme_minimal(base_family = "Arial", base_size = 15) +
      theme(plot.title = element_text(color = "#60C0D0"), axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_color_discrete()
    
    ggplotly(plot)
  })
  
  # Provincial Comparison Plot
  output$provincialPlot <- renderPlotly({
    plot_data <- reactive_data_comparison()
    
    # Define a custom color palette
    custom_colors <- colorRampPalette(c("#00B9AD", "#CDDC29"))(length(unique(plot_data$Province)))
    
    plot <- ggplot(plot_data, aes(x = Province, y = Percentage, fill = Province)) +
      geom_bar(stat = "identity") +
      xlab("Province") +
      ylab("Percentage") +
      ggtitle(paste("Health Complaints Across Provinces (", input$gender_comp, ", ", 
                    paste(range(input$year_comp), collapse = "-"), ")")) +
      theme_minimal(base_family = "Arial", base_size = 15) +
      theme(plot.title = element_text(color = "#60C0D0"), axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_fill_manual(values = custom_colors)
    
    ggplotly(plot)
  })
  
  # Distribution Analysis Plot
  output$distributionPlot <- renderPlotly({
    plot_data <- reactive_data_distribution()
    
    plot <- ggplot(plot_data, aes(x = Year, y = Percentage, fill = Area_Type)) +
      geom_boxplot() +
      xlab("Year") +
      ylab("Percentage") +
      ggtitle(paste("Distribution of Health Complaints by Area Type and Gender (", 
                    paste(range(input$year_dist), collapse = "-"), ")")) +
      theme_minimal(base_family = "Arial", base_size = 15) +
      theme(plot.title = element_text(color = "#60C0D0"), axis.text.x = element_text(angle = 45, hjust = 1)) +
      scale_fill_manual(values = c("Urban" = "#CDDC29", "Rural" = "#00B9AD", "Urban+Rural" = "#60C0D0"))
    
    ggplotly(plot)
  })
  
  # Heatmap Plot
  output$heatmapPlot <- renderPlotly({
    plot_data <- reactive_data_heatmap()
    
    plot <- ggplot(plot_data, aes(x = Year, y = Province, fill = Percentage)) +
      geom_tile() +
      scale_fill_gradient(low = "#CDDC29", high = "#00B9AD") +
      xlab("Year") +
      ylab("Province") +
      ggtitle(paste("Heatmap of Health Complaints (", input$gender_heatmap, "-", input$area_type_heatmap, ") Over the Years")) +
      theme_minimal(base_family = "Arial", base_size = 15) +
      theme(plot.title = element_text(color = "#60C0D0"), axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(plot)
  })
  
  # Data Table
  output$table_data <- renderDataTable({
    datatable(data = cleaned_dataset,
              options = list(scrollX = TRUE))
  })
}
