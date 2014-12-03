library(dplyr)
library(lubridate)

#read and clean data
data <- read.table("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
data$Date <- dmy(data$Date)
date1 <- dmy("01-02-2007")
date2 <- dmy("02-02-2007")
dat1 <- filter(data, Date == date1)
dat2 <- filter(data, Date == date2)
filtered <- rbind(dat1, dat2)
filtered <- mutate(filtered, datetime = paste(Date, Time))
filtered$Time <- hms(filtered$Time)
filtered$datetime <- ymd_hms(filtered$datetime)

#creating and printing the actual graph
png(filename = "plot4.png")
par(mfrow = c(2,2))
with(filtered, {
  
  plot(datetime, Global_active_power,
       type = "l", xlab="", ylab="Global Active Power (kilowatts)")
  
  plot(datetime, Voltage, type = "l", xlab="", ylab="Voltage")
  
  plot(c(filtered$datetime, filtered$datetime, filtered$datetime), 
       c(filtered$Sub_metering_1, filtered$Sub_metering_2, 
         filtered$Sub_metering_3), type = "l", xlab = "", ylab="Energy sub metering")
      with(subset(filtered, TRUE), lines(filtered$datetime, filtered$Sub_metering_2, col = "red"))
      with(subset(filtered, TRUE), lines(filtered$datetime, filtered$Sub_metering_3, col = "blue"))
      legend("topright", lty = 1, cex = 0.7, bty = "n", col = c("black", "blue", "red"),
          legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(datetime, Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()
  
})