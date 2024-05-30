import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

InputDecoration onBoardTextFieldDecoration(
  String hintText,
  bool shouldShowSuffixIcon,
  Function() onTap,
) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: lightTextStyle.copyWith(color: Colors.black45),
    suffix: shouldShowSuffixIcon
        ? GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: const Icon(Icons.remove_red_eye),
          )
        : const SizedBox(),
    errorStyle: regularTextStyle.copyWith(fontSize: 12, color: Colors.red),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}
