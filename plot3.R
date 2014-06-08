## Note: Before using the code, it is necessary to set the proper working directory

## plot3.R - Time Series of Global Active Power by submeter

## Read data
Data <- read.table(unz('exdata_data_household_power_consumption.zip'
                       ,'household_power_consumption.txt')
                   ,sep=';',header=T
                   ,colClasses = c('character','character','numeric'
                                   ,'numeric','numeric','numeric'
                                   ,'numeric', 'numeric', 'numeric')
                   ,na.strings='?')

## Convert dates 
Data$DateTime <- strptime(paste(Data$Date,Data$Time),"%d/%m/%Y %H:%M:%S")

## Choose the subset for two days in February 2007
Data <- subset(Data,as.Date(DateTime) >= as.Date("2007-02-01")
               & as.Date(DateTime) <= as.Date("2007-02-02"))


## Open plot3.png
png("./plot3.png", height=480, width=480)

## Build time series
## Note, the abbreviations for the days are given by the local language settings
plot(Data$DateTime, Data$Sub_metering_1
     ,xlab=""
     ,ylab="Energy sub metering"
     ,pch=NA
     )
lines(Data$DateTime, Data$Sub_metering_1)
lines(Data$DateTime, Data$Sub_metering_2, col='red')
lines(Data$DateTime, Data$Sub_metering_3, col='blue')
legend('topright' 
       ,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
       ,lty = c(1,1,1)
       ,col = c('black', 'red', 'blue')
       )

# Close PNG file
dev.off()