# Load required library
library(data.table)

# Set working directory (Ensure this path is correct for your system)
setwd("D:/Rahul Folder/Courses/Coursera/John Hopkin's University's Data Science Specialization/Course 4(Exploratory Data Analysis)/Project 1/exdata_data_household_power_consumption")

# Read dataset, treating "?" as missing values (common issue in this dataset)
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric (some values might become NA if conversion fails)
power_data[, Global_active_power := as.numeric(Global_active_power)]

# Create a POSIXct datetime column by combining 'Date' and 'Time'
power_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter data for February 1-2, 2007
filtered_data <- power_data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Save plot to a PNG file
png("plot3.png", width = 480, height = 480)

# Generate line plot for energy sub-metering
plot(filtered_data$dateTime, filtered_data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering", 
     col = "black")  # Default color

# Add additional lines for Sub_metering_2 and Sub_metering_3
lines(filtered_data$dateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$dateTime, filtered_data$Sub_metering_3, col = "blue")

# Add a legend to indicate which line represents which sub-metering value
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, lwd = 1)

# Close the graphics device to save the file
dev.off()
