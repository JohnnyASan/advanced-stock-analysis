# Overview

This project is meant to analyze stock data to predict sectors with the highest profit over the next decade. This will be written purely in R language.

This utilizes historical stock market data across all sectors. It also uses more recent data for QBTS to predict returns on a single stock.

The stock market is synonymous with both risk and reward. The purpose of this project stems from my interest in stocks and what makes them move. I hope to more reliably predict reward while limiting risk.

[Software Demo Video](https://youtu.be/niOgUjFcYVw)

# Data Analysis Results

1. What features do fundamentals share across stocks when they start to make long-term gains? 
    Through my basic analysis, it seems companies with an age of at least 5 years and more than a dozen employees are reasonably reliable.
2. Which sector will be most profitable over the next decade?
    According to my script, technology is the most profitable sector. That was my original hypothesis, but it's interesting to see the forecast actually executed.

# Development Environment

## Tools for Development
- Windows 10
- RStudio

## Programming language and libraries
- R
- quantmod
- ggplot
- forecast
- dplyr
- tidyverse

# Useful Websites

* [Yahoo Finance](https://finance.yahoo.com/markets/stocks/most-active/) 
* [Monte Carlo Simulation in R](https://www.programmingr.com/monte-carlo-simulation-in-r/)

# Future Work

* Add different types of simulations for later comparison
* Update graphs/visuals to be more user friendly
* Include more components than just price and volume for more complex simulations. For example, include a randomness of news breaks.