// camera1.dart
// camera1.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart'; // Add this import for Firebase
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePageButtons(),
  ));
}

class HomePageButtons extends StatefulWidget {
  @override
  _HomePageButtonState createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButtons> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  bool _isImagePickerActive = false;

  Future<void> _pickImage(ImageSource source) async {
    if (!_isImagePickerActive) {
      setState(() {
        _isImagePickerActive = true;
      });

      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
        print('Image picked: ${pickedFile.path}');
        _uploadImageToFirebase(); // Upload image to Firebase Storage
      }

      setState(() {
        _isImagePickerActive = false;
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image != null) {
      try {
        // Create a reference to the Firebase Storage path
        Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
        
        // Upload the file to Firebase Storage
        UploadTask uploadTask = storageRef.putFile(File(_image!.path));

        // Get the download URL after the upload is complete
        await uploadTask.whenComplete(() async {
          String downloadURL = await storageRef.getDownloadURL();
          
          // Print the download URL
          print('Image uploaded to Firebase: $downloadURL');
          
          // Trigger the Cloud Function
          triggerCloudFunction(downloadURL);
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  // Function to trigger the Cloud Function
  Future<void> triggerCloudFunction(String imageUrl) async {
    try {
      // Replace 'your-cloud-function-url' with the URL of your Cloud Function
      final response = await http.post('your-cloud-function-url' as Uri, body: {'imageUrl': imageUrl});
      print('Cloud Function response: ${response.body}');
    } catch (e) {
      print('Error triggering Cloud Function: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: Icon(Icons.camera_alt),
                        label: Text('Camera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: Icon(Icons.upload_file),
                        label: Text('Upload'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Optional: Navigate to a new page or perform other actions after upload
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeAnsPage()),
                      );
                    },
                    child: Text('Submit'),
                  ),
                  if (_image != null) ...[
                    SizedBox(height: 20),
                    Image.file(File(_image!.path)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAnsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Answer Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Image uploaded to Firebase:'),
            SizedBox(height: 20), // Add spacing between text and button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeAnsPagess()), // Navigate to NextPage
                );
              },
              child: Text('Go to Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}
