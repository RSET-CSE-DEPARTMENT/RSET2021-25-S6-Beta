import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/view/transaction/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

class CategoryExpenseChart extends StatelessWidget {
  final List<IncomeExpenseModel> list;

  const CategoryExpenseChart({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category Wise Expense Chart",
            style: semiBoldTextStyle,
          ),
          20.ph,
          ChartWidget(list: list),
        ],
      ),
    );
  }
}
