import subprocess

# Define the command to run
command = [
    "fcrackzip",
    "-b",
    "-l",
    "11847453-10011847452",
    "-u",
    "mtsunde@stud.ntnu.no-fff.zip",
]

# Run the command
result = subprocess.run(command, capture_output=True, text=True)

# Print the output
print(result.stdout)
print(result.stderr)
