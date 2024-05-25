import 'package:flutter/material.dart';

class DefaultValues {
  static const Color bottomNavItemColor = Colors.white;
  static const Color bottomNavItemSelectedColor = Colors.white;
  static const Color bottomNavColor = Color.fromARGB(255, 76, 175, 80);
  static const double bottomNavTextSize = 12.0;
  static const double bottomNavTextSelectedSize = 14.0;
  static const double bottomNavIconSize = 27;
  static const double bottomNavIconSelectedsize = 35;
  static const bool bottomNavShowUnselectedLabel = false;

  static final bottomNavItemText = [
    'Search',
    'Publish',
    'My Rides',
    'Chat',
    'Profile',
  ];

  static final bottomNavItemIcon = [
    Icons.search_outlined,
    Icons.add_circle_outline,
    Icons.library_books,
    Icons.chat,
    Icons.account_circle,
  ];
}
