// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 4,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserModel` (`uid` TEXT, `email` TEXT, `name` TEXT, `phone` TEXT, `photo` TEXT, `cashInWallet` REAL, `totalIncome` REAL, `totalExpense` REAL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `IncomeExpenseModel` (`id` INTEGER, `userId` TEXT, `title` TEXT, `description` TEXT, `amount` REAL, `date` TEXT, `time` TEXT, `category` TEXT, `type` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `WalletModel` (`uid` TEXT, `amount` REAL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TotalExpenseModel` (`uid` TEXT, `amount` REAL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TotalIncomeModel` (`uid` TEXT, `amount` REAL, PRIMARY KEY (`uid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'UserModel',
            (UserModel item) => <String, Object?>{
                  'uid': item.uid,
                  'email': item.email,
                  'name': item.name,
                  'phone': item.phone,
                  'photo': item.photo,
                  'cashInWallet': item.cashInWallet,
                  'totalIncome': item.totalIncome,
                  'totalExpense': item.totalExpense
                }),
        _walletModelInsertionAdapter = InsertionAdapter(
            database,
            'WalletModel',
            (WalletModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount}),
        _totalIncomeModelInsertionAdapter = InsertionAdapter(
            database,
            'TotalIncomeModel',
            (TotalIncomeModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount}),
        _totalExpenseModelInsertionAdapter = InsertionAdapter(
            database,
            'TotalExpenseModel',
            (TotalExpenseModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount}),
        _walletModelUpdateAdapter = UpdateAdapter(
            database,
            'WalletModel',
            ['uid'],
            (WalletModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount}),
        _totalIncomeModelUpdateAdapter = UpdateAdapter(
            database,
            'TotalIncomeModel',
            ['uid'],
            (TotalIncomeModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount}),
        _totalExpenseModelUpdateAdapter = UpdateAdapter(
            database,
            'TotalExpenseModel',
            ['uid'],
            (TotalExpenseModel item) =>
                <String, Object?>{'uid': item.uid, 'amount': item.amount});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final InsertionAdapter<WalletModel> _walletModelInsertionAdapter;

  final InsertionAdapter<TotalIncomeModel> _totalIncomeModelInsertionAdapter;

  final InsertionAdapter<TotalExpenseModel> _totalExpenseModelInsertionAdapter;

  final UpdateAdapter<WalletModel> _walletModelUpdateAdapter;

  final UpdateAdapter<TotalIncomeModel> _totalIncomeModelUpdateAdapter;

  final UpdateAdapter<TotalExpenseModel> _totalExpenseModelUpdateAdapter;

  @override
  Future<UserModel?> getUser() async {
    return _queryAdapter.query('SELECT * FROM UserModel LIMIT 1',
        mapper: (Map<String, Object?> row) => UserModel(
            uid: row['uid'] as String?,
            email: row['email'] as String?,
            name: row['name'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as String?,
            cashInWallet: row['cashInWallet'] as double?,
            totalIncome: row['totalIncome'] as double?,
            totalExpense: row['totalExpense'] as double?));
  }

  @override
  Future<UserModel?> deleteAllUsers() async {
    return _queryAdapter.query('DELETE FROM UserModel',
        mapper: (Map<String, Object?> row) => UserModel(
            uid: row['uid'] as String?,
            email: row['email'] as String?,
            name: row['name'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as String?,
            cashInWallet: row['cashInWallet'] as double?,
            totalIncome: row['totalIncome'] as double?,
            totalExpense: row['totalExpense'] as double?));
  }

  @override
  Future<double?> getCashInWallet(String userId) async {
    return _queryAdapter.query(
        'SELECT amount FROM WalletModel WHERE uid= ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [userId]);
  }

  @override
  Future<UserModel?> deleteWallet() async {
    return _queryAdapter.query('DELETE * FROM WalletModel',
        mapper: (Map<String, Object?> row) => UserModel(
            uid: row['uid'] as String?,
            email: row['email'] as String?,
            name: row['name'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as String?,
            cashInWallet: row['cashInWallet'] as double?,
            totalIncome: row['totalIncome'] as double?,
            totalExpense: row['totalExpense'] as double?));
  }

  @override
  Future<double?> getTotalIncome(String userId) async {
    return _queryAdapter.query(
        'SELECT amount FROM TotalIncomeModel WHERE uid= ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [userId]);
  }

  @override
  Future<UserModel?> deleteTotalIncome() async {
    return _queryAdapter.query('DELETE * FROM TotalIncomeModel',
        mapper: (Map<String, Object?> row) => UserModel(
            uid: row['uid'] as String?,
            email: row['email'] as String?,
            name: row['name'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as String?,
            cashInWallet: row['cashInWallet'] as double?,
            totalIncome: row['totalIncome'] as double?,
            totalExpense: row['totalExpense'] as double?));
  }

  @override
  Future<double?> getTotalExpense(String userId) async {
    return _queryAdapter.query(
        'SELECT amount FROM TotalExpenseModel WHERE uid= ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [userId]);
  }

  @override
  Future<UserModel?> deleteTotalExpense() async {
    return _queryAdapter.query('DELETE * FROM TotalExpenseModel',
        mapper: (Map<String, Object?> row) => UserModel(
            uid: row['uid'] as String?,
            email: row['email'] as String?,
            name: row['name'] as String?,
            phone: row['phone'] as String?,
            photo: row['photo'] as String?,
            cashInWallet: row['cashInWallet'] as double?,
            totalIncome: row['totalIncome'] as double?,
            totalExpense: row['totalExpense'] as double?));
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> addCashToWallet(WalletModel model) async {
    await _walletModelInsertionAdapter.insert(model, OnConflictStrategy.abort);
  }

  @override
  Future<void> addTotalIncome(TotalIncomeModel model) async {
    await _totalIncomeModelInsertionAdapter.insert(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> addTotalExpense(TotalExpenseModel model) async {
    await _totalExpenseModelInsertionAdapter.insert(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCashInWallet(WalletModel model) async {
    await _walletModelUpdateAdapter.update(model, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTotalIncome(TotalIncomeModel model) async {
    await _totalIncomeModelUpdateAdapter.update(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTotalExpense(TotalExpenseModel model) async {
    await _totalExpenseModelUpdateAdapter.update(
        model, OnConflictStrategy.abort);
  }
}
