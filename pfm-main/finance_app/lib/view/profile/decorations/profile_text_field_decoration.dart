import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration profileTextFieldDecoration() {
  return const InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}
