import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/firebase/firebase_database.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoalsController {
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();

  final formKey = GlobalKey<FormState>();

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

  Future<void> addNewGoal() async {
    if (formKey.currentState?.validate() == true) {
      AppScaffoldManager.getAppScaffoldManager().showLoader();
      final goalRef = FirebaseDatabaseService.goalsRef.push();
      await goalRef.set({
        "userId": FirebaseAuthService().currentUser?.uid,
        "title": title.text,
        "amount": double.tryParse(amount.text)
      });

      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      final context = router.routerDelegate.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.go(HomePage.route);
      }
    }
  }
}
