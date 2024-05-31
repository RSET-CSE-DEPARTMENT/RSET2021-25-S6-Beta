import 'package:finance_app/database/user_database.dart';
import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:finance_app/navigation/router.dart';
import 'package:finance_app/view/onboard/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class DashboardController {
  final _authService = FirebaseAuthService();

  void getUser() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    await userDao.getUser();
  }

  Future<double?> getCashInWallet() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    if (user != null) {
      return await userDao.getCashInWallet(user.uid ?? "");
    }
    return null;
  }

  Future<double?> getTotalIncome() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    if (user != null) {
      return await userDao.getTotalIncome(user.uid ?? "");
    }
    return null;
  }

  Future<double?> getTotalExpense() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    if (user != null) {
      return await userDao.getTotalExpense(user.uid ?? "");
    }
    return null;
  }

  Future<void> signOut() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final userDao = database.userDao;
    await userDao.deleteAllUsers();
    await userDao.deleteWallet();
    await userDao.deleteTotalIncome();
    await userDao.deleteTotalExpense();
    await _authService.signOut();
    final context = router.routerDelegate.navigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.go(LoginPage.route);
    }
  }
}
