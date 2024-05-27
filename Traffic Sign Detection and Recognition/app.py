from flask import *
import os
from werkzeug.utils import secure_filename
from keras.models import load_model
import numpy as np
from PIL import Image
import base64
import cv2
from pyttsx3 import *

# engine = init()

def talk(content):
    engine = init()
    engine.setProperty('rate',100)
    engine.say(content)
    engine.runAndWait()


app = Flask(__name__)

# Classes of trafic signs
classes = { 0: 'Give way',
            1: 'No entry',
            2: 'One-way traffic',
            3: 'One-way traffic',
            4: 'No vehicles in both directions',
            5: 'No entry for cycles',
            6: 'No entry for goods vehicles',
            7: 'No entry for pedestrians',
            8: 'No entry for bullock carts',
            9: 'No entry for hand carts',
            10: 'No entry for motor vehicles',
            11: 'Height limit',
            12: 'Weight limit',
            13: 'Axle weight limit',
            14: 'Length limit',
            15: 'No left turn',
            16: 'No right turn',
            17: 'No overtaking',
            18: 'Maximum speed limit (90 km/h)',
            19: 'Maximum speed limit (110 km/h)',
            20: 'Horn prohibited',
            21: 'No parking',
            22: 'No stopping',
            23: 'Turn left',
            24: 'Turn right',
            25: 'Steep descent',
            26: 'Steep ascent',
            27: 'Narrow road',
            28: 'Narrow bridge',
            29: 'Unprotected quay',
            30: 'Road hump',
            31: 'Dip',
            32: 'Loose gravel',
            33: 'Falling rocks',
            34: 'Cattle',
            35: 'Crossroads',
            36: 'Side road junction',
            37: 'Side road junction',
            38: 'Oblique side road junction',
            39: 'Oblique side road junction',
            40: 'T-junction',
            41: 'Y-junction',
            42: 'Staggered side road junction',
            43: 'Staggered side road junction',
            44: 'Roundabout',
            45: 'Guarded level crossing ahead',
            46: 'Unguarded level crossing ahead',
            47: 'Level crossing countdown marker',
            48: 'Level crossing countdown marker',
            49: 'Level crossing countdown marker',
            50: 'Level crossing countdown marker',
            51: 'Parking',
            52: 'Bus stop',
            53: 'First aid post',
            54: 'Telephone',
            55: 'Filling station',
            56: 'Hotel',
            57: 'Restaurant',
            58: 'Refreshments' }

def image_processing(img):
    model = load_model('./model/Darylmodel.h5')
    data=[]
    image = Image.open(img)
    image = image.resize((30,30))
    data.append(np.array(image))
    x_test=np.array(data)
    data = np.array(image) / 255.0
    data = np.expand_dims(data, axis=0)
    predictions = model.predict(x_test)
    Y_pred = np.argmax(predictions, axis=1)
    print("Prediction: ",Y_pred)
    return Y_pred

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        # Get the file from post request
        f = request.files['file']
        # file_path = secure_filename(f.filename)
        file_path = f"img.png"
        print(file_path)
        f.save(file_path)
        # Make prediction
        result = image_processing(file_path)
        data=[]
        pic=cv2.imread(file_path)
        grey=cv2.cvtColor(pic,cv2.COLOR_BGR2GRAY)
        edges=cv2.Canny(grey,50,150)
        contours,_=cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        min_contour_area = 100
        filtered_contours = [cnt for cnt in contours if cv2.contourArea(cnt) > min_contour_area]
        s = [str(i) for i in result]
        a = int("".join(s))
        for cnt in filtered_contours:
            x, y, w, h = cv2.boundingRect(cnt)
            cv2.rectangle(pic, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.putText(pic, classes[a], (x, y-10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 1)
        cv2.imwrite(file_path,pic)
        result = "Predicted Traffic Sign is: " +classes[a]
        # os.remove(file_path)
        img = cv2.imread('img.png')
        _, buffer = cv2.imencode(".png", img)  # You can also use ".jpg" or other formats
        base64_string = base64.b64encode(buffer).decode("utf-8")
        talk(result)
        return {"result":result,"image": base64_string}
    return None

if __name__ == '__main__':
    app.run(debug=True)