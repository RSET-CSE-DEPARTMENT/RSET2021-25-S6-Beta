import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  String analysisResult = ''; // Variable to store the analysis result

  Future<void> analyzeImage(String imagePath) async {
    var url = Uri.parse('http://127.0.0.1:5000/upload'); // Update URL with your Flask server details
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    var response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      var result = jsonDecode(jsonResponse)['result'];
      setState(() {
        analysisResult = result; // Update the analysisResult variable with the obtained result
      });
      _showAnalysisResultDialog(); // Show a dialog box with the analysis result
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> _handleCameraButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Call API to analyze image
      await analyzeImage(image.path);
    }
  }

  Future<void> _handleUploadButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Call API to analyze image
      await analyzeImage(image.path);
    }
  }

  void _showAnalysisResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Analysis Result'),
          content: Text(analysisResult), // Display the analysis result in the dialog content
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Analysis',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Analysis'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _handleCameraButton,
                child: Text('Capture Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleUploadButton,
                child: Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
