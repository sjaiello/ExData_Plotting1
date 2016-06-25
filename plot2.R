library("lubridate")
library("dplyr")

plotData <- read.csv("household_power_consumption.txt", 
                     sep = ";", na.strings = "?", skipNul = TRUE)

plotData[,"dateTime"] <-dmy_hms(paste(plotData$Date, plotData$Time))

plotData <- filter(plotData, dateTime >= dmy_hms("1/2/2007 00:00:00"), 
                   dateTime  < dmy_hms("3/2/2007 00:00:00"))

png("plot2.png")

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Global_active_power)

plot(xrange, yrange, type="n",ylab = "Global Active Power (kilowatts)",
     xlab = "")

lines(plotData$dateTime, plotData$Global_active_power, 
      type = "l", lwd = 1, lty = 1)

dev.off()
