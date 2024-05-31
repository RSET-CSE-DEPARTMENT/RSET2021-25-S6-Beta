import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';

class TitleValuePairWidget extends StatelessWidget {
  final String title, value;
  final CrossAxisAlignment crossAxisAlignment;

  const TitleValuePairWidget({
    super.key,
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.center
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: regularTextStyle.copyWith(fontSize: 12, color: Colors.grey),
        ),
        5.ph,
        Text(
          value,
          style: semiBoldTextStyle,
        ),
      ],
    );
  }
}
