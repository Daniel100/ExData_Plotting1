# Title: plot1.R ----------------------------------------------------------------------------------------
# Boesch Daniel 
# 2015-11-02
#
# Description: 
# Measurements of electric power consumption in one household with a one-minute sampling rate 
# over a period of almost 4 years. Different electrical quantities and some sub-metering values 
# are available.

# Loading Packages --------------------------------------------------------------------------------
library(data.table)

# Loading the RAW-DATA ----------------------------------------------------------------------------
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


# plot1.png ---------------------------------------------------------------------------------------
png(filename = "plot1.png", width = 480, height = 480)
with(UCI_EPC, 
     hist(Global_active_power, col = "red", main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"
         )
     ) 
dev.off()







