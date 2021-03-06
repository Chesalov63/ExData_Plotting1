## Start with downloading and unzipping UCI file
filename <- "exdata_data_household_power_consumption.zip"
if(!file.exists(filename)) {
        download.file(
                "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", filename)
        }
unzip(filename)

## Read the data from dates 2007-02-01 and 2007-02-02 (2880 records)
library(data.table)
filename <- "household_power_consumption.txt"
headerDT <- fread(filename, sep = ";", na.strings = "?", nrows=0)
powerDT <- fread(filename, sep = ";", na.strings = "?", skip = "1/2/2007", 
                 nrows=2880, col.names = colnames(headerDT))
## Remove the original file, it's too big to keep it unzipped
file.remove(filename)

## Construct the plot and save it to a PNG file (480x480 by default)
png("plot1.png")
hist(powerDT$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()