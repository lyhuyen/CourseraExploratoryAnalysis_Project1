################ Coursera, Exploratory Analysis ################
################        Course Project 1        ################

## Read in data
    rm(list=ls())
    setwd(getwd())
    ZipData <- paste("https://d396qusza40orc.cloudfront.net/",
                     "exdata%2Fdata%2Fhousehold_power_consumption.zip", sep="")
    temp <- tempfile()
    download.file(ZipData, temp)
    unzip(temp, exdir = getwd())
    file <- "household_power_consumption.txt"
    eps <- read.table(file, na.strings="?", sep=";", stringsAsFactors=F,
                      skip=grep("[12]/[2|02]/2007", readLines(file)), 
                      nrows=5000)
    names(eps) <- c("date", "time", "global_active_power", "global_reactive_power",
                    "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", 
                    "sub_metering_3")

## Format data (keep specified data)
    eps$datetime <- strptime(paste(eps$date, eps$time), "%d/%m/%Y %H:%M:%S")
    eps[, c("date", "time")] <- list(NULL)
    eps <- eps[as.Date(eps$datetime)==as.Date("01/02/2007","%d/%m/%Y") | 
                as.Date(eps$datetime)==as.Date("02/02/2007","%d/%m/%Y"), ]

## Plot 3: Submetering vs. time
    plot(eps$datetime, eps$sub_metering_1, type="l",
         xlab="", ylab="Energy sub metering")
    lines(eps$datetime, eps$sub_metering_2, type="l", col="red")
    lines(eps$datetime, eps$sub_metering_3, type="l", col="blue")
    legend("topright", col=c("black", "red", "blue"),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=1)
    dev.copy(png, file="plot3.png", width=480, height=480, units="px")
    dev.off()