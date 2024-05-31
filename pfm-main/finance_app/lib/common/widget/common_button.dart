import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          ),
        ),
        child: Text(
          text,
          style: semiBoldTextStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
