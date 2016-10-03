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

#extracts the relevant data from the relevant dates
global_active_power <- as.numeric(relevant_dates$Global_active_power)

#produces a red histogram of the relevant data from the relevant dates.The x-label is set to the Global Active Power (kilowatts). Saved as plot1 for future exporting
plot1 <- hist(global_active_power, col = "red", xlab="Global Active Power (kilowatts)")

#saves the output into a .png file (remember to close the export with dev.off()). The export is saved in the working directory.
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()