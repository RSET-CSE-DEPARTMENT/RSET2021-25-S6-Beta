// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ride_share_test/services/auth.dart';

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text("Profle");
//   }

//   Widget _userId() {
//     return Text(user?.email ?? "User email");
//   }

//   Widget _signOutButton() {
//     return ElevatedButton(
//       onPressed: signOut,
//       child: const Text("Sign out"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _userId(),
//             _signOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_test/Defaults/default_values.dart';
import 'package:ride_share_test/pages/my_rides.dart';
import 'package:ride_share_test/pages/profile_page.dart';
import 'package:ride_share_test/pages/publish_page.dart';
import 'package:ride_share_test/pages/search_page.dart';
import 'package:ride_share_test/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  void navigateToPage(BuildContext context, int pageIndex) {
    _HomePageState? state = context.findAncestorStateOfType<_HomePageState>();
    state?.navigateToPage(pageIndex);
  }
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  var _indexClicked = 2;

  final pages = [
    SearchPage(),
    PublishPage(),
    MyRidesPage(),
    Center(child: Text('Chat')),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_indexClicked],
      backgroundColor: Colors.green[50],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.green[500],
        type: BottomNavigationBarType
            .shifting, //Can also be BottomNavigationBarType.fixed
        elevation: 60,
        selectedItemColor: DefaultValues.bottomNavItemSelectedColor,
        unselectedItemColor: DefaultValues.bottomNavItemColor,
        currentIndex: _indexClicked,
        selectedFontSize: DefaultValues.bottomNavTextSelectedSize,
        unselectedFontSize: DefaultValues.bottomNavTextSize,
        selectedIconTheme: const IconThemeData(
          size: DefaultValues.bottomNavIconSelectedsize,
        ),
        unselectedIconTheme: const IconThemeData(
          size: DefaultValues.bottomNavIconSize,
        ),
        showUnselectedLabels: DefaultValues.bottomNavShowUnselectedLabel,
        onTap: (value) {
          setState(() {
            _indexClicked = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: DefaultValues.bottomNavColor,
            icon: Icon(
              DefaultValues.bottomNavItemIcon[0],
            ),
            label: DefaultValues.bottomNavItemText[0],
          ),
          BottomNavigationBarItem(
            backgroundColor: DefaultValues.bottomNavColor,
            icon: Icon(
              DefaultValues.bottomNavItemIcon[1],
            ),
            label: DefaultValues.bottomNavItemText[1],
          ),
          BottomNavigationBarItem(
            backgroundColor: DefaultValues.bottomNavColor,
            icon: Icon(
              DefaultValues.bottomNavItemIcon[2],
            ),
            label: DefaultValues.bottomNavItemText[2],
          ),
          BottomNavigationBarItem(
            backgroundColor: DefaultValues.bottomNavColor,
            icon: Icon(
              DefaultValues.bottomNavItemIcon[3],
            ),
            label: DefaultValues.bottomNavItemText[3],
          ),
          BottomNavigationBarItem(
            backgroundColor: DefaultValues.bottomNavColor,
            icon: Icon(
              DefaultValues.bottomNavItemIcon[4],
            ),
            label: DefaultValues.bottomNavItemText[4],
          ),
        ],
      ),
    );
  }

  void navigateToPage(int pageIndex) {
    setState(() {
      _indexClicked = pageIndex;
    });
  }
}
