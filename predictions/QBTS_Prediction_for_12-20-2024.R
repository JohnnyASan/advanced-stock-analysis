library(quantmod)
library(ggplot2)
library(tidyverse)
library(dplyr)

# Set the stock symbol and date
stock_symbol <- "QBTS"
prediction_date <- as.Date("2024-12-20")

# Get historical stock data
getSymbols(stock_symbol, src = "yahoo", from = "2020-01-01")
stock_data <- get(stock_symbol)

# Calculate daily returns
stock_returns <- dailyReturn(stock_data)

# Number of simulations and forecast days
num_simulations <- 10000
forecast_days <- as.numeric(prediction_date - Sys.Date())

# Monte Carlo simulation
set.seed(123)
simulations <- replicate(num_simulations, {
  simulated_prices <- rep(last(stock_data$QBTS.Adjusted), forecast_days)
  for (i in 2:forecast_days) {
    simulated_prices[i] <- simulated_prices[i-1] * exp(rnorm(1, mean = mean(stock_returns), sd = sd(stock_returns)))
  }
  last(simulated_prices)
})

# Create a data frame of the results
simulation_results <- data.frame(Price = simulations)

# Bin the prices and count occurrences, then select top 5 bins
simulation_results <- simulation_results %>%
  mutate(PriceBin = cut(Price, breaks = 50)) %>%
  group_by(PriceBin) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  head(15)

# Print the top 5 most likely price bins to console
print(simulation_results)

# Plot the probability distribution
ggplot(simulation_results, aes(x = PriceBin, y = Count)) +
  geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
  ggtitle(paste("Predicted Price Distribution for", stock_symbol, "on", prediction_date)) +
  xlab("Price Range") +
  ylab("Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
