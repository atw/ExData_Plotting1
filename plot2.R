DATASET_DIR <- "data"
DATASET_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DATASET_FILE <- file.path(DATASET_DIR, "household_power_consumption.txt")

source("download_data.R")

download_dataset(DATASET_URL, DATASET_FILE, DATASET_DIR)

power_consumption <- read.csv(
    DATASET_FILE,
    sep = ";",
    as.is = TRUE,
    na.strings = "?"
)
power_consumption$datetime <- strptime(
    paste(power_consumption$Date, power_consumption$Time),
    format = "%d/%m/%Y %H:%M:%S",
    tz = "GMT"
)
power_consumption$Date <- as.Date(power_consumption$Date, format = "%d/%m/%Y")
power_consumption <- subset(power_consumption, Date %in% as.Date(c("2007-02-01", "2007-02-02")))


png("plot2.png", width = 480, height = 480)

with(power_consumption, plot(
    datetime, Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
))

dev.off()

message("Created plot2.png")
