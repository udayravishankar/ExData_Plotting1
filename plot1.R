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

#read full data and extract data for dates bw  2007-02-01 and 2007-02-02
full_data <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value = TRUE),header = TRUE,sep = ";",col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
full_data$Date = as.Date(full_data$Date, "%d/%m/%Y")

#plot and copy to plot1.png
hist(full_data$Global_active_power,xlab="Global Active Power (Kilowatts)",col="Red",main = "Global Active Power")
dev.copy(png,file = "./data/EDCP1/plot1.png")
dev.off()
