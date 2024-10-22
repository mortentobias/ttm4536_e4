import hashlib
import random
import zipfile

# Step 1: Compute the MD5 hash of the student's email
student_email = "mtsunde@stud.ntnu.no"
hashed_email = hashlib.md5(student_email.encode()).hexdigest()

# Print the MD5 value
print(f"MD5 value of {student_email}: {hashed_email}")

# Step 2: Extract the 8 leftmost hexadecimal characters
leftmost_hex = hashed_email[:8]

# Step 3: Convert these characters to an integer (base 10)
leftmost_int = int(leftmost_hex, 16)
print(leftmost_int)

# Step 4: Try 500000 times to guess the password
zip_filename = "mtsunde@stud.ntnu.no-fff.zip"
for attempt in range(1):
    # Generate a random 10-digit number
    random_number = random.randint(1000000000, 9999999999)

    # Add the random number to the integer value from step 3 to form the password
    zip_password = leftmost_int + random_number

    # Try to open the ZIP file with the generated password
    try:
        with zipfile.ZipFile(zip_filename, "r") as zip_ref:
            zip_ref.extractall(pwd=str(zip_password).encode())
        print(f"Successfully extracted the ZIP file with password: {zip_password}")
        break
    except (RuntimeError, zipfile.BadZipFile):
        continue
else:
    print("Failed to guess the password after 500000 attempts.")
