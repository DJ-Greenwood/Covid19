# Url path
url_in <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/4360e50239b4eb6b22f3a1759323748f36752177/csse_covid_19_data/csse_covid_19_time_series/"
url_in_us_confirmed <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv"

# File names
file_names <-
  c(
    "time_series_covid19_confirmed_global.csv",
    "time_series_covid19_deaths_US.csv",
    "time_series_covid19_deaths_global.csv",
    "time_series_covid19_recovered_global.csv",
    ""
    )

# Concatenate URL and file name
urls <- str_c(url_in,file_names)


# read Files
global_confirmed <- read_csv(urls[1])
global_deaths <- read_csv(urls[3])
global_recovered <- read_csv(urls[4])
us_confirmed <- read_csv(url_in_us_confirmed)
us_deaths <- read_csv(urls[2])

# Tidy up the global data 
global_confirmed <- global_confirmed %>%
  pivot_longer(cols = -c(`Province/State`, 
                         'Country/Region', Lat, Long),
               names_to = 'date',
               values_to = 'cases') %>%
  select(-c(Lat, Long))

global_deaths <- global_deaths %>%
  pivot_longer(cols = -c('Province/State',
                         'Country/Region', Lat, Long),
               names_to = 'date',
               values_to = 'deaths') %>%
  select(-c(Lat, Long))

global_recovered <- global_recovered %>%
  pivot_longer(cols = -c('Province/State', 
                         'Country/Region', Lat, Long),
               names_to = 'date',
               values_to = 'recovered') %>%
  select(-c(Lat, Long))

# This section is to count the number of cases for the us_confirmed data set.
# This data set did not have a case count to begin 
# List of non-date columns
us_confirmed_non_date_columns <- c("UID", "iso2", "iso3", "code3", "FIPS", "Admin2", 
                                   "Province_State", "Country_Region", "Lat", "Long_", "Combined_Key")

# List of non-date columns
us_deaths_non_date_columns <- c("UID", "iso2", "iso3", "code3", "FIPS", "Admin2", 
                                "Province_State", "Country_Region", "Lat", "Long_", "Combined_Key", "Population")

# Pivot longer to reshape the data
us_confirmed_long <- us_confirmed %>%
  pivot_longer(cols = -all_of(us_confirmed_non_date_columns), names_to = "date", values_to = "cases")%>%
  select(-c(UID, iso2, iso3, code3, FIPS, Lat, Long_))

us_deaths_long <- us_deaths %>%
  pivot_longer(col = -all_of(us_deaths_non_date_columns), names_to =  "date", values_to = "deaths")%>%
  select(-c(UID, iso2, iso3, code3, FIPS, Lat, Long_))

# Combining data 
global <- global_confirmed %>% 
  full_join(global_deaths)%>%
  rename(Country_Region = 'Country/Region',
         Province_State = 'Province/State') %>%
  mutate(date = mdy(date))


# Filter global by cases > 0
global <- global %>% filter(cases > 0)

# Combine US data 
US <- us_confirmed_long %>%
  full_join(us_deaths_long)

# Groupded by states, county
US_by_state <- US %>%
  mutate(date = as.Date(date, format = "%m/%d/%y"))%>% 
  group_by(Admin2, Province_State, Country_Region, date)%>%
  summarize(cases = sum(cases), deaths = sum(deaths),
            Population = sum(Population))%>%
  mutate(deaths_per_mill = deaths *1000000/Population)%>%
  select(Admin2, Province_State, Country_Region, date, cases, deaths, deaths_per_mill, Population)%>%
  ungroup()

# Grouped by Country
US_by_country <- US %>%
  mutate(date = as.Date(date, format = "%m/%d/%y" )) %>%  # Ensure date is a Date object
  group_by(Country_Region, date) %>%
  summarize(cases = sum(cases), deaths = sum(deaths),
            Population = sum(Population), .groups = 'drop') %>%
  mutate(deaths_per_mill = deaths * 1000000 / Population) %>%
  select(Country_Region, date, cases, deaths, deaths_per_mill, Population) %>%
  ungroup()

# Add new cases to the US_by_state and US_by_country dataframes
US_by_country <- US_by_country %>%
  mutate(new_cases = cases - lag(cases),
         new_deaths = deaths - lag(deaths))

US_by_state <- US_by_state %>%
  mutate(new_cases = cases - lag(cases),
         new_deaths = deaths - lag(deaths))
  
  
  
# Assuming US_by_state is your dataframe

# Filter out non-positive cases and deaths
US_by_state_filtered <- US_by_state %>%
  filter(cases > 0, deaths > 0)

# Print the first few rows of the data
print(head(US_by_state_filtered))


# Assuming max_cases is already defined
max_cases <- max(US_by_state_filtered$cases, na.rm = TRUE)

# Plot the data
US_by_state_filtered %>%
  ggplot(aes(x = date)) +
  geom_line(aes(y = cases, color = "Cases")) +
  geom_point(aes(y = cases, color = "Cases")) +
  geom_line(aes(y = deaths, color = "Deaths")) +
  geom_point(aes(y = deaths, color = "Deaths")) +
  scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x))+
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "COVID-19 in the US", 
       x = "Date", 
       y = "Count", 
       color = "Metric") +
  scale_color_manual(values = c("Cases" = "blue", "Deaths" = "red")) +
  geom_vline(xintercept = max(US_by_state_filtered$date), linetype = "dashed") +
  annotate("text", x = max(US_by_state_filtered$date), y = max_cases, 
           label = "Today", vjust = -1, hjust = 1)

US_by_state_filtered <- U%>%
  group_by(Province_State == "Oklahoma") %>%
  summarize(max_cases = max(cases), max_deaths = max(deaths),
            population = max(Population),
            cases_per_thou = 1000 * cases / population,
            deaths_per_thou = 1000 * deaths / population) %>%
  filter(cases>0, deaths>0)
  
