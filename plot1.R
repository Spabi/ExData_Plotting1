library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim = ";", na = c("?"))
png(file = "plot1.png")

data <- data %>%
        filter(Date %in% c("1/1/2007", "2/1/2007")) %>%
        mutate(Date = paste(Date, Time, sep = "-")) %>%
        mutate(Date = as_datetime(strptime(Date, format = "%d/%m/%Y-%H:%M:%S")))

with(data, hist(Global_active_power, 
                col = "red", 
                main = "Global Active Power", 
                xlab = "Global Active Power (kilowatts)"))

dev.off()
