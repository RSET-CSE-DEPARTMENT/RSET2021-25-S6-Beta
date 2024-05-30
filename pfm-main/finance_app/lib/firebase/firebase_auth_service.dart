import 'package:finance_app/base/scaffold_key.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    AppScaffoldManager.getAppScaffoldManager().showLoader();
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      AppScaffoldManager.getAppScaffoldManager()
          .showSnackBar(e.message ?? "Something Went Wrong. Please Try Again");
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    AppScaffoldManager.getAppScaffoldManager().showLoader();
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredentials.user != null) {
        final user = await updateUserData(name: name);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      AppScaffoldManager.getAppScaffoldManager()
          .showSnackBar(e.message ?? "Something Went Wrong. Please Try Again");
    }
    return null;
  }

  Future<User?> updateUserData({
    required String name,
  }) async {
    try {
      await currentUser?.updateDisplayName(name);
      return currentUser;
    } on FirebaseAuthException catch (e) {
      AppScaffoldManager.getAppScaffoldManager().hideLoader();
      AppScaffoldManager.getAppScaffoldManager()
          .showSnackBar(e.message ?? "Something Went Wrong. Please Try Again");
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
