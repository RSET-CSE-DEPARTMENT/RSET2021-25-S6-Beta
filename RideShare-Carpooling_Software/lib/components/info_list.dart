import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_share_test/services/auth.dart';

class InfoList extends StatefulWidget {
  const InfoList({super.key});

  @override
  State<InfoList> createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference usersCollection = db.collection("Users");
    Future<DocumentSnapshot> fetchData() async {
      // Your code to retrieve data from Firestore (using docRef.get())
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: user!.email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User with email not found');
      }

      // final docSnapshot = await docRef.get();
      // return docSnapshot;
    }

    return FutureBuilder(
      future: fetchData(), // Replace with your actual future object
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}"); // Handle errors
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Show loading indicator
        }

        final DocumentSnapshot? docSnapshot = snapshot.data;
        if (docSnapshot == null || !docSnapshot.exists) {
          return Text('Document does not exist');
        }

        final data = docSnapshot.data() as Map<String, dynamic>? ?? {};
        print('Data from Firestore: $data');

        final age = data['age'];
        final emcontact = data['emergency_contact'];
        final String rides_as_passenger = data['rides_as_passenger'];
        final String rides_as_driver = data['rides_as_driver'];

        return Column(
          // You can use any parent widget you prefer
          children: [
            itemprofile('emergency contact', emcontact, CupertinoIcons.person),
            SizedBox(height: 10),
            itemprofile('Age', age, CupertinoIcons.mail),
            SizedBox(height: 10),
            itemprofile('Ride as passenger', rides_as_passenger,
                CupertinoIcons.location),
            SizedBox(height: 10),
            itemprofile(
                'Ride as Driver', rides_as_driver, CupertinoIcons.location),
          ],
        );
      },
    );
  }

  itemprofile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.grey,
      ),
    );
  }
}
