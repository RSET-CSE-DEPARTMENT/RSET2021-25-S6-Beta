import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SightingsPage extends StatefulWidget {
  const SightingsPage({super.key});

  @override
  _SightingsPageState createState() => _SightingsPageState();
}

class _SightingsPageState extends State<SightingsPage> {
  TextEditingController _cameraIdController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _sightingsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sightings Logger'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cameraIdController,
              decoration: InputDecoration(
                labelText: 'Camera ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _latitudeController,
              decoration: InputDecoration(
                labelText: 'Latitude',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _longitudeController,
              decoration: InputDecoration(
                labelText: 'Longitude',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _placeController,
              decoration: InputDecoration(
                labelText: 'Place',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _sightingsController,
              decoration: InputDecoration(
                labelText: 'Number of Sightings',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                done();
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraIdController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _placeController.dispose();
    _sightingsController.dispose();
    super.dispose();
  }

  void done() async {
    int cid = int.tryParse(_cameraIdController.text) ?? 0;
    int cll = int.tryParse(_latitudeController.text) ?? 0;
    int clo = int.tryParse(_longitudeController.text) ?? 0;
    int cnon = int.tryParse(_sightingsController.text) ?? 0;
    String pl = _placeController.text;

    // Initialize Firebase
    await Firebase.initializeApp();
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add data to Firestore
    try {
      await firestore.collection('camera').add({
        'cameraid': cid,
        'lattitude': cll,
        'longitude': clo,
        'place': pl,
        'sightings': cnon,
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('SUCCESS'),
              content: Text('success'),
              actions: <Widget>[
                TextButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } catch (e) {
      print('Error adding data to Firestore: $e');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('failed'),
              content: Text('Failed to insert camera'),
              actions: <Widget>[
                TextButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
