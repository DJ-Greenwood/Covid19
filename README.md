## COVID19 Analysis of Johns Hopkins Data set

## Description of the Data Resource

The Johns Hopkins Corona-virus Resource Center established a new standard for infectious disease tracking by publicly providing pandemic data in near real-time. It began on January 22, 2020, as the COVID-19 Dashboard, operated by the Center for Systems Science and Engineering (CSSE) and the Applied Physics Laboratory. This is the dataset that will be used for this analysis. The Corona-virus Resource Center ceased its data collection as of March 2022. Further information can be found at this [website](https://coronavirus.jhu.edu/).

### Objective

The objective of this analysis is to explore the COVID-19 dataset from Johns Hopkins University. The data set contains information on confirmed cases, deaths, and recoveries for countries around the world. The analysis will focus on visualizing the data, identifying trends, and gaining insights into the spread of the virus.

### Data Collection

The dataset used in this analysis is sourced from the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE) COVID-19 Data Repository. We are concerned with the time series data for confirmed cases, deaths, and recoveries at the global level and for the United States. This data can be found at the following GitHub [location](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).

### Data Description

The following is a list of the data sets that we downloaded from the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE) COVID-19 Data Repository:

-   global_confirmed_transformed: Time series data for confirmed COVID-19 cases at the global level.
-   global_deaths: Time series data for COVID-19 deaths at the global level.
-   global_recovered: Time series data for COVID-19 recoveries at the global level.
-   us_confirmed: Time series data for confirmed COVID-19 cases in the United States.
-   us_deaths: Time series data for COVID-19 deaths in the United States.

## Data Overview

We have loaded the data into data frames for further analysis. Let's examine the structure of the data sets to understand the columns and the first few rows of each data frame. The global data sets include global_confirmed, global_deaths, and global_recovered, while the US data sets include us_confirmed and us_deaths.

The title of each table displays the number of columns and rows in the dataset. The U.S. data sets contain case and death counts, with the us_deaths dataset also including the population of each county in the U.S. The extensive list of reporting dates, which contain the daily case counts, deaths, and recoveries (for the global data sets), and the daily case counts and deaths (for the U.S. data sets) are not displayed in their entirety.

## Data Cleaning and Transformation

We will change the global data sets (confirmed, deaths, and recovered) to have the same columns: Province_State, Country_Region, date, cases, deaths, recovered, Lat, and Long. We will also change the US data sets (confirmed and deaths) by renaming Long\_ to Long to match the global data sets. The last change will be to rename Admin2 to County in the US data sets. These changes will create a common structure for all data sets.

## Data Transformation Summary

In this section, we describe the steps taken to transform the data for analysis. The process involves renaming columns, reshaping data, converting date formats, and aggregating data for both global and U.S. data sets Below is a detailed explanation of each transformation step:

### Renaming Columns

To ensure consistency and clarity across the data sets, we checked and renamed certain columns. For the global data sets, we renamed "Province/State" to "Province_State" and "Country/Region" to "Country_Region". For the U.S. data sets, we renamed "Admin2" to "County" and "Long\_" to "Long". This was achieved using a custom function that checks for the presence of old column names and renames them if they exist.

### Reshaping Data

We reshaped the data sets from a wide format to a long format to facilitate time series analysis. This restructuring allowed us to represent each date's data as individual rows, which is more suitable for temporal analysis.

### Date Conversion

We converted the date columns to the Date type to enable accurate date-based operations and analyses.

### Combining Data Sets

For the global data, we combined the confirmed, deaths, and recovered data sets into a single dataset using full joins. This combined dataset contains information on cases, deaths, and recoveries for each location and date.

For the U.S. data, we combined the confirmed and deaths data sets. We then aggregated the data at the county and state levels, as well as at the country level. We calculated additional metrics such as deaths per million population, and for the state and county data, we also computed new cases and new deaths by calculating the differences between consecutive dates.

### Summary of Transformed Data

The following tables display samples of the transformed data sets. The first table shows a sample of the combined global data, and the second table shows a sample of the aggregated U.S. data by county and state.

## Summary of Total Cases, Deaths, and Recoveries

This summary provides an overview of the total cases, deaths, and recoveries for both the global dataset and the U.S. dataset. The global dataset encompasses data from all countries, while the U.S. dataset includes data from all states and counties within the United States.

For the global dataset, the total number of recovered cases is counted up to December 13, 2020. The total recovered cases are determined by subtracting the total deaths from the total cases. The figures for total cases, deaths, and recoveries are presented in the table below.

## Visualizing the Data

These graphs show the actual cases in blue, the linear regression line in red, and the smooth curve in green. The first graph displays the global COVID-19 cases over time, while the second graph shows the U.S. COVID-19 cases over time. The linear regression line and smooth curve provide insights into the trends and patterns of the data.

## Comparative Analysis

This graph shows the reported number of cases for different countries over time. The countries included in the analysis are the United States, India, Brazil, China, Russia, and Australia. The graph provides a visual comparison of the COVID-19 cases in these countries and highlights the differences in the number of cases reported over time.

## Statistical Analysis

The linear regression model aims to predict the total number of deaths based on the total number of cases. The model's summary shows a very high correlation between the two variables, with an R-squared value of 0.8512, indicating that approximately 85.12% of the variability in total deaths can be explained by the total cases. The coefficient for total cases is 0.01343, meaning that for every additional case, there is an associated increase of approximately 0.01343 deaths. This coefficient is highly significant (p-value \< 2e-16), suggesting a strong relationship between total cases and total deaths. The residuals indicate some variability, with a residual standard error of 28,240,000, showing the model's accuracy and the spread of residuals around the fitted values. The F-statistic of 1139 and its associated p-value (\< 2.2e-16) further confirm the model's overall significance.

## Predictive Model

Using the data, we developed a predictive model to forecast future COVID-19 cases and deaths. This model will help anticipate the future burden on healthcare systems and inform public health interventions.

The predictive model is based on a linear regression approach, where the total cases are used to predict the total deaths. The model's performance is evaluated using the post-resampling method, which provides metrics such as RMSE, MAE, and R-squared to assess the model's accuracy.

## Bias Considerations

It is important to consider potential biases in the data and analysis. The dataset may underreport cases and deaths due to limited testing and reporting inconsistencies across different regions. Additionally, the model's predictions are based on historical data, which may not fully capture future changes in virus transmission dynamics, public health interventions, or population behavior.

## Limitations

This analysis has several limitations that should be considered when interpreting the results. The data is subject to reporting delays, inconsistencies, and inaccuracies, which can affect the accuracy of the analysis. The predictive model developed in this analysis is based on historical data and may not account for future changes in the pandemic. The model's assumptions, such as linearity and independence of variables, may not hold in practice, leading to potential errors in the predictions.

## Conclusion

This analysis provides a comprehensive overview of the COVID-19 pandemic using the Johns Hopkins dataset. By transforming, visualizing, and analyzing the data, we gained insights into the global and U.S. spread of the virus, the impact on different countries, and the relationship between confirmed cases and deaths.

The predictive model developed in this analysis helps us understand the future burden of COVID-19 and inform public health interventions. However, it is essential to consider the limitations and biases in the data and analysis when interpreting the results. Further research and data collection are needed to improve the accuracy and reliability of COVID-19 analyses and predictions.

## Future Considerations

Expand the analysis to include additional variables such as vaccination rates, testing capacity, and public health measures to provide a more comprehensive understanding of the pandemic. Incorporate machine learning algorithms to develop more sophisticated predictive models that can capture the complex dynamics of the virus spread. Collaborate with public health agencies and researchers to validate the findings and ensure the analysis is aligned with current scientific knowledge and best practices.

## Reproducibility

To ensure the reproducibility of this analysis, the following steps can be followed:

1.  Download the latest version of R and RStudio.
2.  Install the required packages as listed in the "load libraries" section.
3.  Download the dataset from the Johns Hopkins University Center for Systems Science and Engineering (JHU CSSE) COVID-19 Data Repository.
4.  Run the R script provided in this document.
5.  Save the session information to verify the environment in which the analysis was conducted.
