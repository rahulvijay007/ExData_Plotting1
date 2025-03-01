# Set working directory (Make sure this path is correct for your setup)
setwd("~/GitHub/ExData_Plotting1")  

# Define file paths
processed_file <- "./data/PowerConsumption.csv"   # CSV to store filtered data
raw_data_file <- "./data/household_power_consumption.txt"  # Original dataset

# Check if processed file already exists to avoid redundant processing
if (!file.exists(processed_file)) {
  
  # Read the dataset (handling missing values as "?")
  raw_data <- read.table(raw_data_file, header = TRUE, sep = ";", na.strings = "?", 
                         colClasses = c("character", "character", rep("numeric", 7)))

  # Filter only the required dates (Feb 1 & 2, 2007) - Note: Dates are in DD/MM/YYYY format
  filtered_data <- subset(raw_data, Date %in% c("1/2/2007", "2/2/2007"))

  # Combine Date and Time into a single DateTime column
  filtered_data$DateTime <- strptime(paste(filtered_data$Date, filtered_data$Time), "%d/%m/%Y %H:%M:%S")

  # Reorder columns (moving DateTime to the first position)
  filtered_data <- filtered_data[, c(10, 3:9)]  
  names(filtered_data)[1] <- "Date_time"  # Renaming the first column

  # Save processed data to CSV for future use
  write.csv(filtered_data, file = processed_file, row.names = FALSE)
  
} else {
  # If already processed, load from CSV instead of reprocessing
  filtered_data <- read.csv(processed_file, header = TRUE)
}

# At this point, `filtered_data` contains the dataset ready for analysis.
