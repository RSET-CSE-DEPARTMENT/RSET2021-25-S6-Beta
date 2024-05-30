import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/data/model/wallet/total_expense_model.dart';
import 'package:finance_app/data/model/wallet/wallet_model.dart';
import 'package:finance_app/database/user_database.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> categories = [
  "books",
  "car",
  "clothes",
  "education",
  "food",
  "groceries",
  "phone-bill"
];

class AddExpenseController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  String selectedCategory = "";

  final formKey = GlobalKey<FormState>();

  setSelectedCategory(value) {
    if (value == selectedCategory) {
      selectedCategory = "";
    } else {
      selectedCategory = value;
    }
  }

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Title";
    }
    return null;
  }

  String? amountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Amount";
    }
    return null;
  }

  Future<void> addExpenseToDB() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    final cashInWallet = await userDao.getCashInWallet(user?.uid ?? "") ?? 0;
    final totalExpense = await userDao.getTotalExpense(user?.uid ?? "") ?? 0;
    final amt = double.tryParse(amount.text) ?? 0;

    if (selectedCategory.isEmpty) {
      AppScaffoldManager.getAppScaffoldManager()
          .showSnackBar("Please Select A Category To Continue");
    }

    if (formKey.currentState?.validate() == true &&
        selectedCategory.isNotEmpty) {
      if (amt > cashInWallet) {
        AppScaffoldManager.getAppScaffoldManager()
            .showSnackBar("Insufficient Balance");
        return;
      }

      AppScaffoldManager.getAppScaffoldManager().showLoader();

      IncomeExpenseModel model = IncomeExpenseModel(
          userId: user?.uid,
          title: title.text,
          description: description.text,
          category: selectedCategory,
          amount: amt,
          date: date.text,
          time: time.text,
          type: "expense");

      final transactionRef = FirebaseDatabaseService.transactionRef.push();
      await transactionRef.set(model.toJson());

      final totalExpenseModel =
          TotalExpenseModel(uid: user?.uid, amount: totalExpense + amt);
      final walletModel =
          WalletModel(uid: user?.uid, amount: cashInWallet - amt);

      await userDao.updateCashInWallet(walletModel);
      await userDao.updateTotalExpense(totalExpenseModel);

      final databaseRef =
          FirebaseDatabaseService().databaseRef.child("users/${user?.uid}");
      await databaseRef.update({
        "cashInWallet": cashInWallet - amt,
        "totalExpense": totalExpense + amt
      });

      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      final context = router.routerDelegate.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.go(HomePage.route);
      }
    }
  }
}
