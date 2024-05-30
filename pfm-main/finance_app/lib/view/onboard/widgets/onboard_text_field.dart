import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

import '../decorations/onboard_text_field_decoration.dart';

class OnBoardTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool obscureText;

  const OnBoardTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<OnBoardTextField> createState() => _OnBoardTextFieldState();
}

class _OnBoardTextFieldState extends State<OnBoardTextField> {
  bool obscureText = false;

  onTap() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      style: mediumTextStyle,
      obscureText: obscureText,
      validator: widget.validator,
      decoration: onBoardTextFieldDecoration(
        widget.hintText,
        widget.obscureText,
        onTap,
      ),
    );
  }
}
