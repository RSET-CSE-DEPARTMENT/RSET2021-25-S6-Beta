# Orthovision_ai

This project aims to develop an automated system for bone fracture detection and classification in arm X-ray images. The system utilizes labeled datasets from reliable medical sources, preprocesses the images for consistency (resizing, normalization), and potentially improves image quality through augmentation techniques. A deep learning model based on Convolutional Neural Networks (CNNs) is then trained on this data to identify and classify fractures. The model's performance is evaluated using separate datasets and metrics like accuracy, precision, recall, and F1 score.

## System Features

- **Login/Signup Page:** Upon accessing the system, users are presented with a login page where they can either log in using a valid combination of username and password or sign up for the first time by providing a new username, password, and email ID. Username and password validity are checked against the user database. If the details are valid, the user is directed to the main page of the website; otherwise, an error message is displayed, and the user is sent back to the login page.

- **Main Page:** Once logged in, users can upload an image of their X-Ray for analysis. The image resolution must be greater than 640x640 pixels. If the image meets these requirements, it is sent to the YOLO model for analysis. Otherwise, an error message is displayed to the user, and they remain on the main page.

- **Fracture Detection:** The YOLO model analyzes the X-Ray for potential fractures and returns an annotated image with bounding boxes around the regions that have the highest probability of having a fracture, along with the class of the potential fracture detected.

- **Specialist Referral:** The system cross-references the identified fracture class with the hospital database to ascertain medical professionals specializing in the pertinent region. It then provides the user with pertinent details of these specialists.

## Installation

1. Clone the repository:

bash: 
git clone https://github.com/chiefprotein/OrthoVision_AI

## Install Dependencies
Install according to requirements.txt

## Run the application
bash: 
python manage.py runserver

## Usage
1. Access the system through a web browser.
2. Log in or sign up for a new account.
3. Upload an arm X-ray image for analysis.
4. View the annotated image with bounding boxes around potential fractures and details of identified fracture classes.
5. Receive pertinent details of medical professionals specializing in the identified fracture region.

## Contributing
 Contributions are welcome! Please fork the repository and submit a pull request.
 
## License
This product is licensed by Rajagiri School Of Engineering And Technology



