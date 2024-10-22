#!/bin/bash

# Define the ZIP file and the known part of the password
ZIP_FILE="mtsunde@stud.ntnu.no-fff.zip"
BASE_NUMBER=1184745343
LOG_FILE="fcrackzip_results.log"

# Start number and end number for testing (currently set to a smaller range for testing purposes)
START_NUMBER=0
END_NUMBER=99

# Check if the ZIP file exists
if [ ! -f "$ZIP_FILE" ]; then
  echo "Error: ZIP file not found: $ZIP_FILE"
  exit 1
fi

# Initialize or clear the log file
echo "Starting password cracking for $ZIP_FILE..." | tee $LOG_FILE
echo "Base number: $BASE_NUMBER, 10-digit range: $START_NUMBER to $END_NUMBER" | tee -a $LOG_FILE
START_TIME=$(date +%s)

# Counter to track progress
TOTAL_TRIES=$((END_NUMBER - START_NUMBER + 1))
PROGRESS_INTERVAL=2  # Print progress every 2 tries
count=0

# Use seq for better handling of large ranges
seq $START_NUMBER $END_NUMBER | while read -r i; do
  # Add the 10-digit number to the base number (using addition)
  PASSWORD=$((BASE_NUMBER + i))

  # Increment the progress counter
  count=$((count + 1))

  # Log the attempt
  echo "Trying password: $PASSWORD (Attempt $count of $TOTAL_TRIES)" | tee -a $LOG_FILE

  # Run fcrackzip with the generated password
  fcrackzip -v -u -p "$PASSWORD" "$ZIP_FILE" >> $LOG_FILE 2>&1

  # Check if fcrackzip has found the password
  if grep -q "possible pw found" $LOG_FILE; then
    echo "Password found! It is: $PASSWORD" | tee -a $LOG_FILE
    END_TIME=$(date +%s)
    TIME_TAKEN=$((END_TIME - START_TIME))
    echo "Cracking completed in $TIME_TAKEN seconds." | tee -a $LOG_FILE
    echo "Check the log file $LOG_FILE for more details." | tee -a $LOG_FILE
    break
  fi

  # Print progress every 2 tries for testing
  if (( count % PROGRESS_INTERVAL == 0 )); then
    echo "Progress: $count of $TOTAL_TRIES attempts made. Last tried password: $PASSWORD" | tee -a $LOG_FILE
  fi
done

# If no password is found after the loop
if ! grep -q "possible pw found" $LOG_FILE; then
  echo "No password found within the specified range." | tee -a $LOG_FILE
  END_TIME=$(date +%s)
  TIME_TAKEN=$((END_TIME - START_TIME))
  echo "Total time taken: $TIME_TAKEN seconds." | tee -a $LOG_FILE
fi