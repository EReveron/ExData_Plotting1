plot1 <- function() {

	## Read Only the Requested Data
	## We must read the data from 1/2/2007 to 2/2/2007 (two days complete days)
	## The data included each minute rows, so one day is = 24 hours * 60 minutes = 1440 measurements.
	## The data start on 16/12/2006 at 17:24:00, so we must skip:
	##
	##	From 16/12/2006 17:24:00 to 31/1/2007 23:59:00 it means 
	
	x1 <- strptime("2006-12-16 17:24:00","%Y-%m-%d %H:%M:%S")
	y1 <- strptime("2007-1-31 23:59:00","%Y-%m-%d %H:%M:%S")
	skip_n <- as.numeric(difftime(y1,x1,units="mins")) + 1 ## is neccesary to add the first measure

	## How many rows to read
	##	From 1/2/2007 00:00:00 to 2/2/2007 23:59:00 it means 
	
	x2 <- strptime("2007-2-1 00:00:00","%Y-%m-%d %H:%M:%S")
	y2 <- strptime("2007-2-2 23:59:00","%Y-%m-%d %H:%M:%S")
	rows_n <- as.numeric(difftime(y2,x2,units="mins")) + 1 ## is neccesary to add the first measure

	

	dt <- read.delim("household_power_consumption.txt",header=TRUE,sep = ";",
			skip= skip_n,nrows=rows_n, 
			col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")) 


	

	dt


}
