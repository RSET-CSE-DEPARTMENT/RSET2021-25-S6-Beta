import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/view/profile/widget/profile_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TitleValuePairWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool isEdit;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TitleValuePairWidget({
    super.key,
    required this.title,
    required this.value,
    this.isEdit = false,
    required this.controller,
    required this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: lightTextStyle.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        5.ph,
        if (isEdit)
          ProfileTextFieldWidget(
            controller: controller,
            keyboardType: TextInputType.text,
            inputFormatters: inputFormatters,
          )
        else
          Text(value, style: semiBoldTextStyle),
        10.ph,
      ],
    );
  }
}
