import 'package:flutter/material.dart';
import 'package:ride_share_test/components/signin_textfield.dart';
import 'package:ride_share_test/services/Firestore_crud.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _emergencyContactController = TextEditingController();
  final _mobileController = TextEditingController();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("contact"),
          SigninTextfield(
              controller: _mobileController,
              hintText: "Mobile number",
              obscureText: false),
          Text("Age"),
          SigninTextfield(
              controller: _ageController, hintText: "Age ", obscureText: false),
          Text("Emergency contact"),
          SigninTextfield(
              controller: _emergencyContactController,
              hintText: "Emergency contact",
              obscureText: false),
          Text("Bio"),
          SigninTextfield(
              controller: _bioController, hintText: "Bio", obscureText: false),
          ElevatedButton(
              onPressed: () => FirestoreCrud().editUsreDetails(
                  _mobileController.text,
                  _ageController.text,
                  _emergencyContactController.text,
                  _bioController.text),
              child: Text("Save"))
        ],
      ),
    );
  }
}
