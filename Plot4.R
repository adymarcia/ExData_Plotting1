#Read the .txt file into R. Denote header = TRUE to make first row 
setwd("C:/Users/admarcia/Desktop/Data Science/Assignments/Assignment 4-1")
raw_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#Load the dplyr package and lubridate package for future use
library(dplyr)
library(lubridate)

#convert the raw_data into a data table
data_table <- tbl_df(raw_data)

#selects the two dates relevant to the analysis using the filter function from the Dplyr package
Feb1 <- filter(data_table, Date == "1/2/2007")
Feb2 <- filter(data_table, Date == "2/2/2007")

#combine these dates into a single data frame
relevant_dates <- rbind.data.frame(Feb1, Feb2)

#converts the date column into a workable date.
relevant_dates$Date <- as.Date(relevant_dates$Date, format="%d/%m/%Y")

#combines the date and the time to form a continuous data x-axis
relevant_dates <- transform(relevant_dates, dateTime = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#create plot work space
par(mfrow = c(2,2))

#makes the 4 plots (plots 1 through 3 were from previous code)
makePlots <- function(){
        plot1 <- function(){
                hist(as.numeric(relevant_dates$Global_active_power), col = "red", xlab="Global Active Power (kilowatts)")
        }
        
        plot1()

        plot2 <- function(){
                plot2 <- plot(relevant_dates$dateTime, relevant_dates$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
        }
        
        plot2()

        plot3 <- function(){
                plot(relevant_dates$dateTime, relevant_dates$Sub_metering_1, type = "l", xlab = "", ylab = "energy sub metering")
                lines(relevant_dates$dateTime, relevant_dates$Sub_metering_2, type = "l", col = "blue")
                lines(relevant_dates$dateTime, relevant_dates$Sub_metering_3, type = "l", col = "red")
                legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), cex = 5, bty = "n")
        }
        
        plot3()

        plot4 <- function(){
                plot(relevant_dates$dateTime, relevant_dates$Global_reactive_power, type = "l", xlab = "Date Time", ylab = "Global reactive power" )
        }
        
        plot4()
}

makePlots()

#print 4 plots
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()