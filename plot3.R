# Title: plot3.R -----------------------------------------------------------------------------------------
# Boesch Daniel 
# 2015-11-02
#
# Description: 
# Measurements of electric power consumption in one household with a one-minute sampling rate 
# over a period of almost 4 years. Different electrical quantities and some sub-metering values 
# are available.

# Loading Packages --------------------------------------------------------------------------------
library(data.table)

# Loading the RAW-DATA ---------------------------------------------------------------------------
if( !file.exists("DATA") ){
  dir.create("DATA")
}
if( !file.exists("DATA/UCI_HPC_DATASET") ){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipDATA <- "DATA/UCI_HPC_DATASET"
  download.file(fileURL, destfile=zipDATA, method="curl")
  unzip(zipDATA, exdir =  "DATA")
}


UCI_EPC <- fread("./DATA/household_power_consumption.txt", na.strings = "?")
UCI_EPC[, ":=" (DateTime = as.POSIXct(paste(Date, Time),format='%d/%m/%Y %H:%M:%S'), Date = NULL, Time = NULL)]
UCI_EPC <- UCI_EPC[format(DateTime, "%d/%m/%Y") %in% c("02/02/2007", "01/02/2007"), ] # Select rows by date


# plot3.png ---------------------------------------------------------------------------------------
png(filename = "plot3.png", width = 480, height = 480)
     
     plot(UCI_EPC$DateTime, UCI_EPC$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
     lines(UCI_EPC$DateTime, UCI_EPC$Sub_metering_2, col ="red")
     lines(UCI_EPC$DateTime, UCI_EPC$Sub_metering_3, col ="blue")
     legend("topright", col = c("black", "red", "blue"), 
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1)
            )

dev.off()





