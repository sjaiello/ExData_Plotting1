library("lubridate")
library("dplyr")

plotData <- read.csv("household_power_consumption.txt", 
                     sep = ";", na.strings = "?", skipNul = TRUE)

plotData[,"dateTime"] <-dmy_hms(paste(plotData$Date, plotData$Time))

plotData <- filter(plotData, dateTime >= dmy_hms("1/2/2007 00:00:00"),
                   dateTime  < dmy_hms("3/2/2007 00:00:00"))

png("plot4.png")

par(mfrow=c(2,2))

################################## Top Left ###################################

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Global_active_power)

plot(xrange, yrange, type="n",ylab = "Global Active Power",
     xlab = "")

lines(plotData$dateTime, plotData$Global_active_power, 
      type = "l", lwd = 1, lty = 1)

################################# Top Right ###################################

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Voltage)

plot(xrange, yrange, type="n",ylab = "Voltage",
     xlab = "datetime")

lines(plotData$dateTime, plotData$Voltage, 
      type = "l", lwd = 1, lty = 1)

################################ Bottom Left ##################################

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Sub_metering_1)

plot(xrange, yrange, type="n",ylab = "Energy sub mettering", xlab = "")

lines(plotData$dateTime, plotData$Sub_metering_1, col = "black", 
      type = "l", lwd = 1, lty = 1)

lines(plotData$dateTime, plotData$Sub_metering_2, col = "red",
      type = "l", lwd = 1, lty = 1)

lines(plotData$dateTime, plotData$Sub_metering_3, col = "blue",
      type = "l", lwd = 1, lty = 1)

legend("topright", lty=1, col=c("black", "red", "blue"), bty = "n", cex = .75,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       names(c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))[-1])

############################### Bottom Right ##################################

xrange <- range(plotData$dateTime)

yrange <- range(plotData$Global_reactive_power)

plot(xrange, yrange, type="n",ylab = "Global_reactive_power",
     xlab = "datetime", yaxt = "n")

axis(2, at = seq(0.0, 0.5, by = 0.1), las=2)

lines(plotData$dateTime, plotData$Global_reactive_power, 
      type = "l", lwd = 1, lty = 1)

dev.off()
