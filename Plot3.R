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

#Plot3
dev.copy(png,"plot3.png")
with(FinalDataSetX, {
  plot(Sub_metering_1~Day.Time2, type="l",
       ylab="Global Active Power", xlab="")
  lines(Sub_metering_2~Day.Time2,col="red")
  lines(Sub_metering_3~Day.Time2,col="blue")
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()