import 'package:finance_app/view/dashboard/page/dashboard_page.dart';
import 'package:finance_app/view/goals/pages/goals_page.dart';
import 'package:finance_app/view/profile/page/profile_page.dart';
import 'package:finance_app/view/transaction/page/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const String route = "/homePageRoute";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final pages = [
    const DashboardPage(),
    const TransactionPage(),
    const GoalsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/goal.svg",
              height: 25,
              width: 25,
              colorFilter: ColorFilter.mode(
                  _currentIndex == 2 ? Colors.blue : Colors.grey,
                  BlendMode.srcIn),
            ),
            label: "My Goals",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_rounded),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
