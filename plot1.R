library("lubridate")
library("dplyr")

plotData <- read.csv("household_power_consumption.txt", 
                     sep = ";", na.strings = "?", skipNul = TRUE)

plotData[,"dateTime"] <-dmy_hms(paste(plotData$Date, plotData$Time))

plotData <- filter(plotData, dateTime >= dmy_hms("1/2/2007 00:00:00"), 
                   dateTime  < dmy_hms("3/2/2007 00:00:00"))

png("plot1.png")

hist(as.numeric(plotData$Global_active_power), 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red", breaks = 25, main = "Global Active Power")

dev.off()
