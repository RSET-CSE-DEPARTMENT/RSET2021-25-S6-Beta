import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:skkn/second.dart';
import 'package:skkn/threeoption.dart';
import 'second.dart'; // Import the next page file
import 'threeoption.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remove debug banner
    home: HomeAnsPage(),
  ));
}

class HomeAnsPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeAnsPage> {
  String data = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String fileData = await rootBundle.loadString('assets/data.txt');
    setState(() {
      data = fileData;
    });
  }

  String getImagePath() {
    if (data.toLowerCase().contains('oily')) {
      return 'assets/images/oily.jpg';
    } else if (data.toLowerCase().contains('dry')) {
      return 'assets/images/dry.png';
    } else if (data.toLowerCase().contains('combination')) {
      return 'assets/images/combination.webp';
    } else if (data.toLowerCase().contains('sensitive')) {
      return 'assets/images/sensitve.jpg';
    } else if (data.toLowerCase().contains('normal')) {
      return 'assets/images/normal.jpg';
    } else {
      return ''; // Return empty string if no match found
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero, // This sets the app bar size to zero
        child: Container(), // Empty container to remove the app bar
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'), // Replace with your background image path
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      readOnly: true,
                      controller: TextEditingController(text: data),
                      maxLines: null,
                      style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 210, 185, 176)), // Change text color to brown
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ans()), // Navigate to the next page
                        );
                      },
                      child: Text('Next Page'),
                    ),
                    SizedBox(height: 20),
                   // Display image conditionally based on text content
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
