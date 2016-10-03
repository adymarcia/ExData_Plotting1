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

#creates plot 2 in the variable with the same name. type = "ll creates a line graph.
plot2 <- plot(relevant_dates$dateTime, relevant_dates$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

#export the graph to the working directory. Again, dont forget to close off the export.
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()