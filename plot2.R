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

#set device
png(filename = "plot2.png", width = 480, height = 480, units = "px")

#plot
par(mfcol = c(1, 1), mar = c(4, 4, 2, 1))
with(df, plot(Global_active_power,
              type = "n",
              xlab = "",
              ylab = "Global Active Power (kilowatts)",
              xaxt = "n"))
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
lines(df$Global_active_power)

#close device
dev.off()