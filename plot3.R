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
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))

#set device
png(filename = "plot3.png", width = 480, height = 480, units = "px")

#plot
par(mfcol = c(1, 1), mar = c(4, 4, 2, 1))
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
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close device
dev.off()