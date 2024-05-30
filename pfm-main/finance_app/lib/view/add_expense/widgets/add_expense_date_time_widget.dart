import 'package:finance_app/view/add_expense/widgets/add_expense_date_picker_widget.dart';
import 'package:finance_app/view/add_expense/widgets/add_expense_time_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpenseDateTimeWidget extends StatelessWidget {
  final TextEditingController date;
  final TextEditingController time;

  const AddExpenseDateTimeWidget({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: AddExpenseDatePickerWidget(controller: date)),
        Expanded(child: AddExpenseTimePickerWidget(controller: time)),
      ],
    );
  }
}
