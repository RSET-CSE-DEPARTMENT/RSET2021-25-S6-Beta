import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/extension/string_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/common/widget/common_container.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:flutter/material.dart';

class RecentTransactionTileWidget extends StatelessWidget {
  final IncomeExpenseModel model;

  const RecentTransactionTileWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    String amount = "${model.type == "income" ? "+" : "-"}\u{20B9}${model.amount}";
    return CommonContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            TransactionIconWidget(category: model.category ?? ""),
            10.pw,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.title ?? "",
                    style: semiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  Text(
                    model.category?.toTitleCase ?? "",
                    style: mediumTextStyle.copyWith(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            10.pw,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: semiBoldTextStyle.copyWith(
                    fontSize: 16,
                    color: model.type == "income" ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  model.date ?? "",
                  style: mediumTextStyle.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionIconWidget extends StatelessWidget {
  final String category;

  const TransactionIconWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF1F1F1),
      child: Image.asset(
        "assets/categories_icons/$category.png",
        height: 40,
        width: 40,
      ),
    );
  }
}
