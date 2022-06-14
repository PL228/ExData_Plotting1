zipfile <- "exdata_data_household_power_consumption.zip"

# Checking if archieve already exists.
if (!file.exists(zipfile)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, zipfile, method="curl")
}  

datafile <- "household_power_consumption.txt"
if (!file.exists(datafile)){
        unzip(filename) 
}  

# Read the data into table
exdata <- read.table(datafile,header=TRUE, sep=";",)

# Convert "?" to NA
exdata[exdata == "?"] <- NA

# Selecting 2 days data 2007-02-01 and 2007-02-02
exdata$Date <- as.Date(exdata$Date, format = "%d/%m/%Y")
two_days_data <- exdata[exdata$Date >= as.Date("2007-02-01") & exdata$Date <= as.Date("2007-02-02"),]

# Convert the column to the correct class
two_days_data$Global_active_power <- as.numeric(two_days_data$Global_active_power)

# Plot the graph
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(two_days_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency", col="red")

# close the png device
dev.off()