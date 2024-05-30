import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseTimePickerWidget extends StatefulWidget {
  final TextEditingController controller;

  const AddExpenseTimePickerWidget({super.key, required this.controller});

  @override
  State<AddExpenseTimePickerWidget> createState() =>
      _AddExpenseTimePickerWidgetState();
}

class _AddExpenseTimePickerWidgetState
    extends State<AddExpenseTimePickerWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      final time = DateFormat("hh:mm aa").format(DateTime.now());
      widget.controller.text = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (time != null) {
          setState(() {
            final localizations = MaterialLocalizations.of(context);
            final formattedTimeOfDay = localizations.formatTimeOfDay(time);
            widget.controller.text = formattedTimeOfDay;
          });
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.access_time,
            color: Colors.indigoAccent,
          ),
          10.pw,
          Text(widget.controller.text, style: mediumTextStyle)
        ],
      ),
    );
  }
}
