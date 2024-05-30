import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/data/model/wallet/total_expense_model.dart';
import 'package:finance_app/data/model/wallet/total_income_model.dart';
import 'package:finance_app/data/model/wallet/wallet_model.dart';
import 'package:finance_app/database/user_database.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WalletController {
  final amount = TextEditingController();

  Future<void> addCashToWallet() async {
    AppScaffoldManager.getAppScaffoldManager().showLoader();
    final database =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    final walletModel = WalletModel(
      uid: user?.uid,
      amount: double.tryParse(amount.text),
    );
    final totalIncomeModel = TotalIncomeModel(
      uid: user?.uid,
      amount: double.tryParse(amount.text),
    );
    final totalExpenseModel = TotalExpenseModel(uid: user?.uid, amount: 0.0);
    await userDao.updateCashInWallet(walletModel);
    await userDao.updateTotalIncome(totalIncomeModel);
    await userDao.updateTotalExpense(totalExpenseModel);

    final databaseRef =
        FirebaseDatabaseService().databaseRef.child("users/${user?.uid}");
    await databaseRef.update({
      "cashInWallet": double.tryParse(amount.text),
      "totalIncome": double.tryParse(amount.text),
      "totalExpense": 0.0
    });

    AppScaffoldManager.getAppScaffoldManager().hideLoader();
    final context = router.routerDelegate.navigatorKey.currentContext;
    if (context!= null && context.mounted) {
      context.go(HomePage.route);
    }
  }

  Future<void> updateCashInWallet() async {
    AppScaffoldManager.getAppScaffoldManager().showLoader();
    final database =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    final cashInWallet = await userDao.getCashInWallet(user?.uid ?? '') ?? 0.0;
    final totalIncome = await userDao.getTotalIncome(user?.uid ?? '') ?? 0.0;

    final cash = double.tryParse(amount.text) ?? 0.0;

    final walletModel = WalletModel(
      uid: user?.uid,
      amount: cashInWallet + cash,
    );
    final totalIncomeModel = TotalIncomeModel(
      uid: user?.uid,
      amount: totalIncome + cash,
    );

    await userDao.updateCashInWallet(walletModel);
    await userDao.updateTotalIncome(totalIncomeModel);

    final databaseRef =
        FirebaseDatabaseService().databaseRef.child("users/${user?.uid}");
    await databaseRef.update({
      "cashInWallet": cashInWallet + cash,
      "totalIncome": totalIncome + cash
    });

    AppScaffoldManager.getAppScaffoldManager().hideLoader();
    final context = router.routerDelegate.navigatorKey.currentContext;
    if (context!= null && context.mounted) {
      context.go(HomePage.route);
    }
  }
}
