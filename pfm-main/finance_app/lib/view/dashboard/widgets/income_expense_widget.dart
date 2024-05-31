import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/view/dashboard/controller/dashboard_controller.dart';
import 'package:finance_app/view/dashboard/widgets/total_expense_widget.dart';
import 'package:finance_app/view/dashboard/widgets/total_income_widget.dart';
import 'package:flutter/material.dart';

class IncomeExpenseWidget extends StatefulWidget {
  const IncomeExpenseWidget({super.key});

  @override
  State<IncomeExpenseWidget> createState() => _IncomeExpenseWidgetState();
}

class _IncomeExpenseWidgetState extends State<IncomeExpenseWidget> {
  final _controller = DashboardController();
  double income = 0.0;
  double expense = 0.0;

  @override
  initState() {
    super.initState();
    setAmount();
  }

  setAmount() async {
    income = await _controller.getTotalIncome() ?? 0;
    expense = await _controller.getTotalExpense() ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TotalIncomeWidget(amount: income),
        ),
        10.pw,
        Expanded(
          child: TotalExpenseWidget(amount: expense),
        ),
      ],
    );
  }
}
