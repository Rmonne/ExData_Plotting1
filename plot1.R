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
png(filename = "plot1.png")
hist(filtered$Global_active_power,
     col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()