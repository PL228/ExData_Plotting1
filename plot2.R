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

# Joining date and time to create a new posix date
two_days_data$posix <- as.POSIXct(strptime(paste(two_days_data$Date, two_days_data$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))


# Convert column that we will use to numeric
two_days_data$Global_active_power <- as.numeric(two_days_data$Global_active_power)

# plot the graph
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(two_days_data,
     plot(posix,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

# close the png device
dev.off()