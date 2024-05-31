import time
import firebase_admin
from firebase_admin import credentials, storage
import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.applications import VGG16
from tensorflow.keras.layers import Flatten, Dense
import re
import os

# Initialize the Firebase app
cred = credentials.Certificate('skkn-auth-9b32283d1ae0.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'skkn-auth.appspot.com'
})

# Function to list files in the storage bucket
def list_files():
    bucket = storage.bucket()
    blobs = bucket.list_blobs()
    file_list = [blob.name for blob in blobs]
    return file_list

# Function to detect new files
def detect_new_files(prev_files):
    current_files = list_files()
    new_files = [file for file in current_files if file not in prev_files]
    return new_files, current_files

# Function to download file from Firebase Storage
def download_file(file_name):
    # Sanitize the file name
    sanitized_file_name = re.sub(r'[^\w\.-]', '_', file_name)
    
    bucket = storage.bucket()
    blob = bucket.blob(file_name)
    file_path = f'./{sanitized_file_name}'
    blob.download_to_filename(file_path)
    return file_path

# Continuously check for new files
def monitor_bucket(interval=10):
    print("Starting to monitor bucket for new files...")
    prev_files = list_files()
    while True:
        new_files, prev_files = detect_new_files(prev_files)
        if new_files:
            for new_file in new_files:
                # Construct the full path URL
                full_path = f'gs://{storage.bucket().name}/{new_file}'
                print(f"New file detected: {full_path}")
                local_file_path = download_file(new_file)
                process_image(local_file_path)
        time.sleep(interval)

# Define target image dimensions
target_width, target_height = 224, 224
use_face_detection = True  # Set to True if you want to use face detection

# Define skin type classes
skin_types = ['Normal', 'Oily', 'Dry']
num_classes = len(skin_types)

# Define face detection function
def detect_face(image):
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)
    if len(faces) == 0:
        return None
    else:
        return faces[0]

# Define image preprocessing function
def preprocess_image(image):
    image = image / 255.0
    image = tf.image.resize(image, (target_width, target_height))
    return image

# Load pre-trained VGG16 model
base_model = VGG16(weights='imagenet', include_top=False, input_shape=(target_width, target_height, 3))
base_model.trainable = False

x = base_model.output
x = Flatten()(x)
x = Dense(units=1024, activation='relu')(x)
predictions = Dense(units=num_classes, activation='softmax')(x)

model = tf.keras.Model(inputs=base_model.input, outputs=predictions)

# Function to process the image
def process_image(image_path):
    try:
        frame = cv2.imread(image_path)
        if frame is None:
            raise FileNotFoundError(f"Error loading image at {image_path}. Please check the file path.")
        
        if use_face_detection:
            face_rect = detect_face(frame)
            if face_rect is None:
                print("No face detected.")
                return
            else:
                x, y, w, h = face_rect
                frame = frame[y:y+h, x:x+w]

        preprocessed_image = preprocess_image(frame)
        preprocessed_image = np.expand_dims(preprocessed_image, axis=0)

        prediction = model.predict(preprocessed_image)[0]
        predicted_class_index = np.argmax(prediction)
        predicted_skin_type = skin_types[predicted_class_index]

        
        assets_folder = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'assets')
        if not os.path.exists(assets_folder):
            os.makedirs(assets_folder)
        with open(os.path.join(assets_folder, 'predicted_skin_type.txt'), 'w') as file:
            file.write(predicted_skin_type)
            print("Added!")

        cv2.putText(frame, f"Skin Type: {predicted_skin_type}", (20, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)
        cv2.imshow('Skin Type Analyzer', frame)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

        print(f"Predicted Skin Type: {predicted_skin_type}")  # Print predicted skin type in terminal

    except Exception as e:
        print(f"Error processing image: {e}")

# Run the monitor function
if __name__ == "__main__":  # Corrected line
    monitor_bucket(interval=10)  # Check every 10 seconds
