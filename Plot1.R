# Load required library
library(data.table)

# Set working directory (Make sure this path is correct for your system)
setwd("D:/Rahul Folder/Courses/Coursera/John Hopkin's University's Data Science Specialization/Course 4(Exploratory Data Analysis)/Project 1/exdata_data_household_power_consumption")

# Read the dataset, treating "?" as NA (common issue in this dataset)
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert necessary columns to appropriate types
power_data[, `:=`(Global_active_power = as.numeric(Global_active_power),  # Convert power usage to numeric
                  Date = as.Date(Date, "%d/%m/%Y"))]  # Convert date column to Date format

# Filter data for February 1-2, 2007
filtered_data <- power_data[Date %between% c("2007-02-01", "2007-02-02")]

# Save plot as a PNG file
png("plot1.png", width = 480, height = 480)

# Generate histogram for Global Active Power
hist(filtered_data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red")

# Close the graphics device to save the file
dev.off()
