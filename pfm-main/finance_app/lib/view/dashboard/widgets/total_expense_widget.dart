import 'package:finance_app/common/widget/common_container.dart';
import 'package:finance_app/common/widget/title_value_pair_widget.dart';
import 'package:finance_app/view/dashboard/widgets/decrement_indicator_widget.dart';
import 'package:flutter/material.dart';

class TotalExpenseWidget extends StatelessWidget {
  const TotalExpenseWidget({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: DecrementIndicatorWidget(),
            ),
            TitleValuePairWidget(
              title: "Total Expense",
              value: "-\u{20B9}$amount",
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ],
        ),
      ),
    );
  }
}
