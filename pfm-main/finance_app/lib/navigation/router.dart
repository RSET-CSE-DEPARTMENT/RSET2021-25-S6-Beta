import 'package:finance_app/base/scaffold_key.dart';
import 'package:finance_app/view/add_expense/pages/add_expense_page.dart';
import 'package:finance_app/view/goals/pages/add_goals_page.dart';
import 'package:finance_app/view/home/page/home_page.dart';
import 'package:finance_app/view/onboard/pages/login_page.dart';
import 'package:finance_app/view/onboard/pages/sign_up_page.dart';
import 'package:finance_app/view/splash/page/splash_page.dart';
import 'package:finance_app/view/transaction/page/transaction_list_page.dart';
import 'package:finance_app/view/wallet/pages/add_amount_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final router = GoRouter(
  navigatorKey: AppScaffoldManager.getAppScaffoldManager().navigatorKey,
  routes: [
    ///SplashPage
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),

    ///LoginPage
    GoRoute(
      path: LoginPage.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: LoginPage(),
      ),
    ),

    ///SignUp
    GoRoute(
      path: SignUpPage.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: SignUpPage(),
      ),
    ),

    ///HomePage
    GoRoute(
      path: HomePage.route,
      builder: (context, state) => const HomePage(),
      // pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      //   context: context,
      //   state: state,
      //   child: const HomePage(),
      // ),
    ),

    ///AddExpensePage
    GoRoute(
      path: AddExpensePage.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: const AddExpensePage(),
      ),
    ),

    ///AddAmountPage
    GoRoute(
      path: AddAmountPage.route,
      pageBuilder: (context, state) {
        bool? extra = state.extra as bool?;
        return buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: AddAmountPage(isFromSignUp: extra ?? false),
        );
      },
    ),

    ///TransactionListPage
    GoRoute(
      path: TransactionListPage.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const TransactionListPage(),
      ),
    ),

    ///TransactionListPage
    GoRoute(
      path: AddGoalsPage.route,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: AddGoalsPage(),
      ),
    )
  ],
);
