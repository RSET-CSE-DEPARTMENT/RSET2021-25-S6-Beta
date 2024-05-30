import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/data/model/user/user_model.dart';
import 'package:finance_app/data/model/wallet/total_expense_model.dart';
import 'package:finance_app/data/model/wallet/total_income_model.dart';
import 'package:finance_app/data/model/wallet/wallet_model.dart';
import 'package:finance_app/database/user_dao.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'user_database.g.dart';

@Database(version: 4, entities: [
  UserModel,
  IncomeExpenseModel,
  WalletModel,
  TotalExpenseModel,
  TotalIncomeModel,
])
abstract class AppDatabase extends FloorDatabase {
  static AppDatabase? _instance;

  UserDao get userDao;

  Future<AppDatabase> getInstance() async {
    _instance ??=
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return _instance!;
  }

  List<Migration> migrations = [];
}
