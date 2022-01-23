library(readr)
library(tidyverse)
library(dplyr)
library(lubridate)

data <- read_delim("household_power_consumption.txt", delim = ";", na = c("?"))
png(file = "plot4.png")

data <- data %>%
        filter(Date %in% c("1/1/2007", "2/1/2007")) %>%
        mutate(Date = paste(Date, Time, sep = "-")) %>%
        mutate(Date = as_datetime(strptime(Date, format = "%d/%m/%Y-%H:%M:%S")))

# set up plotting grid
par(mfrow = c(2,2))

# first plot (1,1)
with(data, plot(Date, 
                Global_active_power,
                xlab = "",
                ylab = "Global Active Power",
                cex.lab = .9,
                type = "n"))
with(data, lines(Date,
                 Global_active_power))

# second plot (1,2)
with(data, plot(Date,
                Voltage,
                xlab = "datetime",
                ylab = "Voltage",
                cex.lab = .9,
                type = "n"))
with(data, lines(Date,
                 Voltage))

# third plot (2, 1)
with(data, plot(Date,
                Sub_metering_3,
                xlab = "",
                ylab = "Energy sub metering",
                cex.lab = .9,
                ylim = c(0, 30),
                type = "n"))
with(data, lines(Date,
                 Sub_metering_1))
with(data, lines(Date,
                 Sub_metering_2,
                 col = "red"))
with(data, lines(Date,
                 Sub_metering_3,
                 col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = c(2, 2, 2),
       cex = .9,
       bty = "n")

# fourth plot
with(data, plot(Date,
                Global_reactive_power,
                xlab = "datetime",
                ylab = "Global_reactive_power",
                cex.lab = .9,
                type = "n"))
with(data, lines(Date,
                 Global_reactive_power))


dev.off()

