library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim = ";", na = c("?"))
png(file = "plot2.png")

data <- data %>%
        filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
        mutate(Date = paste(Date, Time, sep = "-")) %>%
        mutate(Date = as_datetime(strptime(Date, format = "%d/%m/%Y-%H:%M:%S")))

with(data, plot(Date, 
                Global_active_power, 
                type = "n", 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)"))

with(data, lines(Date,
                 Global_active_power))

dev.off()     


