import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ride_share_test/pages/driver_profile_page.dart';
import 'package:ride_share_test/pages/map_screen.dart';
import 'package:ride_share_test/services/Firestore_crud.dart';

import '../services/auth.dart';

class MyRidesPage extends StatefulWidget {
  const MyRidesPage({super.key});

  @override
  State<MyRidesPage> createState() => _MyRidesPageState();
}

class _MyRidesPageState extends State<MyRidesPage> {
  final User? user = Auth().currentUser;
  String rideDocumentRef = "";
  String userDocumentRef = '';

  List<String> passengers = [];
  bool doesRequestExist = false;
  late QueryDocumentSnapshot rideData;
  late String availableSeats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRideDocument();
  }

  // void getUserEmailAndCheckRide() async {
  //   if (user != null) {
  //     setState(() {
  //       userEmail = user!.email;
  //       print(userEmail);
  //       //  print("THISIS INSIDE EMAIL FUNCTION");
  //     });
  //     checkRideDocument();
  //   }
  // }

  Future<Widget> getSenderDocuments(
      String requestedRideId, String requestId) async {
    print(requestedRideId);
    // Reference to the Firestore collection where you want to retrieve documents
    CollectionReference ridesCollection =
        FirebaseFirestore.instance.collection('Rides');

    // // Query documents in the rides collection where the senderId field matches the provided senderId
    DocumentSnapshot querySnapshot =
        await ridesCollection.doc(requestedRideId).get();

    if (querySnapshot.exists) {
      // Get all field values as a Map
      Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;

      // Now you can access each field value using its key
      final startLocationName = data['startLocationName'];
      final destinationName = data['destinationName'];
      List<String> parts = startLocationName.split(",");
      final start = parts[0];
      // print(start);
      List<String> parts1 = destinationName.split(",");
      final destination = parts1[0];
      final date = (data['date'] as Timestamp)
          .toDate(); // Convert Firestore Timestamp to DateTime
      final formattedDate = DateFormat('MMMM d, yyyy').format(date);
      final availableSeats = data['availableSeats'];
      return ListTile(
          title: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$formattedDate',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      )),
                  TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.airline_seat_recline_normal,
                        color: Colors.green,
                      ),
                      label: Text("$availableSeats",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.black)))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("07:00 AM",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black)),
                      SizedBox(height: 45),
                      Text("08:00 AM",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Container(
                          width: 3.5,
                          height: 52,
                          color: Colors.green,
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Image.asset(
                  //   "assets/images/your_image.jpg", // Path to your image
                  // ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$startLocationName',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black)),
                          SizedBox(height: 15),
                          Text('$destinationName',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Card(
                elevation: 0,
                color: Colors.blueGrey[50],
                child: ListTile(
                  onTap: () {
                    // Handle ListTile tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DriverProfilePage()), // Replace 'John Doe' with dynamic data if needed
                    );
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/pp.jpg"),
                  ),
                  title: Text(
                    'John Kurain Lastname',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('4.8',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.black)),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      FirestoreCrud().deleteRequest(userDocumentRef, requestId);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust for desired squareness
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                    child: Text('Cancel request'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    } else {
      return Text('NULL NULL NULL');
    }

    // return Text(senderId);

    // Return a list of DocumentSnapshots
  }

  void checkRideDocument() async {
    QuerySnapshot ridesSnapshot = await FirebaseFirestore.instance
        .collection('Rides')
        .where('email', isEqualTo: user!.email)
        .get();
    if (ridesSnapshot.docs.isNotEmpty) {
      setState(() {
        rideDocumentRef = ridesSnapshot.docs[0].id;
        print(rideDocumentRef);
        print("waaaat");
      });
    }

    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user!.email)
        .get();
    QuerySnapshot userDocRef = await FirebaseFirestore.instance
        .collection("Users")
        .doc(usersSnapshot.docs.first.id)
        .collection("Requests")
        .get();
    if (userDocRef.docs.isNotEmpty) {
      setState(() {
        doesRequestExist = true;
        userDocumentRef = usersSnapshot.docs.first.id;
      });
    }
    print("AGRSGASHRARARSHHARGH");
    print(doesRequestExist);
    print("waaaat");
  }

  Future<DocumentSnapshot> fetchData() async {
    // Your code to retrieve data from Firestore (using docRef.get())
    QuerySnapshot ridesSnapshot = await FirebaseFirestore.instance
        .collection('Rides')
        .where('email', isEqualTo: user!.email)
        .get();

    if (ridesSnapshot.docs.isNotEmpty) {
      return ridesSnapshot.docs.first;
    } else {
      throw Exception('User with email not found');
    }

    // final docSnapshot = await docRef.get();
    // return docSnapshot;
  }

  Future<List<String>> fetchRiderData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userDocumentRef)
        .collection("Requests")
        .get();

    // Extract senderIds from documents
    List<String> senderIds = [];
    querySnapshot.docs.forEach((doc) {
      senderIds.add(doc['rideReference'] as String);
    });

    return senderIds;
  }

  Future<void> setSeat() async {
    final data = await FirestoreCrud().getAvailableSeats(rideDocumentRef);
    setState(() {
      availableSeats = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              'My Activity',
              style: TextStyle(fontSize: 28.0),
            ),
          ),
        ),
        body: Builder(builder: (context) {
          if (rideDocumentRef != '') {
            return SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future:
                        fetchData(), // Replace with your actual future object
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            "Error: ${snapshot.error}"); // Handle errors
                      }

                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(); // Show loading indicator
                      }

                      final DocumentSnapshot? docSnapshot = snapshot.data;
                      if (docSnapshot == null || !docSnapshot.exists) {
                        return Text('Document does not exist');
                      }

                      final data =
                          docSnapshot.data() as Map<String, dynamic>? ?? {};
                      print('Data from Firestore: $data');

                      final driver_id = docSnapshot.id;
                      final startLocationName = data['startLocationName'];
                      final destinationName = data['destinationName'];
                      List<String> parts = startLocationName.split(",");
                      final start = parts[0];
                      // print(start);
                      List<String> parts1 = destinationName.split(",");
                      final destination = parts1[0];
                      final date = (data['date'] as Timestamp)
                          .toDate(); // Convert Firestore Timestamp to DateTime
                      final formattedDate =
                          DateFormat('MMMM d, yyyy').format(date);
                      availableSeats = data['availableSeats'];
                      final startLocationGeoPoint =
                          data['startLocationGeopoint'];
                      final destinationGeopoint = data['destinationGeopoint'];

                      return ListTile(
                          onTap: () {
                            // Handle ListTile tap
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapScreenPage(
                                        startLat: startLocationGeoPoint,
                                        destLat: destinationGeopoint,
                                      )), // Replace 'John Doe' with dynamic data if needed
                            );
                          },
                          title: Card.outlined(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$formattedDate',
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          )),
                                      TextButton.icon(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.airline_seat_recline_normal,
                                            color: Colors.green,
                                          ),
                                          label: Text("$availableSeats",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Colors.black)))
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("07:00 AM",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black)),
                                          SizedBox(height: 45),
                                          Text("08:00 AM",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: Colors.black))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 3,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 3.5,
                                              height: 52,
                                              color: Colors.green,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 3,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('$startLocationName',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                              SizedBox(height: 15),
                                              Text('$destinationName',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                  Text('Passengers'),
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('Rides')
                          .doc(rideDocumentRef)
                          .collection("Requests")
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Get the document count
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return Center(
                            child:
                                CircularProgressIndicator(), // Show loading indicator
                          );
                        }
                        final documentCount =
                            (snapshot.data as QuerySnapshot).docs.length;
                        final documents = (snapshot.data as QuerySnapshot).docs;
                        final noRequestsAccepted = documents
                            .every((doc) => doc['isAccepted'] == false);

                        if (documentCount == 0 || noRequestsAccepted) {
                          // No requests found, display Text widget
                          return Center(
                            child: Text(
                              'No passenger yet.',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: documentCount,
                                itemBuilder: (context, index) {
                                  final QueryDocumentSnapshot<Object?>
                                      docSnapshot =
                                      (snapshot.data as QuerySnapshot)
                                          .docs[index];
                                  final data = docSnapshot.data()
                                      as Map<String, dynamic>;
                                  final requestDocumentRef = docSnapshot.id;

                                  final requesterName = data['senderId'];
                                  final requesterEmail = data['senderEmail'];
                                  final seatsRequested = data['seatRequested'];
                                  final isAccepted = data['isAccepted'];
                                  passengers.add(requesterEmail);
                                  if (isAccepted == true) {
                                    return Card(
                                      elevation: 0,
                                      color: Colors.blueGrey[50],
                                      child: Column(
                                        children: [
                                          ListTile(
                                              onTap: () {
                                                // Handle ListTile tap
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DriverProfilePage()), // Replace 'John Doe' with dynamic data if needed
                                                );
                                              },
                                              leading: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: AssetImage(
                                                    "assets/images/pp.jpg"),
                                              ),
                                              title: Text(
                                                '$requesterName',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.amber),
                                                  Text('4.8',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Colors.black)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Icon(
                                                        Icons
                                                            .airline_seat_recline_normal,
                                                        color: Colors.green),
                                                  ),
                                                  Text('$seatsRequested',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              trailing: ElevatedButton(
                                                onPressed: () {
                                                  FirestoreCrud()
                                                      .removeRequest(
                                                          rideDocumentRef,
                                                          requestDocumentRef,
                                                          seatsRequested)
                                                      .then(
                                                          (value) => setSeat());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 1.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0), // Adjust for desired squareness
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.red,
                                                ),
                                                child: Text('Remove'),
                                              )),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  for (final passenger in passengers) {
                                    FirestoreCrud().setCurrentRide(
                                        passenger, rideDocumentRef);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 1.5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Adjust for desired squareness
                                  ),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.green,
                                ),
                                child: Text('Confirm passengers'),
                              ),
                            )
                          ],
                        );
                      }),
                  Text("Requests:"),
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('Rides')
                          .doc(rideDocumentRef)
                          .collection("Requests")
                          .snapshots(),
                      builder: (context, snapshot) {
                        // Get the document count

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData) {
                          return Center(
                            child:
                                CircularProgressIndicator(), // Show loading indicator
                          );
                        }
                        final documentCount =
                            (snapshot.data as QuerySnapshot).docs.length;
                        final documents = (snapshot.data as QuerySnapshot).docs;
                        final allRequestsAccepted =
                            documents.every((doc) => doc['isAccepted'] == true);

                        if (documentCount == 0 || allRequestsAccepted) {
                          // No requests found, display Text widget
                          return Center(
                            child: Text(
                              'No ride requests.',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: documentCount,
                              itemBuilder: (context, index) {
                                final QueryDocumentSnapshot<Object?>
                                    docSnapshot =
                                    (snapshot.data as QuerySnapshot)
                                        .docs[index];
                                final data =
                                    docSnapshot.data() as Map<String, dynamic>;
                                final requestDocumentRef = docSnapshot.id;

                                final requesterName = data['senderId'];
                                final seatsRequested = data['seatRequested'];
                                final isAccepted = data['isAccepted'];
                                if (isAccepted == false) {
                                  return Card(
                                    elevation: 0,
                                    color: Colors.blueGrey[50],
                                    child: Column(
                                      children: [
                                        ListTile(
                                            onTap: () {
                                              // Handle ListTile tap
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DriverProfilePage()), // Replace 'John Doe' with dynamic data if needed
                                              );
                                            },
                                            leading: CircleAvatar(
                                              radius: 27,
                                              backgroundImage: AssetImage(
                                                  "assets/images/pp.jpg"),
                                            ),
                                            title: Text(
                                              '$requesterName',
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber),
                                                Text('4.8',
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.black)),
                                              ],
                                            ),
                                            trailing: TextButton.icon(
                                                onPressed: null,
                                                icon: Icon(
                                                  Icons
                                                      .airline_seat_recline_normal,
                                                  color: Colors.green,
                                                ),
                                                label: Text("$seatsRequested",
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18,
                                                        color: Colors.black)))),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    bottom: 12.0,
                                                    right: 4.0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      print('Accept clicked');
                                                      FirestoreCrud()
                                                          .acceptRequest(
                                                              rideDocumentRef,
                                                              requestDocumentRef,
                                                              seatsRequested)
                                                          .then((value) {
                                                        if (value == false) {
                                                          var snackBar =
                                                              SnackBar(
                                                                  duration:
                                                                      Durations
                                                                          .long2,
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  backgroundColor:
                                                                      Colors.red[
                                                                          400],
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50.0)),
                                                                  content: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 8.0,
                                                                              right: 12.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.error_outline,
                                                                            size:
                                                                                27.0,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                            "Not enough seats.")
                                                                      ]));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        }
                                                      }).then((value) =>
                                                              setSeat());
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 1.5,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0), // Adjust for desired squareness
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                            foregroundColor:
                                                                Colors.green,
                                                            minimumSize: Size(
                                                                double.infinity,
                                                                50)),
                                                    child: Text('Accept')),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    bottom: 12.0,
                                                    right: 4.0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      if (!isAccepted) {
                                                        print(
                                                            'Decline clicked');
                                                        FirestoreCrud()
                                                            .declineRequest(
                                                                rideDocumentRef,
                                                                requestDocumentRef);
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            elevation: 1.5,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0), // Adjust for desired squareness
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                            foregroundColor:
                                                                Colors.red,
                                                            minimumSize: Size(
                                                                double.infinity,
                                                                50)),
                                                    child: Text('Decline')),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        }
                      })
                ],
              ),
            );
          }
          if (doesRequestExist == true) {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userDocumentRef)
                    .collection("Requests")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}"); // Handle errors
                  }

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(); // Show loading indicator
                  }

                  List<String> requestIds =
                      snapshot.data!.docs.map((doc) => doc.id).toList();

                  List<String> requestRideIds = snapshot.data!.docs
                      .map((doc) => doc['rideReference'] as String)
                      .toList();

                  print(requestRideIds);

                  return ListView.builder(
                    itemCount: requestRideIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                          future: getSenderDocuments(
                              requestRideIds[index], requestIds[index]),
                          builder: (context, snapshot) {
                            return snapshot.data ?? Container();
                          });
                    },
                  );
                });
          }
          print(doesRequestExist);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image(
                    image: AssetImage('assets/images/NoRideImage.jpg'),
                    width: 200, // Optional: Set width for the image
                    height: 200, // Optional: Set height for the image
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                child: Text(
                  'Your future travel plans will appear here.',
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w700, // Adjust weight as needed
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 20.0, top: 20.0),
                child: Text(
                  'Find the perfect ride from thousands of destinations, or publish to share your ride.',
                  style: GoogleFonts.robotoMono(
                    fontSize: 17,

                    fontWeight: FontWeight.w500, // Adjust weight as needed
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          );
        }));
  }
}














// ElevatedButton(
//                                       onPressed: () {
//                                         if (!isAccepted) {
//                                           print('Accept clicked');
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         elevation: 1.5,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               5.0), // Adjust for desired squareness
//                                         ),
//                                         backgroundColor: Colors.white,
//                                         foregroundColor: Colors.green,
//                                       ),
//                                       child: isAccepted
//                                           ? Text('Accepted')
//                                           : Text("Accept"),
//                                     ),