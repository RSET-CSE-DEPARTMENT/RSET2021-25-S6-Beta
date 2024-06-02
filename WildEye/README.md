# WildEye
WildEye is a ML-based wildlife monitoring system aimed at promoting harmony between human habitats and forested areas. Cameras strategically placed at the interface between human settlements and forests are used to detect wildlife like elephants and tigers. Detected animals trigger alerts containing time, location, and images, which are sent to nearby devices and wildlife departments. Recent alerts are logged and accessible via dedicated app or web platform. Users can also privately report animal sightings. This project contributes to improving wildlife management and reduce human-wildlife conflicts.
## Back End
The project asssumes there exist multiple IP cameras which are strategically postioned near forest borders. Feed from the cameras are fed into the server. 
Server is a Object oriented python program in which, each cameras are declared as object of `detect` class. 
YOLOv7 model is used for identifying elephants from the camera feed.
Feed from the camera is fed into the python program using RTSP protocol.
`customized_detect.py` is the backend server.
### Requirements
To run this file, system must have GPU and CUDA installed.
The weight file used for our project is `ele_best2.pt`. Our project is focused on Elephant detection. If you have trained your own YOLO model with multiple animals, you can replace it in the statement `self.weights = YOUR_FILE.pt` inside python program. 
```markdown
python customized_detect.py
```
When elephant is detected,notification alert is send to the android devices through Firebase Cloud Messaging feature. The detection details like animal identified,timestamp,cameraID and detected image is logged into the `log` table, which is in our Firebase database. 
## Database
We hosted five database tables in Firebase. They are given below :
#### Logs
Contains details like detected cameraID, timestamp, animal and URL of detected image
#### camera
Contains details of each camera like cameraID, place, latitude, longitude and no. of sightings so far
#### messgtable
Store messages in report chatroom. Details associated with each message like author, message and timestamp is stored
#### signup
Contains details about users like authentication, place, ph. no and email
#### tokens
To initiaze Cloud messaging feature, we need FCM tokens of these specific devices. This table stores FCM token of each devices 
## Front End
Front end consists of two apps:
#### NOTE : Before using both admin and user flutter projects, connect your projects to your firebase account using `flutterfire`
### User App
Android app which need minimum SDK version of 21. Receives alert, view recent alerts along with detected image. Map screen with cameras marked in it. There is a report chatroom feature in which Admin can broadcast important notices or share information. Users can also raise concerns in it, which will be visible in admin inbox. `User` folder contains the flutter project of user app. Run the command below in cmd to build apk
```markdown 
flutter build apk
```
### Admin App
This is a web application handled by respective Authority. Functionalities include receive concerns from public, broadcast alerts, management of cameras and flagging users. Run the command below in the admin folder to launch the application in web browser
```markdown 
flutter run
```
