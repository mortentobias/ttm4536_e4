from stegano import lsb
from PIL import Image

image_paths = ["m1.jpg", "m1(1).jpg", "m2.jpg", "m2(1).jpg", "m3.jpg"]

for path in image_paths:
    try:
        # Open the image to check if it's valid
        with Image.open(path) as img:
            img.verify()

        # Try to reveal the hidden message
        secret_message = lsb.reveal(path)
        if secret_message:
            print(f"Hidden message in {path}: {secret_message}")
        else:
            print(f"No hidden message found in {path}.")
    except (IOError, OSError) as e:
        print(f"Error processing {path}: {e}")
    except lsb.SteganoException as e:
        print(f"Error processing {path}: {e}")
    except Exception as e:
        print(f"Error processing {path}: {e}")
