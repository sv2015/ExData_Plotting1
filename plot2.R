# Create data folder
if(!file.exists("data")) {
  dir.create("data")
}

# download zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/electric.zip", mode="wb")
dateDownloadedEPC <- date()
# [1] "Sat Feb 04 01:22:27 2017"

# unzip and read table
unzip(zipfile = "./data/electric.zip", exdir = "./data")

library(sqldf)
library(dplyr)
library(gsubfn)
epc <- read.table("./data/household_power_consumption.txt", 
                  sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# format date
epc$Date <- as.Date(epc$Date, format="%d/%m/%Y")

# filter the dataset
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")

epcsub <- subset(epc, Date %in% c(d1, d2))

# Create datetime stamp
epcsub$DateTime <- as.POSIXct(paste(epcsub$Date, epcsub$Time), format="%Y-%m-%d %H:%M:%S")

# plot 2
png(filename="plot2.png", width = 480, height = 480)

plot(epcsub$DateTime, epcsub$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")


dev.off()

