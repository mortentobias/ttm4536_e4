from stegano import lsb

image_paths = ["m1.jpg", "m1(1).jpg", "m2.jpg", "m2(1).jpg", "m3.jpg"]

for path in image_paths:
    try:
        secret_message = lsb.reveal(path)
        if secret_message:
            print(f"Hidden message in {path}: {secret_message}")
        else:
            print(f"No hidden message found in {path}.")
    except Exception as e:
        print(f"Error processing {path}: {str(e)}")
