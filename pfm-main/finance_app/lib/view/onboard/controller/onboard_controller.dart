import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/common/util/email_validator.dart';
import 'package:finance_app/data/model/user/user_model.dart';
import 'package:finance_app/data/model/wallet/total_expense_model.dart';
import 'package:finance_app/data/model/wallet/total_income_model.dart';
import 'package:finance_app/data/model/wallet/wallet_model.dart';
import 'package:finance_app/database/user_database.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:finance_app/view/wallet/pages/add_amount_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardController {
  final _authService = FirebaseAuthService();

  final formKey = GlobalKey<FormState>();

  VoidCallback? onSuccess;
  VoidCallback? onFailure;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Email ID";
    }
    if (!isValidEmail(value)) {
      return "Enter A Valid Email ID";
    }
    return null;
  }

  String? loginPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }
    return null;
  }

  String? signUpPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter Password";
    }

    if (value.length < 6) {
      return "Password must have AT LEAST 6 characters";
    }

    if (confirmPassword.text.isNotEmpty && value != confirmPassword.text) {
      return "Passwords Do No Match";
    }

    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Confirm Password";
    }

    if (password.text.isNotEmpty && value != password.text) {
      return "Passwords Do No Match";
    }

    return null;
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    final user = await _authService.signInWithEmailAndPassword(
        email: email.text, password: password.text);

    if (user != null) {
      final snapShot = await FirebaseDatabaseService()
          .databaseRef
          .child("users/${user.uid}")
          .get();

      UserModel model = UserModel.fromJson({
        "uid": user.uid,
        "email": user.email,
        "name": user.displayName,
        "phone": user.phoneNumber,
        "photo": user.photoURL,
        "cashInWallet":
            double.tryParse(snapShot.child('cashInWallet').value.toString()),
        "totalIncome":
            double.tryParse(snapShot.child('totalIncome').value.toString()),
        "totalExpense":
            double.tryParse(snapShot.child('totalExpense').value.toString()),
      });

      await addUserToDB(model);

      final amount = await getCashInWallet(model.uid ?? "");

      final context = router.routerDelegate.navigatorKey.currentContext;
      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      if (context != null && context.mounted) {
        if (amount == null) {
          context.go(AddAmountPage.route, extra: true);
        } else {
          context.go(HomePage.route);
        }
      }
    }
  }

  Future<void> signUp() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    final user = await _authService.signUpWithEmailAndPassword(
      email: email.text,
      password: password.text,
      name: name.text,
    );

    if (user != null) {
      final json = {
        "uid": user.uid,
        "email": user.email,
        "name": user.displayName,
        "phone": user.phoneNumber,
        "photo": user.photoURL,
        "cashInWallet": 0.0,
        "totalIncome": 0.0,
        "totalExpense": 0.0,
      };

      UserModel model = UserModel.fromJson(json);
      await addUserToDB(model);

      final databaseRef =
          FirebaseDatabaseService().databaseRef.child("users/${model.uid}");
      await databaseRef.set(model.toJson());

      final context = router.routerDelegate.navigatorKey.currentContext;
      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      if (context != null && context.mounted) {
        context.go(AddAmountPage.route, extra: true);
      }
    }
  }

  Future<double?> getCashInWallet(String userId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    return await userDao.getCashInWallet(userId);
  }

  Future<void> addUserToDB(UserModel model) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;

    final walletModel = WalletModel(uid: model.uid, amount: model.cashInWallet);
    final totalExpenseModel =
        TotalExpenseModel(uid: model.uid, amount: model.totalExpense);
    final totalIncomeModel =
        TotalIncomeModel(uid: model.uid, amount: model.totalIncome);

    await userDao.deleteAllUsers();
    await userDao.deleteWallet();
    await userDao.deleteTotalIncome();
    await userDao.deleteTotalExpense();
    await userDao.insertUser(model);
    await userDao.addCashToWallet(walletModel);
    await userDao.addTotalIncome(totalIncomeModel);
    await userDao.addTotalExpense(totalExpenseModel);
  }
}
