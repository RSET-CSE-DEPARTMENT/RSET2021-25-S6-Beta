from flask import Flask, request, jsonify
import cv2
import numpy as np
import torch
from facenet_pytorch import MTCNN
import tensorflow as tf
from tensorflow.keras.applications import VGG16
from tensorflow.keras.layers import Flatten, Dense

app = Flask(__name__)

# Load pre-trained models
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
mtcnn = MTCNN(keep_all=True, device=device)

base_model = VGG16(weights='imagenet', include_top=False, input_shape=(224, 224, 3))
base_model.trainable = False

x = base_model.output
x = Flatten()(x)
x = Dense(units=1024, activation='relu')(x)
predictions = Dense(units=3, activation='softmax')(x)  # Assuming 3 classes for skin type
model = tf.keras.Model(inputs=base_model.input, outputs=predictions)

# Define skin type classes
skin_types = ['Normal', 'Oily', 'Dry']

def preprocess_image(image):
    image = image / 255.0
    image = tf.image.resize(image, (224, 224))
    return np.expand_dims(image, axis=0)

def predict_skin_type(image_path):
    image = cv2.imread(image_path)
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    boxes, _ = mtcnn.detect(rgb_image)

    if boxes is None:
        return 'No face detected'

    # Assume only one face is detected
    box = boxes[0]
    x, y, w, h = map(int, box)
    face_img = rgb_image[y:y+h, x:x+w]
    preprocessed_img = preprocess_image(face_img)

    prediction = model.predict(preprocessed_img)[0]
    predicted_class_index = np.argmax(prediction)
    predicted_skin_type = skin_types[predicted_class_index]
    
    return predicted_skin_type

@app.route('/upload', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image provided'})

    image_file = request.files['image']
    if image_file.filename == '':
        return jsonify({'error': 'No image selected'})

    try:
        image_path = 'uploaded_image.jpg'
        image_file.save(image_path)
        skin_type = predict_skin_type(image_path)
        return jsonify({'result': skin_type})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
