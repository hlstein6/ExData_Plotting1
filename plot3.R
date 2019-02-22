# Read in the power file
power <- read.table(file="./data/exdata_data_household_power_consumption/household_power_consumption.txt", 
                    header=TRUE, sep=";", stringsAsFactors=FALSE, 
                    colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", "numeric"), 
                    na.strings=c("?"))

# Create field, readingDate
power <- power %>% mutate(readingDate= as.Date(Date,format="%d/%m/%Y"))

# Include only Feb 1 and Feb 2 of 2007
subsetPower <- subset(power, power$readingDate == as.Date("2007-02-01") | 
                        power$readingDate == as.Date("2007-02-02"))

# Create field dateTime
subsetPower <- subsetPower %>% mutate(dateTime = paste(as.character(readingDate),Time) )

# PLOT
plot(strptime(subsetPower$dateTime, "%Y-%m-%d %H:%M:%S"), subsetPower$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="")
lines(strptime(subsetPower$dateTime, "%Y-%m-%d %H:%M:%S"), subsetPower$Sub_metering_2, type="l", 
      col="red", lwd=1)
lines(strptime(subsetPower$dateTime, "%Y-%m-%d %H:%M:%S"), subsetPower$Sub_metering_3, type="l", 
      col="blue", lwd=1)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), cex=0.8, lty=c(1,1,1))

# Write to PNG file
dev.copy(png, file = "./plot3.png", width=480 , height=480,  units ="px")
dev.off()