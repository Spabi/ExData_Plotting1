library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim = ";", na = c("?"))
png(file = "plot3.png")

data <- data %>%
        filter(Date %in% c("1/1/2007", "2/1/2007")) %>%
        mutate(Date = paste(Date, Time, sep = "-")) %>%
        mutate(Date = as_datetime(strptime(Date, format = "%d/%m/%Y-%H:%M:%S")))

with(data, plot(Date, Sub_metering_3, 
                type = "n", 
                xlab = "",
                ylab = "Energy sub meetering",
                ylim = c(0,30)))
with(data, lines(Date, Sub_metering_3, col = "blue"))
with(data, lines(Date, Sub_metering_2, col = "red"))
with(data, lines(Date, Sub_metering_1, col = "black"))
legend("topright", 
       legend = c("sub_meetering_1", "sub_meetering_2", "sub_meetering_3"),
       col = c("black", "red", "blue"),
       lwd = c(2, 2, 2))

dev.off()
