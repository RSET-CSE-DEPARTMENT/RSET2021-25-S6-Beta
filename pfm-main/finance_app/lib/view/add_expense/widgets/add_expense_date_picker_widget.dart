import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseDatePickerWidget extends StatefulWidget {
  final TextEditingController controller;

  const AddExpenseDatePickerWidget({super.key, required this.controller});

  @override
  State<AddExpenseDatePickerWidget> createState() =>
      _AddExpenseDatePickerWidgetState();
}

class _AddExpenseDatePickerWidgetState
    extends State<AddExpenseDatePickerWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      final date = DateFormat("MMM d, yyyy").format(DateTime.now());
      widget.controller.text = date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime.now().subtract(const Duration(days: 100000)),
          lastDate: DateTime.now().add(const Duration(days: 100000)),
        );

        if (date != null) {
          setState(() {
            final d = DateFormat("MMM d, yyyy").format(date);
            widget.controller.text = d;
          });
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.calendar_month,
            color: Colors.indigoAccent,
          ),
          10.pw,
          Text(widget.controller.text, style: mediumTextStyle)
        ],
      ),
    );
  }
}
