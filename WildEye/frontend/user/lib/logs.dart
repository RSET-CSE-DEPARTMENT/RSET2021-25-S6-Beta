//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final List<List<String>> l1 = [];

  @override
  void initState() {
    super.initState();
    abc();
  }

  void abc() async {
    try {
      await Firebase.initializeApp();
      FirebaseFirestore obj4 = FirebaseFirestore.instance;
      QuerySnapshot cameraQuery = await obj4.collection('camera').get();
      Map<int, String> cameraMap = {};
      cameraQuery.docs.forEach((doc) {
        cameraMap[doc['cameraid']] = doc['place'];
      });
      QuerySnapshot query1 = await obj4.collection('Logs').get();
      query1.docs.forEach((doc) {
        String timestampString = doc['Timestamp'] as String;
        DateTime dateTime = DateTime.parse(timestampString);
        int id = doc['Camera ID'];
        String date = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
        String time = '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
        String url = doc['url'];
        //int idd1 = int.parse(id);
        String place = cameraMap[id] ?? 'Unknown';
        print("hi");
        //print(place);
        List<String> l2 = [place, date, time, url];
        setState(() {
          l1.add(l2);
        });
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  _writelist(int index) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F4F2B), // Dark Forest Green
            Color.fromARGB(255, 75, 177, 97)
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30.0,
            left: 18.0,
            child: Text(
              l1[index][1] + '\n' + l1[index][2],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                letterSpacing: 4.0,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 20.0,
            child: Text(
              l1[index][0],
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.0,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: ElevatedButton(
              onPressed: () {
                print(
                  l1[index][3],
                );
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Container(
                      width: 1200,
                      height: 1400,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            l1[index][3],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Text('View Image'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log History'),
        automaticallyImplyLeading: false, // This line hides the back button
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: l1.length,
              itemBuilder: (context, int index) => _writelist(index),
            ),
          ),
        ],
      ),
    );
  }
}
