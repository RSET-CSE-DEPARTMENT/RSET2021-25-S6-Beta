import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './signup_page.dart';
//import './succes .dart';
import './sub.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Add padding for aesthetics
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
              ),
              SizedBox(height: 20.0), // Add spacing between fields
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password characters
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: 20.0), // Add spacing before button
              ElevatedButton(
                onPressed: login,
                child: Text('LOGIN'),
              ),
              SizedBox(height: 20.0), // Add spacing before button
              ElevatedButton(
                onPressed: signing,
                child: Text('SIGNUP'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signing() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  void login() async {
    String emailip = _emailController.text;
    String passwordip = _passwordController.text;
    // Initialize Firebase
    await Firebase.initializeApp();
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool found = false;
    // Add data to Firestore
    try {
      QuerySnapshot querySnapshot = await firestore.collection('signup').get();
      querySnapshot.docs.forEach((doc) {
        // Access data from each document
        String email = doc['email'];
        String password = doc['password'];

        if ((email == emailip) & (password == passwordip)) {
          found = true;

          Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => HomePage(userEmail: emailip),
  ),
);
        }
      });
      if (!found) {
        // Show a popup if credentials are not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text('The email or password you entered is incorrect.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
}
