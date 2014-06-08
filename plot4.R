# plot4.R - Multiplot time series of global active power, voltage,
#           submetering and global reactive power

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

## Open plot4.png
png("./plot4.png", height=480, width=480)

## Configure multiplot
par(mfrow=c(2,2))

## Global Active Power plot
plot(Data$DateTime,Data$Global_active_power 
     ,xlab=""
     ,ylab="Global Active Power"
     ,pch=NA
     )
lines(Data$DateTime, Data$Global_active_power)

## Voltage plot
plot(Data$DateTime,Data$Voltage
     ,xlab="datetime"
     ,ylab="Voltage"
     ,pch=NA
     )
lines(Data$DateTime,Data$Voltage)

## Submetering plot
plot(Data$DateTime 
     ,Data$Sub_metering_1
     ,xlab="" 
     ,ylab="Energy sub metering"
     ,pch=NA
     )
lines(Data$DateTime,Data$Sub_metering_1)
lines(Data$DateTime,Data$Sub_metering_2,col='red')
lines(Data$DateTime,Data$Sub_metering_3,col='blue')
legend('topright' 
       ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
       ,lty = c(1,1,1)
       ,col = c('black','red','blue')
       ,bty = 'n'
       )

## Global reactive power plot
with(Data,plot(DateTime,Global_reactive_power
               ,xlab='datetime'
               ,pch=NA
               ))
with(Data,lines(DateTime,Global_reactive_power))

# Close PNG file
dev.off()