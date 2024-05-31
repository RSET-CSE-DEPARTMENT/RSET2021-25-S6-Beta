import 'package:flutter/material.dart';
import 'beginner.dart'; // Import the BeginnerPage class
import 'intermediate.dart'; // Import the IntermediatePage class
import 'advanced.dart'; // Import the AdvancedPage class

void main() {
  runApp(ans());
}

class ans extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/op.jpg'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 40), // Adjust the left padding here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Beginner button pressed
                    print('Beginner level selected.');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BeginnerPage()), // Navigate to BeginnerPage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0), // No internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Square shape with radius
                    ),
                    elevation: 30, // Add shadow effect
                    backgroundColor: Color.fromARGB(255, 255, 255, 255), // Button color
                  ),
                  child: Container(
                    width: 400, // Increase width
                    height: 75, // Increase height
                    alignment: Alignment.center,
                    child: Text(
                      'BEGINNER',
                      style: TextStyle(fontSize: 20, color: Colors.brown), // Brown font color
                    ),
                  ),
                ),
                SizedBox(height: 50), // Increased spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Intermediate button pressed
                    print('Intermediate level selected.');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IntermediatePage()), // Navigate to IntermediatePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0), // No internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Square shape with radius
                    ),
                    elevation: 5, // Add shadow effect
                    backgroundColor: Color.fromARGB(255, 255, 255, 255), // Button color
                  ),
                  child: Container(
                    width: 400, // Increase width
                    height: 75, // Increase height
                    alignment: Alignment.center,
                    child: Text(
                      'INTERMEDIATE',
                      style: TextStyle(fontSize: 25, color: Colors.brown), // Brown font color
                    ),
                  ),
                ),
                SizedBox(height: 50), // Increased spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    // Advanced button pressed
                    print('Advanced level selected.');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdvancedPage()), // Navigate to AdvancedPage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0), // No internal padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Square shape with radius
                    ),
                    elevation: 5, // Add shadow effect
                    backgroundColor: Color.fromARGB(255, 242, 241, 238), // Button color
                  ),
                  child: Container(
                    width: 400, // Increase width
                    height: 75, // Increase height
                    alignment: Alignment.center,
                    child: Text(
                      'ADVANCED',
                      style: TextStyle(fontSize: 35, color: Colors.brown), // Brown font color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
