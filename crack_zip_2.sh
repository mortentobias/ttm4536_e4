#!/bin/bash

# Define the ZIP file and the known part of the password
ZIP_FILE="mtsunde@stud.ntnu.no-fff.zip"
LEFTMOST_INT=1184745343
LOG_FILE="fcrackzip_results.log"

# Check if the ZIP file exists
if [ ! -f "$ZIP_FILE" ]; then
  echo "Error: ZIP file not found: $ZIP_FILE"
  exit 1
fi

# Run fcrackzip with the known part of the password and a range for the random 10-digit number
echo "Starting password cracking for $ZIP_FILE..." | tee -a $LOG_FILE
fcrackzip -v -u -l "${LEFTMOST_INT}1000000000"-"${LEFTMOST_INT}9999999999" "$ZIP_FILE" | tee -a $LOG_FILE

# Check if the process found a password
if grep -q "possible pw found" $LOG_FILE; then
  echo "Password found! Check the log file $LOG_FILE for details."
else
  echo "No password found within the specified range. You may need to expand the range."
fi