import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/view/profile/decorations/profile_text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ProfileTextFieldWidget({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.words,
      style: mediumTextStyle,
      inputFormatters: inputFormatters,
      decoration: profileTextFieldDecoration(),
    );
  }
}
