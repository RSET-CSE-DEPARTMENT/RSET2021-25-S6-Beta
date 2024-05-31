import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package
//import 'dart:io'; // Import dart:io for XFile

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Cover.jpg'),
              fit: BoxFit.cover,
           ),
          ),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text('LOGIN'),
                ),
                SizedBox(height: 500), // Added SizedBox for spacing
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text('CHECK'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckPage extends StatefulWidget {
  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
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
                                  color: Color.fromARGB(255, 241, 234, 231).withOpacity(0.7),// Transparent white background
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

                                    // Clear the text field controller
                                    concernsController.clear();
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
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/3_2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                SizedBox(height: 300.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.brown),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Added border radius
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.lock, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Added border radius
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle login
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 197, 177, 177).withOpacity(0.5),
                        ),
                      ),
                      child: Text('Login'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 197, 177, 177).withOpacity(0.5),
                        ),
                      ),
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  DateTime? _selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _signUp() {
    // Handle sign-up logic here

    // After successful sign-up, navigate back to login page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100), // Added SizedBox for spacing
                Text(
                  'Email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Invalid email format';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Added SizedBox for spacing
                Text(
                  'Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20), // Added SizedBox for spacing
                Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm password is required';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Date of Birth: '),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text(_selectedDate?.formatted() ?? 'Select Date'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Sign Up'),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //void _signUp() {
    // Handle sign-up logic here
  //}
}

extension on DateTime {
  String formatted() {
    return DateFormat.yMd().format(this);
  }
}

class UploadImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image Page')),
      body: Center(child: Text('Welcome to the Upload Image Page!')),
    );
  }
}

