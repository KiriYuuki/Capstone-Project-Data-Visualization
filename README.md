# Capstone_Project_Data-Visualization


# What is the dashboard about?

The dashboard is about analyzing the percentage of the population experiencing health complaints across different provinces, area types (urban vs. rural), and genders in Indonesia from 2009 to 2023. The primary objective is to identify trends, patterns, and disparities in health complaints over time and across various demographics.

Problem Statement: The dashboard aims to provide insights into how health complaints vary by region, gender, and area type, which can help policymakers and healthcare providers target interventions more effectively.

Story to Tell: The story focuses on highlighting trends and disparities in health complaints, understanding which provinces or demographics are most affected, and tracking changes over time.


# Who is the user of your dashboard?

The primary users of this dashboard are policymakers, public health officials, and healthcare providers. These users need to make data-driven decisions to allocate resources, design interventions, and monitor the effectiveness of health programs.

User Level: Since the users are likely to be at a managerial or strategic level, the dashboard should be simple and general, providing a clear and quick overview of the insights.


# Why did I choose that data?

Apakah data yang dibuat relevan atau sesuai dengan tujuan? Mengapa?

The chosen data is relevant because it provides a comprehensive view of health complaints across different regions, genders, and area types over a significant period (2009-2023). This data can help answer questions about trends and disparities in health complaints, which are crucial for effective public health planning and resource allocation.

Variables: The variables (province, year, gender, area type, and percentage of health complaints) are directly related to the problem statement and can provide meaningful insights. The data's longitudinal nature allows for trend analysis over time.


# When is the data collected?

The data is collected annually from 2009 to 2023. Given the recent end date (2023), the data is still relevant for current analysis and decision-making. This period is sufficient to identify long-term trends and changes in health complaints.


# How does your dashboard answer your question, hypothesis, or problem you are trying to solve?

The dashboard uses appropriate plots to answer specific questions:
•	Line Plot: Visualizes trends in health complaints over time for selected provinces, years, genders, and area types.
• Bar Plot: Compares average health complaints across different provinces for selected years, genders, and area types.
• Box Plot: Shows the distribution of health complaints by area type and gender for selected provinces, years, genders, and area types.
• Heatmap: Visualizes the intensity of health complaints across provinces over time for selected years, genders, and area types.

These plots are chosen to provide clear and relevant insights into the trends and disparities in health complaints, directly addressing the problem statement and helping users make informed decisions.


Plot 1: Line Plot
```{r}
# Line Plot: Trends in health complaints over time
output$line_plot <- renderPlotly({
  data_filtered <- cleaned_healthcomplaints %>%
    filter(Year %in% input$year_range, Gender %in% input$select_gender, Area_Type %in% input$select_area_type)
  
  plot_line <- ggplot(data_filtered, aes(x = Year, y = Percentage, color = Province, group = Province)) +
    geom_line() +
    labs(title = "Trends in Health Complaints Over Time",
         x = "Year",
         y = "Percentage of Health Complaints") +
    theme_minimal()
  
  ggplotly(plot_line)
})
```

Plot 2: Bar Plot
```{r}
# Bar Plot: Compare health complaints across different provinces
output$bar_plot <- renderPlotly({
  data_filtered <- cleaned_healthcomplaints %>%
    filter(Year %in% input$year_range, Gender %in% input$select_gender, Area_Type %in% input$select_area_type) %>%
    group_by(Province) %>%
    summarise(Average_Percentage = mean(Percentage))
  
  plot_bar <- ggplot(data_filtered, aes(x = reorder(Province, Average_Percentage), y = Average_Percentage, fill = Province)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(title = "Average Health Complaints by Province",
         x = "Province",
         y = "Average Percentage of Health Complaints") +
    theme_minimal()
  
  ggplotly(plot_bar)
})
```

Plot 3: Box Plot
```{r}
# Box Plot: Distribution of health complaints by area type and gender
output$box_plot <- renderPlotly({
  data_filtered <- cleaned_healthcomplaints %>%
    filter(Year %in% input$year_range, Gender %in% input$select_gender, Area_Type %in% input$select_area_type)
  
  plot_box <- ggplot(data_filtered, aes(x = Area_Type, y = Percentage, fill = Gender)) +
    geom_boxplot() +
    labs(title = "Distribution of Health Complaints by Area Type and Gender",
         x = "Area Type",
         y = "Percentage of Health Complaints") +
    theme_minimal()
  
  ggplotly(plot_box)
})
```

Plot 4: Heatmap
```{r}
# Heatmap: Intensity of health complaints across provinces over time
output$heatmap_plot <- renderPlotly({
  data_filtered <- cleaned_healthcomplaints %>%
    filter(Year %in% input$year_range, Gender %in% input$select_gender, Area_Type %in% input$select_area_type)
  
  plot_heatmap <- ggplot(data_filtered, aes(x = Year, y = Province, fill = Percentage)) +
    geom_tile() +
    labs(title = "Intensity of Health Complaints Across Provinces Over Time",
         x = "Year",
         y = "Province") +
    theme_minimal()
  
  ggplotly(plot_heatmap)
})
```


# Where do you put your plot, valuebox, input, etc?
Layout Design:
- Header: Title and brief description of the dashboard.
- Sidebar: Filters for year, gender, and area type.
- Main Panel:
a. Page 1: Overview - Summary statistics and overall trends.
b. Page 2: Trends Over Time - Line plots showing trends over the years.
c. Page 3: Provincial Comparison - Bar plots comparing health complaints across provinces.
d. Page 4: Distribution Analysis - Box plots showing the distribution of health complaints by area type and gender.
e. Page 5: Heatmap - Heatmap showing the intensity of health complaints across provinces over time.
