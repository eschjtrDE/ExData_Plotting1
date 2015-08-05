library(lubridate)

# read data
d = read.csv("./household_power_consumption.csv", sep = ";")

# filter for dates: 1/2/2007 & 2/2/2007
req_dates <- dmy(d$Date) %in% dmy(c("1/2/2007","2/2/2007"))
sum(req_dates)
df <- d[req_dates,]

# free memory - remove the original data frame
rm(d)

# tidy data
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

#set device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

#plot 
par(mfcol = c(2, 2), mar = c(4, 4, 3, 2))

#plot 1
with(df, plot(Global_active_power,
              type = "n",
              xlab = "",
              ylab = "Global Active Power",
              xaxt = "n"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
lines(df$Global_active_power)

#plot 2
with(df, plot(Sub_metering_1,
              type = "n",
              xlab = "",
              ylab = "Energy sub metering",
              xaxt = "n"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
lines(df$Sub_metering_1)
lines(df$Sub_metering_2, col = "red")
lines(df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red", "blue"),
       bty = "n",
       legend = c("Sub_metering_1 ", "Sub_metering_2 ", "Sub_metering_3 "))

#plot 3
with(df, plot(Voltage,
              type = "n",
              xlab = "datetime",
              ylab = "Voltage",
              xaxt = "n"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
lines(df$Voltage)

#plot 4
with(df, plot(Global_reactive_power,
              type = "n",
              xlab = "datetime",
              ylab = "Global_reactive_power",
              xaxt = "n"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
lines(df$Global_reactive_power, lwd = 0)

#close device
dev.off()