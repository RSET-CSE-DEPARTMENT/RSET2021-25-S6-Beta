import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<List<double>> l1 = [];
  @override
  void initState() {
    super.initState();
    pr();
  }

  void pr() async {
    await Firebase.initializeApp();
    FirebaseFirestore f2 = FirebaseFirestore.instance;
    QuerySnapshot q2 = await f2.collection('camera').get();
    q2.docs.forEach((doc) {
      double a = doc['lattitude'];
      double b = doc['longitude'];
      double c1 = doc['sightings'];
      List<double> l2 = [a, b, c1];
      setState(() {
        l1.add(l2);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map Example'),
        ),
        body: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(10.5937, 75.9629),
            initialZoom: 10.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: List.generate(
                l1.length,
                (index) => _writelist(index),
              ),
            )
          ],
        ));
  }

  Marker _writelist(int index) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(l1[index][0], l1[index][1]),
      child: IconButton(
          icon: Icon(Icons.pin_drop_sharp),
          onPressed: () {
            call4(index);
          }),
    );
  }

  void call4(index) {
    print(index);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sightings Count '),
          content: Text('Count: ${l1[index][2]}'),
          actions: <Widget>[
            TextButton(
              child: Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
