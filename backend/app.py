from flask import Flask, request, jsonify
import cv2

app = Flask(__name__)

@app.route('/capture_image', methods=['POST'])
def capture_image():
    # Initialize the camera
    cap = cv2.VideoCapture(0)

    # Capture an image
    ret, frame = cap.read()

    # Save the image to a file
    cv2.imwrite('image.jpg', frame)

    # Return a success response
    return jsonify({'message': 'Image captured successfully'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')