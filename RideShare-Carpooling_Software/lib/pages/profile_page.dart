import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_share_test/components/info_list.dart';
import 'package:ride_share_test/components/review_list.dart';
import 'package:ride_share_test/pages/edit_profile_page.dart';
import 'package:ride_share_test/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? newValue = 0;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference usersCollection = db.collection("Users");
    //DocumentReference docRef = usersCollection.doc("TvuFtfwMXWRtiJxeB8Kd");
    Future<DocumentSnapshot> fetchData() async {
      // Your code to retrieve data from Firestore (using docRef.get())
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: user?.email).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first;
      } else {
        throw Exception('User with email not found');
      }

      // final docSnapshot = await docRef.get();
      // return docSnapshot;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: Colors.green[500],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50.0,
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
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

              final String name = data['name'];
              final String email = data['email'];
              final String level = data['level'];
              final String distance_travelled = data['distance_travelled'];
              final String mobile = data['mobile_number'];
              final String rides_as_passenger = data['rides_as_passenger'];
              final String rides_as_driver = data['rides_as_driver'];
              final String emergency_contact = data['emergency_contact'];
              final String age = data['age'];

              return Column(
                // You can use any parent widget you prefer
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      mobile,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 90.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(66, 210, 71, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Level",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              Text(
                                level,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white.withOpacity(0.4),
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Distance",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              Text(
                                distance_travelled,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Text('age  $age'),
                  // Text('Emergency Contact $emergency_contact'),
                  // Text('Rides as passenger $rides_as_passenger'),
                  // Text('Rides as driver $rides_as_driver'),
                  ElevatedButton(onPressed: signOut, child: Text("Sign out")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage()),
                        );
                      },
                      child: Text("Edit Profile"))
                ],
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: newValue,
            padding: EdgeInsets.all(10.0),
            children: {
              0: Padding(
                padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                child: Text('Reviews'),
              ),
              1: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Informations'),
              ),
            },
            onValueChanged: (value) {
              setState(() {
                newValue = value;
              });
            },
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: newValue == 1
                ? InfoList()
                : newValue == 0
                    ? ReviewList()
                    : SizedBox(), // Show InfoList only when index is 1
          ),
        ],
      ),
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
