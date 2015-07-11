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
data2$Global_active_power<-as.numeric(data2$Global_active_power)
data2$Voltage <- as.numeric (data2$Voltage)

# create histogram and save to png file
png(file="plot4.png",width=480, height=480)
par( mfrow = c( 2, 2))

plot( data2$Date, data2$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
plot(data2$Date, data2$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
plot(data2$Date, data2$Sub_metering_1, col = "black", type = "l",ylab = "Energy sub metering", xlab = "" )
points(data2$Date, data2$Sub_metering_2, col = "red", type = "l")
points(data2$Date, data2$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1), bty = "n", col = c("black", "red", "blue"))
plot(data2$Date, data2$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()