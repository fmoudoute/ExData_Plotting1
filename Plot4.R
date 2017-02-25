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


#Plot4
dev.copy(png,"plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(FinalDataSetX, {
  plot(Global_active_power~Day.Time2, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Day.Time2, type="l", 
       ylab="Voltage", xlab="Date & Time")
  plot(Sub_metering_1~Day.Time2, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Day.Time2,col="Red")
  lines(Sub_metering_3~Day.Time2,col="Blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Day.Time2, type="l", 
       ylab="Global_Reactive_Power",xlab="Date & Time")
})
dev.off()