import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

InputDecoration addExpenseTextFieldDecoration(String hintText,
    {bool isAmount = false}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    hintText: hintText,
    hintStyle: lightTextStyle.copyWith(color: Colors.black45),
    prefix:
        isAmount ? Text("\u{20B9}", style: mediumTextStyle) : const SizedBox(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white70),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red),
    ),
  );
}
