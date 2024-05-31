import 'package:flutter/material.dart';

class DriverProfilePage extends StatefulWidget {
  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stateful Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Driver Profile will be visible here',
            ),
          ],
        ),
      ),
    );
  }
}
