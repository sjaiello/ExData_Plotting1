library("lubridate")
library("dplyr")

plotData <- read.csv("household_power_consumption.txt", 
                     sep = ";", na.strings = "?", skipNul = TRUE)

plotData[,"dateTime"] <-dmy_hms(paste(plotData$Date, plotData$Time))

plotData <- filter(plotData, dateTime >= dmy_hms("1/2/2007 00:00:00"),
                   dateTime  < dmy_hms("3/2/2007 00:00:00"))

png("plot3.png")

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Sub_metering_1)

plot(xrange, yrange, type="n",ylab = "Energy sub mettering", xlab = "")

lines(plotData$dateTime, plotData$Sub_metering_1, col = "black", 
      type = "l", lwd = 1, lty = 1)

lines(plotData$dateTime, plotData$Sub_metering_2, col = "red",
      type = "l", lwd = 1, lty = 1)

lines(plotData$dateTime, plotData$Sub_metering_3, col = "blue",
      type = "l", lwd = 1, lty = 1)

legend("topright", lty=1, col=c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       names(c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))[-1])

dev.off()
