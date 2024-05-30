import 'dart:async';
import 'dart:convert';

import 'package:finance_app/common/extension/space_extension.dart';
import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/view/dashboard/controller/dashboard_controller.dart';
import 'package:finance_app/view/dashboard/widgets/add_wallet_button.dart';
import 'package:finance_app/view/dashboard/widgets/income_expense_widget.dart';
import 'package:finance_app/view/dashboard/widgets/total_balance_widget.dart';
import 'package:finance_app/view/dashboard/widgets/transaction_chart_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _controller = DashboardController();

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
          "Dashboard",
          style: semiBoldTextStyle.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _controller.signOut();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      floatingActionButton: const AddWalletButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ph,
            const TotalBalanceWidget(),
            20.ph,
            const IncomeExpenseWidget(),
            20.ph,
            TransactionChartWidget(list: list),
            30.ph,
          ],
        ),
      ),
    );
  }
}
