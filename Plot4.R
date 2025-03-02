# Load required library
library(data.table)

# Set working directory (Make sure this path is correct for your system)
setwd("D:/Rahul Folder/Courses/Coursera/John Hopkin's University's Data Science Specialization/Course 4(Exploratory Data Analysis)/Project 1/exdata_data_household_power_consumption")

# Read dataset, treating "?" as missing values
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert necessary columns to numeric (some values might become NA if conversion fails)
power_data[, `:=`(
  Global_active_power = as.numeric(Global_active_power),
  Global_reactive_power = as.numeric(Global_reactive_power),
  Voltage = as.numeric(Voltage),
  Sub_metering_1 = as.numeric(Sub_metering_1),
  Sub_metering_2 = as.numeric(Sub_metering_2),
  Sub_metering_3 = as.numeric(Sub_metering_3)
)]

# Create a POSIXct datetime column by combining 'Date' and 'Time'
power_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter data for February 1-2, 2007
filtered_data <- power_data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Save the plot as a PNG file
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting layout
par(mfrow = c(2, 2))

# Plot 1 - Global Active Power over time
plot(filtered_data$dateTime, filtered_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

# Plot 2 - Voltage over time
plot(filtered_data$dateTime, filtered_data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

# Plot 3 - Energy Sub Metering over time
plot(filtered_data$dateTime, filtered_data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy Sub Metering")
lines(filtered_data$dateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$dateTime, filtered_data$Sub_metering_3, col = "blue")

# Add a legend for sub-metering plot
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, bty = "n", cex = 0.8)

# Plot 4 - Global Reactive Power over time
plot(filtered_data$dateTime, filtered_data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global Reactive Power")

# Close the graphics device to save the file
dev.off()
