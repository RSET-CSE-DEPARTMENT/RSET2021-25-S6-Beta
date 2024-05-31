import 'dart:io';
import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  VoidCallback? onSuccess;
  VoidCallback? onProfileUpdateComplete;

  final user = FirebaseAuthService().currentUser;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  updateImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      if(context.mounted) context.pop();
      AppScaffoldManager.getAppScaffoldManager().showLoader();
      final path = "files/${image.name}";
      final file = File(image.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask =  ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      try {
        await FirebaseAuthService().currentUser?.updatePhotoURL(url);
        onSuccess?.call();
      } on FirebaseException catch(e){
        debugPrint("hereHit ${e.message}");
      }
    }
  }

  updateProfile() async {
    AppScaffoldManager.getAppScaffoldManager().showLoader();
    await user?.updateDisplayName(name.text);
    onProfileUpdateComplete?.call();
  }
}
