# This script reconstructs Plot 1 from Course Project 1 of Exploratory Data Analysis
# into the plot1.png file usinf base plotting system of R.

# "utils" library is needed for unzipping compressed source data
library(utils)

.source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
.destination <- "~/Study/R/data/household_power_consumption.zip"

# Download and unzip the source data set
download.file(.source, .destination, "curl")
data.file <- unzip(.destination)

# Read data from source file. Interpret "?" as N/A values.
# Note that 126.8 MB of memory are allocated for the data set!
data <- read.table(data.file, header = TRUE, sep = ";", na.strings = "?")
names(data) <- tolower(gsub("_", ".", names(data)))

# Parse date and time strings into POSIXlt and store to a new variable 'datetime'
data$datetime <- strptime(paste(data$date, data$time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Reduce data set to only 1 and 2 of February 2007 in accordance withe the task definition
data <- data[format(data$datetime, "%Y-%m-%d") %in% c("2007-02-01", "2007-02-02"), ]

# Initiate PNG graphics device for plotting
png(filename = "plot1.png", width = 480, height = 480)
# Build Plot 1
hist(data$global.active.power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Shut down active graphics device
dev.off()