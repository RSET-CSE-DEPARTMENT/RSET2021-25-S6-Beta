import 'package:finance_app/data/model/user/user_model.dart';
import 'package:finance_app/database/user_database.dart';

class SplashController {
  Future<UserModel?> getUser() async {
    final database =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    final userDao = database.userDao;
    return await userDao.getUser();
  }

  Future<double?> getAmount() async {
    final database =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    final userDao = database.userDao;
    final user = await userDao.getUser();
    if (user != null) {
      return await userDao.getCashInWallet(user.uid ?? "");
    }
    return null;
  }
}
