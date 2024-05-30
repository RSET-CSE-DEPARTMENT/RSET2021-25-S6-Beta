import 'package:finance_app/data/model/transaction/income_expense_model.dart';
import 'package:finance_app/data/model/user/user_model.dart';
import 'package:finance_app/data/model/wallet/total_expense_model.dart';
import 'package:finance_app/data/model/wallet/total_income_model.dart';
import 'package:finance_app/data/model/wallet/wallet_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(UserModel user);

  @Query("SELECT * FROM UserModel LIMIT 1")
  Future<UserModel?> getUser();

  @Query('DELETE FROM UserModel')
  Future<UserModel?> deleteAllUsers();

  @insert
  Future<void> addCashToWallet(WalletModel model);

  @update
  Future<void> updateCashInWallet(WalletModel model);

  @Query("SELECT amount FROM WalletModel WHERE uid= :userId LIMIT 1")
  Future<double?> getCashInWallet(String userId);

  @Query('DELETE * FROM WalletModel')
  Future<UserModel?> deleteWallet();

  @insert
  Future<void> addTotalIncome(TotalIncomeModel model);

  @update
  Future<void> updateTotalIncome(TotalIncomeModel model);

  @Query("SELECT amount FROM TotalIncomeModel WHERE uid= :userId LIMIT 1")
  Future<double?> getTotalIncome(String userId);

  @Query('DELETE * FROM TotalIncomeModel')
  Future<UserModel?> deleteTotalIncome();

  @insert
  Future<void> addTotalExpense(TotalExpenseModel model);

  @update
  Future<void> updateTotalExpense(TotalExpenseModel model);

  @Query("SELECT amount FROM TotalExpenseModel WHERE uid= :userId LIMIT 1")
  Future<double?> getTotalExpense(String userId);

  @Query('DELETE * FROM TotalExpenseModel')
  Future<UserModel?> deleteTotalExpense();
}
