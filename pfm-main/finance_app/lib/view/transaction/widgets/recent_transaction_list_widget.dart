import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/view/transaction/page/transaction_list_page.dart';
import 'package:finance_app/view/transaction/widgets/recent_transaction_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecentTransactionListWidget extends StatelessWidget {
  final List<IncomeExpenseModel> list;

  const RecentTransactionListWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Transactions",
          style: semiBoldTextStyle,
        ),
        10.ph,
        if (list.isEmpty)
          Center(
            child: Text(
              "No Transactions Yet",
              style: semiBoldTextStyle.copyWith(fontSize: 18),
            ),
          ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length > 5 ? 5 : list.length,
          separatorBuilder: (context, index) => 10.ph,
          itemBuilder: (context, index) {
            final model = list[index];
            return RecentTransactionTileWidget(model: model);
          },
        ),
        10.ph,
        if (list.length > 5)
          GestureDetector(
            onTap: () {
              context.push(TransactionListPage.route);
            },
            child: Center(
              child: Text(
                "See More",
                style: mediumTextStyle.copyWith(color: Colors.blue),
              ),
            ),
          )
      ],
    );
  }
}
