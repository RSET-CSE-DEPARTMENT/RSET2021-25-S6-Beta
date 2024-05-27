# Traffic Sign Detection and Recognition 🚦🚥
This project aims to develop a web page software with a custom model that accepts test traffic sign image as input and detects and recognizes it. The predicted traffic sign label is displayed along with bounded boxed image and audio. The custom CNN model is made by collecting the traffic sign dataset images,preprocessing the images,splitting them into training and testing datasets,training the model on training set and testing the model's prediction accuracy using testing set before putting the custom model into application.

# Installations 
pip install -r .\requirements.txt
pip install tensorflow
pip install pyttsx3
pip install base64
pip install pillow
pip install opencv-python
pip install Flask
pip install werkzeug
pip install numpy 

*To run the project*: python app.py
Then click on the link http://127.0.0.1:5000/ in the terminal.