#install required shaping  packages
install.packages("data.table")

#load library
library(data.table)


#download zip file into data folder created in working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(file.exists("./data")){dir.create("./data")}
download.file(fileurl,destfile = "./data/EDCP1.zip")


#extract zip file to data folder created in working directory
unzip("./data/EDCP1.zip",exdir = "./data/EDCP1")

filename <- file.path("./data/EDCP1" ,"household_power_consumption.txt")
#read full data
full_data <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value = TRUE),header = TRUE,sep = ";",na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
full_data$Datetime <- strptime(paste(full_data$Date, full_data$Time), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

#plot1
with(full_data,plot(Datetime,Global_active_power, type = "l",ylab = "Global Active Power(Kilowatts)",xlab = " ",col="black")) 

#plot2
with(full_data,plot(Datetime,Voltage, type = "l",ylab = "Voltage",xlab = "datetime",col="black"))

#plot3
with(full_data,plot(Datetime,Sub_metering_1, type = "l",ylab = "Energy sub metering",xlab = " ",col="black"))
with(full_data,points(Datetime,Sub_metering_2, type = "l",ylab = "Energy sub metering",xlab = " ",col="red"))
with(full_data,points(Datetime,Sub_metering_3, type = "l",ylab = "Energy sub metering",xlab = " ",col="blue"))
legend("topright",legend =  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty = 1)

#plot4
with(full_data,plot(Datetime,Global_reactive_power, type = "l",ylab = "Global_reactive_power",xlab = "datetime",col="black"))

#copy all plots to plot4.png
dev.copy(png,file = "./data/EDCP1/plot4.png")
dev.off()


