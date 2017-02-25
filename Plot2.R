#Importing only the relevant days
Originalfile <- file("/Users/Mood/Documents/Coursera/household_power_consumption.txt")
ImportedFile <- read.table(text = grep("^[1,2]/2/2007", readLines(Originalfile), value = TRUE), 
                           col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                         "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                                         "Sub_metering_3"), sep = ";", header = TRUE)

#Converting Date and Time
Jour <- as.Date(ImportedFile$Date, format("%d/%M/%Y"))
HeureX <- strptime(ImportedFile$Time, format("%H:%M:%S"))
Heure <- format(HeureX, format="%H:%M:%S")
Day.Time <- paste(Jour,Heure)
Day.Time2 <- strptime(Day.Time, format("%Y-%M-%d %H:%M:%S"))

#CleaningDataset from "?"if any
FinalDataSetX <- cbind(Day.Time2, ImportedFile)

#Plot2
dev.copy(png,"plot2.png")
plot(FinalDataSetX$Global_active_power~FinalDataSetX$Day.Time2, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
