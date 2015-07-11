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
data2$Global_active_power<-as.numeric(data2$Global_active_power)

# create plot and save to png file
png(file="plot2.png",width=480, height=480)
plot(data2$Date, data2$Global_active_power, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()


