import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_test/components/signin_button.dart';
import 'package:ride_share_test/components/signin_textfield.dart';
import 'package:ride_share_test/services/Firestore_crud.dart';
import 'package:ride_share_test/services/auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _ageController = TextEditingController();

  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? errorMessage = "";

  //Use in register page
  Future<void> createUserWithEmailAndPassword() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _ageController.text.isEmpty) {
      setState(() {
        errorMessage = "Please Fill all Fields";
      });
    } else {
      try {
        await Auth()
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )
            .then((value) => FirestoreCrud().createUser(
                _usernameController.text,
                _ageController.text,
                _emailController.text,
                _mobileController.text))
            .then((value) => Navigator.pop(context));
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    }
  }

  // void writeToFirestore() {
  //   // Define the data you want to write
  //   Map<String, dynamic> data = {
  //     'name': _usernameController.text,
  //     'age': _ageController.text,
  //     'email': _emailController.text,
  //     'mobile_number': _mobileController.text,
  //     'distance_travelled': '0',
  //     'emergency_contact': "",
  //     'level': 'Bronze',
  //     'rides_as_passenger': '0',
  //     'rides_as_driver': '0'
  //   };

  //   // Add the data to Firestore
  //   _firestore.collection('Users').add(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register"),
            SigninTextfield(
              controller: _emailController,
              hintText: 'email',
              obscureText: false,
            ),
            SigninTextfield(
              controller: _passwordController,
              hintText: 'password',
              obscureText: false,
            ),
            SigninTextfield(
              controller: _usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            SigninTextfield(
              controller: _mobileController,
              hintText: 'Mobile number',
              obscureText: false,
            ),
            SigninTextfield(
              controller: _ageController,
              hintText: 'Age',
              obscureText: false,
            ),
            SigninButton(onTap: createUserWithEmailAndPassword),
            Text(errorMessage ?? ""),
          ],
        ),
      )),
    );
  }
}
