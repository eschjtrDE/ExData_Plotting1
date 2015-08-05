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
png(filename = "plot1.png", width = 480, height = 480, units = "px")

#plot
par(mfcol = c(1, 1), mar = c(4, 4, 2, 1))
hist(df$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

#close device
dev.off()