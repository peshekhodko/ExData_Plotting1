# reading data from local file
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=F)

# cleaning initially read data
data[data == "?"] <- NA
data <- na.omit (data)

# subsetting data and converting data in columns to necessary types
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data2 <- subset(data[data$Date>=as.Date("01/02/2007", "%d/%m/%Y") & data$Date<=as.Date("02/02/2007", "%d/%m/%Y"), ])
data2$Date <- paste (data2$Date, data2$Time, " ")
data2$Date <- strptime(data2$Date, "%Y-%m-%d %H:%M:%S")

data2$Sub_metering_1 <- as.numeric (data2$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric (data2$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric (data2$Sub_metering_3)

# create histogram and save to png file
png(file="plot3.png",width=480, height=480)
plot(data2$Date, data2$Sub_metering_1, col = "black", type = "l",ylab = "Energy sub metering", xlab = "" )
points(data2$Date, data2$Sub_metering_2, col = "red", type = "l")
points(data2$Date, data2$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1), col = c("black", "red", "blue"))
dev.off()
