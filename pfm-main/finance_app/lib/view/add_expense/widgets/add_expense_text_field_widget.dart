import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/view/add_expense/decoration/add_expense_text_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool isAmount;

  const AddExpenseTextFieldWidget({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText = "",
    this.textCapitalization = TextCapitalization.words,
    this.validator,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.isAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: mediumTextStyle,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: addExpenseTextFieldDecoration(hintText, isAmount: isAmount),
    );
  }
}
