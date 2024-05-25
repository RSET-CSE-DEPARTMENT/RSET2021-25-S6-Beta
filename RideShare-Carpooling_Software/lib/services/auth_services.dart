class AuthService {
  //Google Sign in
  // signInWithGoogle() async {
  //   // begin interactive sign in process
  //   final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  //   // obtain details from request
  //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  //   // create a new credential for user
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: gAuth.accessToken,
  //     idToken: gAuth.idToken,
  //   );

  //   // finally, lets sign in

  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}
