plot3 <- function() {
	## plot3.R
	## Create a Plot with data series:  'Sub_metering_1','Sub_metering_2' and 'Sub_metering_3' by 'time' 
	##		requested by the Coursera Exploratory Data Analysis Course Project 1
	## Written by: Enrique Reveron

	## Set system locale to English to have the same output requested (strptime)
	Sys.setlocale("LC_TIME", "English")

	## Check if the data file is located in the working dir

	if (!file.exists("household_power_consumption.txt"))
	{
		{ stop("no valid data file in working directory") }
	}

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

	
	## Read the Information
	dt <- read.delim("household_power_consumption.txt",header=TRUE,sep = ";",
			skip= skip_n,nrows=rows_n, 
			col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
			"Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

	## Create File and Plot it

	png(filename="plot3.png", 
    		units="px", 
    		width=480, 
    		height=480, 
    		pointsize=12, 
    		res=72)

	## Create a row with the Date + Time values to be used as x axis for plot

	x_time <- strptime(paste(dt[,1],dt[,2]),"%d/%m/%Y %H:%M:%S")

	## Because is neccesary to plot three series, let's find the max value in order to use it for all plots

	ymax <- max(dt$Sub_metering_1,dt$Sub_metering_2,dt$Sub_metering_3)	

	## Plot first series 'Sub_metering_1' in black

 	plot(x = x_time, y = dt$Sub_metering_1,type = "l", main = "", ylim = c(0,ymax), col = "black",
		ylab = "", xlab = "") 

	par(new=T)

	## Plot second series 'Sub_metering_2' in red

 	plot(x = x_time, y = dt$Sub_metering_2,type = "l", main = "", ylim = c(0,ymax), col = "red",
		ylab = "", xlab = "") 

	par(new=T)

	## Plot third series 'Sub_metering_3' in blue

 	plot(x = x_time, y = dt$Sub_metering_3,type = "l", main = "", ylim = c(0,ymax), col = "blue",
		ylab = "Energy sub metering", xlab = "") 

	legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), 
		col = c("black","red","blue"))

	par(new=F)

	dev.off()

}
