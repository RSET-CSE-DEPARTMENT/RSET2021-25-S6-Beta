import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'type.dart';

void main() {
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false, // Remove debug banner
    home: HomePageButton(),
  ));
}

class HomePageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.jpg'), // Replace with your background image path
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
                        onPressed: () {
                          // Handle camera button press
                          print('Camera button pressed');
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Camera'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle upload button press
                          print('Upload button pressed');
                        },
                        icon: Icon(Icons.upload_file),
                        label: Text('Upload'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeAnsPage()),
          );
                      // Handle submit button press
                      print('Submit button pressed');
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}