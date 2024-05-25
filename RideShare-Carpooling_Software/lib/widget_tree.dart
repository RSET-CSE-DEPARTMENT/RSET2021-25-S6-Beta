// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:ride_share_test/main.dart';
// import 'package:ride_share_test/pages/home.dart';
// import 'package:ride_share_test/pages/login_page_test.dart';
// import 'package:ride_share_test/services/auth.dart';

// class WidgetTree extends StatefulWidget {
//   WidgetTree({Key? key}) : super(key: key);

//   @override
//   _WidgetTreeState createState() => _WidgetTreeState();
// }

// class _WidgetTreeState extends State<WidgetTree> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Auth().authStateChanges,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return HomePage();
//           } else {
//             return LoginPage();
//           }
//         });
//   }
// }
