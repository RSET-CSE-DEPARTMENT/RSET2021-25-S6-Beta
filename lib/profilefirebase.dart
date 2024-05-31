import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the profile page is loaded
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _userName = userData['name'];
        _userEmail = userData['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your profile page layout
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/images/profile_background.jpg'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      _userName ?? 'Guest',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 8, 7, 7),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      _userEmail ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: const Color.fromARGB(255, 4, 3, 3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            child: BackButton(color: const Color.fromARGB(255, 7, 6, 6)),
          ),
          Positioned(
            top: 40.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Handle settings button press
              },
            ),
          ),
        ],
      ),
    );
  }
}
