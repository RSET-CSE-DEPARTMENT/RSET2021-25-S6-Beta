import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
//import 'dart:io'; // Import dart:io for XFile

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String answer4 = '';
  String answer5 = '';
  String answer6 = '';
  TextEditingController concernsController = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  // Method to handle camera button press
  Future<void> _handleCameraButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the image picked from camera
      print('Image from camera: ${image.path}');
    }
  }

  // Method to handle upload button press
  Future<void> _handleUploadButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the image picked from gallery
      print('Image from gallery: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable Background',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 250), // Added space from the top
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0), // Adjusted horizontal padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Adjusted alignment
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1.0, // Adjusted container width
                                padding: EdgeInsets.all(20.0), // Added padding
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8), // Transparent white background
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Does your T-Zone feel oily throughout the day?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Does your skin feel tight after cleansing it with water?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'How badly does your skin react to most products?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Do you often experience redness or stinging on your face?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Does your skin burn when exposed to sunlight? ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Add more questions and radio buttons as needed

                                    Text(
                                      'Additional Concerns:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextField(
                                      controller: concernsController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your concerns here',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Center( // Centered submit button
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle submit button press
                                    print('Submit button pressed');
                                    print('Answer 1: $answer1');
                                    print('Answer 2: $answer2');
                                    // Print other answers as needed
                                    print('Additional Concerns: ${concernsController.text}');
                                  },
                                  child: Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1, // Adjusted top value
                right: 15, // Adjusted right value to move icons to the left
                child: Column( // Wrap Row with Column for vertical alignment
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 50, // Width for spacing
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera),
                            iconSize: 60, // Increase icon size
                            onPressed: _handleCameraButton,
                            tooltip: 'Capture',
                            color: Colors.brown, // Set icon color to brown
                          ),
                          Text(
                            'Capture', // Label for the camera icon
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30), // Added space between icons
                    SizedBox(
                      width: 50, // Width for spacing
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.upload_file),
                            iconSize: 60, // Increase icon size
                            onPressed: _handleUploadButton,
                            tooltip: 'Upload Image',
                            color: Colors.brown, // Set icon color to brown
                          ),
                          Text(
                            'Upload', // Label for the upload icon
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
