// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ride_share_test/components/signin_button.dart';
// import 'package:ride_share_test/components/signin_textfield.dart';
// import 'package:ride_share_test/components/google_signin_tile.dart';
// import 'package:ride_share_test/services/auth.dart';
// import 'package:ride_share_test/services/auth_services.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

// // text editing controllers
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         //resizeToAvoidBottomInset: false, in case you dont want the screen to scroll while typing
//         backgroundColor: Colors.grey[300],
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //logo
//                   const Image(
//                       image: AssetImage('lib/Images/appIcon.png'),
//                       width: 150.0,
//                       height: 150.0),

//                   SizedBox(height: 25.0),

//                   // welcome back, you've been missed
//                   Text(
//                     'Welcome back you\'ve been missed!',
//                     style: TextStyle(color: Colors.grey[700], fontSize: 16),
//                   ),

//                   SizedBox(height: 25.0),

//                   // username textfield
//                   SigninTextfield(
//                     controller: _emailController,
//                     hintText: 'Username',
//                     obscureText: false,
//                   ),

//                   const SizedBox(height: 10),

//                   // password textfield
//                   SigninTextfield(
//                     controller: _passwordController,
//                     hintText: 'Password',
//                     obscureText: true,
//                   ),

//                   const SizedBox(height: 10),

//                   // forgot password
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: const [
//                         Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                               color: Colors.blue, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   //sign in button
//                   SigninButton(onTap: signUserIn),

//                   const SizedBox(height: 40),

//                   // or continue with
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Divider(
//                             thickness: 0.5,
//                             color: Colors.grey[400],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: Text(
//                             'Or continue with',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ),
//                         Expanded(
//                           child: Divider(
//                             thickness: 0.5,
//                             color: Colors.grey[400],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 25,
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // google button
//                       GoogleSigninTile(
//                           onTap: () => AuthService().signInWithGoogle(),
//                           imagePath: 'lib/Images/google.png'),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),

//                   // not a member, register now
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Not a member?  ',
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 4,
//                       ),
//                       const Text(
//                         'Register now',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   signUserIn() {}
// }
