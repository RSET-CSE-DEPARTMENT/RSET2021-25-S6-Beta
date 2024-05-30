import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:finance_app/view/onboard/pages/login_page.dart';
import 'package:finance_app/view/splash/controller/splash_controller.dart';
import 'package:finance_app/view/wallet/pages/add_amount_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        final ctx = router.routerDelegate.navigatorKey.currentContext;
        final user = await _controller.getUser();
        final amount = await _controller.getAmount();
        if (ctx != null && ctx.mounted) {
          if (user != null) {
            if (amount == null) {
              ctx.go(AddAmountPage.route);
            } else {
              ctx.go(HomePage.route);
            }
          } else {
            ctx.go(LoginPage.route);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
