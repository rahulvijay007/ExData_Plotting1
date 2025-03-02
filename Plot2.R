# Load necessary library
library(data.table)

# Set working directory (Make sure this path is correct for your setup)
setwd("D:/Rahul Folder/Courses/Coursera/John Hopkin's University's Data Science Specialization/Course 4(Exploratory Data Analysis)/Project 1/exdata_data_household_power_consumption")

# Read the dataset, treating "?" as NA (common in this dataset)
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric (some values might be NA due to coercion)
power_data[, Global_active_power := as.numeric(Global_active_power)]

# Create a POSIXct datetime column (combining Date and Time)
power_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter data for the required range: Feb 1-2, 2007
filtered_data <- power_data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Save the plot as a PNG file
png("plot2.png", width = 480, height = 480)

# Generate line plot for Global Active Power over time
plot(x = filtered_data$dateTime, y = filtered_data$Global_active_power,
     type = "l",   # Line plot
     xlab = "",    # No label for x-axis (for a cleaner look)
     ylab = "Global Active Power (kilowatts)")

# Close the graphics device to save the file
dev.off()
