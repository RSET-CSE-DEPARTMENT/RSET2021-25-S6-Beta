// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("WildEye"),
          backgroundColor: Colors.teal[100],
        ),
        body: Row(
            children: [
               Expanded(
                 child: Container( // 1/4th of width
                 color: Colors.teal[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                           onTap :(){
                              Navigator.pushNamed(context, '/broadcast');
                           },
                          child: Container(
                           decoration: BoxDecoration(
                            borderRadius :BorderRadius.circular(40),
                            color: Colors.teal[700],
                          ),
                          width: 350,
                          height: 80,
                          child: Center(
                            child: Text(
                              "Map"
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/broadcast');
                        },
                        child: Container(
                           decoration: BoxDecoration(
                            borderRadius :BorderRadius.circular(40),
                            color: Colors.teal[700],
                          ),
                          width: 300,
                          height: 70,
                          child: Text("Broadcast"),
                        ),
                      ),
                      Container(
                         decoration: BoxDecoration(
                          borderRadius :BorderRadius.circular(40),
                          color: Colors.teal[700],
                        ),
                        width: 300,
                        height: 70,
                      ),
                      Container(
                         decoration: BoxDecoration(
                          borderRadius :BorderRadius.circular(40),
                          color: Colors.teal[700],
                        ),
                        width: 300,
                        height: 70,
                      ),
                      Container(
                         decoration: BoxDecoration(
                          borderRadius :BorderRadius.circular(40),
                          color: Colors.teal[700],
                        ),
                        width: 300,
                        height: 70,
                      )
                    ]
                  ),
                             ),
               ),
               Expanded(
                flex: 2,
                child: Container(
                  color: Colors.teal[100],
                  child: MapScreen(),
                )
              )
            ],
          ),
        )
      );
      
  }
  
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapController = MapController(); // Create a MapController instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          // Set initial center to a central location in India (adjust as needed)
          center: LatLng(11, 76.2),
          // Set initial zoom level to show a good portion of India
          zoom: 12.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}
