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

# PLOT
hist(subsetPower$Global_active_power, main="Global Active Power", xlab= "Global Active Power (kilowatts)", 
     ylab="Frequency", col="red")
# Write to PNG file
dev.copy(png, file = "./plot1.png", width=480 , height=480,  units ="px")
dev.off()