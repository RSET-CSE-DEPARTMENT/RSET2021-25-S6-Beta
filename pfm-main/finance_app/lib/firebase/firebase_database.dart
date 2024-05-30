import 'package:finance_app/firebase/firebase_auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  final _instance = FirebaseDatabase.instance;
  final _currentUser = FirebaseAuthService().currentUser;

  static getInstance() => FirebaseDatabaseService()._instance;
  final databaseRef = FirebaseDatabase.instance.ref();

  static final transactionRef =
      FirebaseDatabaseService().databaseRef.child("transactions");

  static final goalsRef =
      FirebaseDatabaseService().databaseRef.child("goals");
}
