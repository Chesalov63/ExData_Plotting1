## Start with downloading and unzipping UCI file
filename <- "exdata_data_household_power_consumption.zip"
if(!file.exists(filename)) {
        download.file(
                "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", filename)
        }
unzip(filename)

## Read the data from dates 2007-02-01 and 2007-02-02 (2880 records)
library(data.table)
library(dplyr)
filename <- "household_power_consumption.txt"
headerDT <- fread(filename, sep = ";", na.strings = "?", nrows=0)
powerDT <- fread(filename, sep = ";", na.strings = "?", skip = "1/2/2007", 
                 nrows=2880, col.names = colnames(headerDT))
## Remove the original file, it's too big to keep it unzipped
file.remove(filename)

## Set locale in case it differs from North-American usage
Sys.setlocale("LC_TIME", "C")
## Create new column, because we need Date and Time in POSIXct format
powerDT <- mutate(powerDT, DateTime = as.POSIXct(strptime(paste(Date, Time), 
                                                          "%d/%m/%Y %H:%M:%S")
                                                 )
                  )

## Construct the plot and save it to a PNG file (480x480 by default)
png("plot3.png")
with(powerDT, plot(Sub_metering_1 ~ DateTime, type = "l", 
                   ylab = "Energy sub metering", xlab = ""))
with(powerDT, lines(DateTime, Sub_metering_2, col = "red"))
with(powerDT, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", pch = 32, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1)
dev.off()
