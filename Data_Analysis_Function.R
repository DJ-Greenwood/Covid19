data_analysis <- function(file_path) {
  # Load necessary libraries
  library(ggplot2)
  library(dplyr)
  library(readr)
  library(corrplot)
  library(RColorBrewer)
  
  # Step 1: Load Data
  load_data <- function(file_path) {
    data <- read_csv(file_path)
    return(data)
  }
  
  # Step 2: Clean Data
  clean_data <- function(data) {
    # Example cleaning steps: remove NA, correct data types, etc.
    data <- data %>%
      filter_all(all_vars(!is.na(.))) %>%
      mutate_if(is.character, as.factor)
    return(data)
  }
  
  # Step 3: Exploratory Data Analysis
  exploratory_data_analysis <- function(data) {
    # Summary Statistics
    summary_stats <- summary(data)
    print(summary_stats)
    
    # Plot distributions of numeric variables
    numeric_cols <- sapply(data, is.numeric)
    data_numeric <- data[, numeric_cols]
    for (col in colnames(data_numeric)) {
      ggplot(data, aes_string(x = col)) +
        geom_histogram(binwidth = 10, fill = "lightblue1", color = "black") +
        labs(title = paste("Distribution of", col)) +
        theme_minimal() +
        print()
    }
  }
  
  # Step 4: Correlation Analysis
  correlation_analysis <- function(data) {
    # Calculate correlation matrix for numeric columns
    numeric_cols <- sapply(data, is.numeric)
    data_numeric <- data[, numeric_cols]
    cor_matrix <- cor(data_numeric, use = "complete.obs")
    
    # Visualize correlation matrix
    col_palette <- colorRampPalette(c("white", "lightblue1", "blue"))(200)
    corrplot(cor_matrix, method = "color", type = "upper", order = "hclust",
             col = col_palette, tl.col = "black", tl.srt = 45, addCoef.col = "black")
  }
  
  # Step 5: Basic Statistical Analysis
  basic_statistical_analysis <- function(data) {
    # Example: t-test for a numeric variable between two groups
    if ("Species" %in% colnames(data)) {
      t_test_result <- t.test(Wing_Span ~ Species, data = data)
      print(t_test_result)
    }
  }
  
  # Main function body
  data <- load_data(file_path)
  data <- clean_data(data)
  exploratory_data_analysis(data)
  correlation_analysis(data)
  basic_statistical_analysis(data)
  
  return(data)
}

# Example usage
# data_analysis("pelican_data.csv")
