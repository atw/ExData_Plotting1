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


png("plot3.png", width = 480, height = 480)

with(power_consumption, plot(
    datetime, Sub_metering_1,
    type = "n",
    xlab = "",
    ylab = "Energy sub metering"
))

with(power_consumption, lines(datetime, Sub_metering_1, col = "black"))
with(power_consumption, lines(datetime, Sub_metering_2, col = "red"  ))
with(power_consumption, lines(datetime, Sub_metering_3, col = "blue" ))

legend(
    "topright",
    lwd = 1,
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

dev.off()

message("Created plot3.png")
