import 'dart:async';
import 'dart:convert';

import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/view/dashboard/controller/dashboard_controller.dart';
import 'package:finance_app/view/transaction/widgets/add_transaction_button.dart';
import 'package:finance_app/view/transaction/widgets/category_expense_chart_widget.dart';
import 'package:finance_app/view/transaction/widgets/recent_transaction_list_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _dashboardController = DashboardController();

  final transactionRef = FirebaseDatabaseService.transactionRef;
  List<IncomeExpenseModel> list = [];
  late StreamSubscription<DatabaseEvent> ref;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() async {
    ref = transactionRef.onValue.listen((event) async {
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
        actions: [
          IconButton(
            onPressed: () {
              _dashboardController.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const AddTransactionButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            20.ph,
            CategoryExpenseChart(list: list),
            30.ph,
            RecentTransactionListWidget(list: list),
            50.ph,
          ],
        ),
      ),
    );
  }
}
