#Importing only the relevant days
setwd("/Users/Mood/Documents/ExData_Plotting1")
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

#CleaningDataset from "?"if any
FinalDataSetXX <- cbind(Day.Time, ImportedFile)
FinalDataSetXX[FinalDataSetXX == "?"] <- NA
FinalDataSet <- na.omit(FinalDataSetXX)


#Plot1
dev.copy(png,"plot1.png")
hist(FinalDataSet$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
dev.off()

