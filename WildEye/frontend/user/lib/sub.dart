import 'package:flutter/material.dart';
import './chat.dart';
import './gmap.dart';
import './logs.dart';

class HomePage extends StatefulWidget {
  final String userEmail;

  const HomePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages; // Declare _pages as late to initialize it later

  @override
  void initState() {
    super.initState();
    _pages = [
      MapScreen(),
      LogsScreen(),
      ChatScreen(userEmail: widget.userEmail), // Pass userEmail to ChatScreen
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('WildEye'),
          automaticallyImplyLeading: false, // This line hides the back button
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map_sharp),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_add_sharp),
              label: 'Logs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber),
              label: 'Report',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
