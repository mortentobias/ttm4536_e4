#!/bin/bash

# Define the ZIP file and the known part of the password
ZIP_FILE="mtsunde@stud.ntnu.no-fff.zip"
LEFTMOST_INT=1184745343

# Run fcrackzip with the known part of the password and a range for the random 10-digit number
fcrackzip -v -u -l 11847453431000000000-11847453439999999999 "$ZIP_FILE"