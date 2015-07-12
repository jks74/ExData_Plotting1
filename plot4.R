
#Download File
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
zipFileName = "./household_power_consumption.zip"
fileName = "household_power_consumption.txt"
download.file(url,zipFileName,method="curl")
unzip (zipFileName, fileName)

#Read Data
rawData <- read.table(fileName,sep=";",header=TRUE,na.strings = "?")

#Create Data Subset
startDate <- as.Date("01/02/2007", "%d/%m/%Y")
endDate <- as.Date("02/02/2007", "%d/%m/%Y")
data <- subset(rawData, as.Date(Date,"%d/%m/%Y") >= startDate & as.Date(Date,"%d/%m/%Y") <= endDate)

#Create Date/Time class
data$DateTime <- paste(data$Date,data$Time,sep=' ')
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Plot 1 Histogram
png(filename = "plot4.png")
par(mfrow=c(2,2))
plot(data$DateTime,data$Global_active_power,type="l",ylab = "Global Active Power (killowatts)",xlab = ' ')
plot(data$DateTime,data$Voltage,type="l",ylab = "Voltage",xlab = "datetime")

plot( data$DateTime, data$Sub_metering_1, type="l" ,ylab = "Energy Sub Metering",xlab = ' ')
points( data$DateTime, data$Sub_metering_2, type="l", col="red")
points( data$DateTime, data$Sub_metering_3, type="l" ,col="blue")
legend("topright", col = c("black","red", "blue"), lty = 1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n",cex=.4)

plot(data$DateTime,data$Global_reactive_power,type="l",ylab = "global_reactive_power",xlab = "datetime")

dev.off() 