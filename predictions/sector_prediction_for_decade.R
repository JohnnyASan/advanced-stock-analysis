library(quantmod)
library(ggplot2)
library(forecast)

# Define the sectors and their corresponding ETFs
sectors <- c("Technology" = "XLK",
             "Healthcare" = "XLV",
             "Financial" = "XLF",
             "Consumer Discretionary" = "XLY",
             "Consumer Staples" = "XLP",
             "Energy" = "XLE",
             "Industrials" = "XLI",
             "Materials" = "XLB",
             "Utilities" = "XLU",
             "Real Estate" = "XLRE")

# Download historical data for each sector ETF
get_sector_data <- function(etf) {
  getSymbols(etf, src = "yahoo", from = "2000-01-01", auto.assign = FALSE)
}

# Calculate annual returns
calculate_annual_returns <- function(data) {
  yearly_returns <- periodReturn(data, period = "yearly", type = "log")
  return(yearly_returns)
}

# Forecast returns over next decade
forecast_returns <- function(returns, h = 10) {
  fit <- auto.arima(returns)
  forecasted <- forecast(fit, h = h)
  return(forecasted)
}

sector_forecasts <- list()

# Iterate over stock market sectors to perform calculations
for (sector in names(sectors)) {
  etf <- sectors[sector]
  data <- get_sector_data(etf)
  annual_returns <- calculate_annual_returns(Cl(data))
  forecasted_returns <- forecast_returns(annual_returns)
  sector_forecasts[[sector]] <- forecasted_returns
}

# Plot the forecasts
plot_sector_forecasts <- function(forecasts, sector) {
  plot(forecasts, main = sector)
  grid()
}

# Plot all sector forecasts
par(mfrow = c(2, 5))  # Adjust layout for multiple plots
for (sector in names(sector_forecasts)) {
  plot_sector_forecasts(sector_forecasts[[sector]], sector)
}

# Determine the sector with the highest average forecasted return
average_forecasted_returns <- sapply(sector_forecasts, function(x) mean(x$mean))
best_sector <- names(average_forecasted_returns)[which.max(average_forecasted_returns)]
cat("The sector with the highest average forecasted return over the next decade is:", best_sector, "\n")
