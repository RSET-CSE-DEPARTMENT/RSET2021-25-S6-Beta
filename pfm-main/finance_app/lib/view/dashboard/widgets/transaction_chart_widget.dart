import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/view/dashboard/widgets/expense_chart_widget.dart';
import 'package:flutter/material.dart';

class TransactionChartWidget extends StatelessWidget {
  final List<IncomeExpenseModel> list;

  const TransactionChartWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Expense Chart",
            style: semiBoldTextStyle,
          ),
          20.ph,
          ExpenseChartWidget(list: list)
        ],
      ),
    );
  }
}
