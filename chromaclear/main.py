from flask import Flask, request, render_template, jsonify, Response, url_for, redirect
import cv2
import numpy as np
import base64

app = Flask(__name__)

def convert_tritanopia(image):
    # Convert the image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    
    # Define the range for the color blue
    lower_blue = np.array([90, 50, 50])
    upper_blue = np.array([150, 255, 255])

    # Create mask for blue areas
    blue_mask = cv2.inRange(hsv_image, lower_blue, upper_blue)
    
    # Convert the original image to grayscale
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    # Create a 3-channel grey image
    grey_3_channel = cv2.cvtColor(grey_image, cv2.COLOR_GRAY2BGR)
    
    # Apply the mask to the grey image, so only blue areas are converted
    image[blue_mask != 0] = grey_3_channel[blue_mask != 0]
    
    return image

def convert_deuteranopia(image):
    # Convert the image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    
    # Define range of green color in HSV
    lower_green = np.array([35, 50, 50])
    upper_green = np.array([90, 255, 255])

    # Create mask for green areas
    mask = cv2.inRange(hsv_image, lower_green, upper_green)

    # Convert entire image to grayscale
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Convert the grayscale image back to BGR
    grey_3_channel = cv2.cvtColor(grey_image, cv2.COLOR_GRAY2BGR)

    # Use the mask to blend the grayscale image and the original image
    result = np.where(mask[:, :, None] == 255, grey_3_channel, image)

    return result

def convert_protanopia(image):
    # Convert image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Define the range for the color red
    lower_red1 = np.array([0, 50, 50])
    upper_red1 = np.array([10, 255, 255])
    lower_red2 = np.array([160, 50, 50])
    upper_red2 = np.array([180, 255, 255])

    # Create masks for red areas
    mask1 = cv2.inRange(hsv_image, lower_red1, upper_red1)
    mask2 = cv2.inRange(hsv_image, lower_red2, upper_red2)
    red_mask = mask1 + mask2

    # Convert the original image to grayscale
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Create a 3-channel grey image
    grey_3_channel = cv2.cvtColor(grey_image, cv2.COLOR_GRAY2BGR)

    # Apply the mask to the grey image, so only red areas are converted
    image[red_mask != 0] = grey_3_channel[red_mask != 0]

    return image

def convert_images(image, blindness_type):
    if blindness_type == 'tritanopia':
        return convert_tritanopia(image)
    elif blindness_type == 'deuteranopia':
        return convert_deuteranopia(image)
    elif blindness_type == 'protanopia':
        return convert_protanopia(image)
    else:
        return image

def generate_frames(blindness_type):
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        yield "Error: Could not open video stream from camera"
    else:
        while True:
            #ret is True if frame is captured successfully and frame contains the captured frame 
            ret, frame = cap.read()
            if not ret:
                yield "Failed to grab frame"
                break
            else:
                converted_frame = convert_images(frame, blindness_type)
                ret, buffer = cv2.imencode('.jpg', converted_frame)
                frame_bytes = buffer.tobytes()
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')
                


def convert_reds_to_grey(image):
    # Convert image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
   
    # Define the range for the color red
    # Note: Adjust these ranges to better capture the reds you're interested in
    lower_red1 = np.array([0, 50, 50])
    upper_red1 = np.array([10, 255, 255])
    lower_red2 = np.array([160, 50, 50])
    upper_red2 = np.array([180, 255, 255])

    # Create masks for red areas
    mask1 = cv2.inRange(hsv_image, lower_red1, upper_red1)
    mask2 = cv2.inRange(hsv_image, lower_red2, upper_red2)
    red_mask = mask1 + mask2
   
    # Convert the original image to grayscale
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
   
    # Create a 3-channel grey image
    grey_3_channel = cv2.cvtColor(grey_image, cv2.COLOR_GRAY2BGR)
   
    # Apply the mask to the grey image, so only red areas are converted
    image[red_mask != 0] = grey_3_channel[red_mask != 0]
   
    return image

def convert_green_to_grey(image):
    # Convert image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)

    # Define range of green color in HSV
    lower_green = np.array([35, 50, 50])
    upper_green = np.array([90, 255, 255])

    # Create mask for green areas
    mask = cv2.inRange(hsv_image, lower_green, upper_green)

    # Create a mask for non-green areas
    non_green_mask = cv2.bitwise_not(mask)

    # Convert green areas to grey
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    grey_image[mask > 0] = 128  # Set green areas to grey

    # Preserve non-green areas
    result = cv2.bitwise_or(cv2.merge([grey_image, grey_image, grey_image]), image, mask=non_green_mask)

    return result

def convert_blues_to_grey(image):
    # Convert image to the HSV color space
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
   
    # Define the range for the color blue
    lower_blue = np.array([90, 50, 50])
    upper_blue = np.array([150, 255, 255])

    # Create mask for blue areas
    blue_mask = cv2.inRange(hsv_image, lower_blue, upper_blue)
   
    # Convert the original image to grayscale
    grey_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
   
    # Create a 3-channel grey image
    grey_3_channel = cv2.cvtColor(grey_image, cv2.COLOR_GRAY2BGR)
   
    # Apply the mask to the grey image, so only blue areas are converted
    image[blue_mask != 0] = grey_3_channel[blue_mask != 0]
   
    return image

def daltonize(image, blindness_type):
    if blindness_type == "protanopia":
        hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    # Increase the luminance of colors that might be challenging for color-deficient individuals (e.g., red)
        hsv_image[..., 2] = cv2.equalizeHist(hsv_image[..., 2])
        # Convert the image back to BGR color space
        daltonized_image = cv2.cvtColor(hsv_image, cv2.COLOR_HSV2BGR)
   
    return daltonized_image

@app.route('/')
def index():
    return render_template('homepage.html')

@app.route('/imgupload')
def convert_image_page():
    return render_template('imgupload.html')

@app.route('/extensions')
def show_extensions():
    return render_template('extension.html')


@app.route('/convert_image', methods=['POST'])
def convert_image():
    file = request.files['file']
    colorblindness_type = request.form['colorblindnessType']

    if file.filename == '':
        return jsonify({'error': 'No file selected'}), 400

    image_np = np.frombuffer(file.read(), np.uint8)
    image = cv2.imdecode(image_np, cv2.IMREAD_COLOR)

    if colorblindness_type == "protanopia":
        # Convert reds to grey
        con_image = convert_reds_to_grey(image)
        # Apply daltonization
        converted_image = daltonize(con_image, colorblindness_type)
    elif colorblindness_type == "deuteranopia":
        # Convert greens to grey
        converted_image = convert_green_to_grey(image)
    elif colorblindness_type == "tritanopia":
        # Convert blues to grey
        converted_image = convert_blues_to_grey(image)
    else:
        return jsonify({'error': 'Invalid color blindness type'}), 400

    _, converted_image_encoded = cv2.imencode('.jpg', converted_image)
    converted_image_base64 = base64.b64encode(converted_image_encoded).decode('utf-8')

    return converted_image_base64

@app.route('/get_color', methods=['POST'])
def get_hover_color():
    data = request.get_json()
    r = int(data['r'])
    g = int(data['g'])
    b = int(data['b'])
    color_name = get_color_name(r, g, b)
    return jsonify({'color': color_name})


def get_color_name(r, g, b):
    # Dictionary mapping RGB values to color names
    colors = {
        (255, 0, 0): 'Red',
        (255, 165, 0): 'Orange',
        (255, 255, 0): 'Yellow',
        (0, 255, 0): 'Green',
        (0, 128, 0): 'Dark Green',
        (0, 0, 255): 'Blue',
        (0, 0, 128): 'Dark Blue',
        (128, 0, 128): 'Purple',
        (255, 192, 203): 'Pink',
        (128, 128, 128): 'Gray',
        (0, 0, 0): 'Black',
        (255, 255, 255): 'White',
        (128, 0, 0): 'Maroon',
        (128, 128, 0): 'Olive',
        (128, 0, 128): 'Purple',
        (0, 128, 128): 'Teal',
        (165, 42, 42): 'Brown',
        (139, 128, 0): 'Dark Yellow',
        (238, 200, 158): 'Light Yellow',
        # Add more color mappings as needed
    }
    
    # Find the closest color name
    min_dist = float('inf')
    closest_color = None
    for rgb, name in colors.items():
        dist = np.sqrt((r - rgb[0]) ** 2 + (g - rgb[1]) ** 2 + (b - rgb[2]) ** 2)
        if dist < min_dist:
            min_dist = dist
            closest_color = name

    return closest_color
@app.route('/realtime')
def realtime():
    return render_template('realtimecapture.html')

# Route to simulate color blindness and provide video frames
@app.route('/simulate_color_blindness')
def simulate_color_blindness():
    blindness_type = request.args.get('type', default='tritanopia')
    return Response(generate_frames(blindness_type), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == "__main__":
    app.run(debug=True)