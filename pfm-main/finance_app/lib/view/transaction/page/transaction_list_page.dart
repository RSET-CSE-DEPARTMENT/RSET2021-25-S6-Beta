import 'dart:async';
import 'dart:convert';

import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/view/transaction/widgets/recent_transaction_tile_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TransactionListPage extends StatefulWidget {
  static const String route = "/transactionListPageRoute";

  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  final transactionRef = FirebaseDatabaseService.transactionRef;
  List<IncomeExpenseModel> list = [];
  late StreamSubscription<DatabaseEvent> ref;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    ref = transactionRef.onValue.listen((event) {
      List<IncomeExpenseModel> items = [];
      for (var element in event.snapshot.children) {
        final json = jsonEncode(element.value);
        items.add(IncomeExpenseModel.fromJson(jsonDecode(json)));
      }
      setState(() {
        list = items
            .where((element) =>
                element.userId == FirebaseAuthService().currentUser?.uid)
            .toList()
            .reversed
            .toList();
      });
    });
  }

  @override
  void dispose() {
    ref.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Transactions",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            20.ph,
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              separatorBuilder: (context, index) => 10.ph,
              itemBuilder: (context, index) {
                final model = list[index];
                return RecentTransactionTileWidget(model: model);
              },
            ),
          ],
        ),
      ),
    );
  }
}
