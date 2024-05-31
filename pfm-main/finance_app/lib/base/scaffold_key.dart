import 'package:finance_app/common/theme/style/text_style.dart';
import 'package:finance_app/easy_loading/easy_loading.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class AppScaffoldManager {
  static AppScaffoldManager getAppScaffoldManager() {
    return AppScaffoldManager();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState>? scaffoldState;

  ScaffoldFeatureController? scaffoldFeatureController;

  void showSnackBar(String message) {
    print("showSnackBar invoked: ${message.trim()}");
    ScaffoldMessengerState? context = rootScaffoldMessengerKey.currentState;
    if (context != null && message.trim().isNotEmpty) {
      context
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(
            message,
            style: regularTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.black87,
        ));
    }
  }

  void closeSnackBar() {
    try {
      scaffoldFeatureController?.close();
    } catch (e) {
      print(e);
    }
  }

  void showLoader() {
    print("showLoader invoked");
    try {
      EasyLoading.show(
          status: 'Loading...', maskType: EasyLoadingMaskType.black);
    } catch (e) {
      print(e);
    }
  }

  void hideLoader() {
    try {
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<ScaffoldState> getScaffoldState(bool isNewKey) {
    if (scaffoldState == null || isNewKey) {
      scaffoldState = GlobalKey<ScaffoldState>();
      return scaffoldState!;
    } else {
      return scaffoldState!;
    }
  }
}
