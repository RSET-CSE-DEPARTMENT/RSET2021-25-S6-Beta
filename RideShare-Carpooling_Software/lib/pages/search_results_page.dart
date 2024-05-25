import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:ride_share_test/pages/driver_profile_page.dart';
import 'package:ride_share_test/services/auth.dart';
import 'package:ride_share_test/services/Firestore_crud.dart';

class SearchResultsPage extends StatefulWidget {
  final String startLocation;
  final double startLat;
  final double startLong;
  final double destLat;
  final double destLong;
  final String destination;
  final DateTime date;
  final int passengers;

  const SearchResultsPage(
      {Key? key,
      required this.startLocation,
      required this.startLat,
      required this.startLong,
      required this.destLat,
      required this.destLong,
      required this.destination,
      required this.date,
      required this.passengers})
      : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final geo = GeoFlutterFire();
  final _firestore = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;

  List<DocumentSnapshot> _nearbyPlaces = [];

  int docLength = 0;
  String sl = "";
  String dl = "";
  DateTime d = DateTime.now();
  bool click = true;
  @override
  void initState() {
    super.initState();
    sl = widget.startLocation;
    dl = widget.destination;
    d = widget.date;
    //_getNearbyPlaces();
  }

  // Future<void> _getNearbyPlaces() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double latitude = position.latitude;
  //   double longitude = position.longitude;

  //   print('LatitudeHAHAHAHAHAHAHAHAHAHHA: $latitude'); // Log latitude
  //   print('Longitude: $longitude'); // Log longitude

  //   print("\nTest 1");
  //   print(widget.startLat);
  //   print(widget.startLong);

  //   GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);

  //   var collectionReference = _firestore.collection('Rides');

  //   QuerySnapshot querySnapshot = await _firestore
  //       .collection("Rides")
  //       .where('availableSeats', isEqualTo: '1')
  //       .get();

  //   print(
  //       'HAHAHAHAHAHAHAAHAHAHAHAAHAHAHAHAHAHAHAHAHAHAHAHAHAHHAHAHAH ${querySnapshot.docs.first.id}');

  //   Stream<List<DocumentSnapshot>> stream =
  //       geo.collection(collectionRef: collectionReference).within(
  //             center: center,
  //             radius: 5000,
  //             field: 'startLocationGeopoint',
  //           );

  //   stream.listen((List<DocumentSnapshot> documents) {
  //     print(
  //         'HAHAHAHAHAHHAHAHAHAHHAHAHAHAHHAHAHAHAHAHAHHAHAHAHAHAHHAHAHAHAHAHAHHAHAHAHAHAHAHHAHAHAHAHHAHAHAHHAHAHAHAHAHAHHAHAHAReceived documents: ${documents.length} documents');
  //     setState(() {
  //       _nearbyPlaces = documents;
  //     });
  //   });
  // to be cheched HERE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'kakkanad-vytilla',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Text(
              "May 2024",
              style: TextStyle(fontSize: 14.0),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Expanded(
          child: StreamBuilder<Object>(
              stream:
                  FirebaseFirestore.instance.collection('Rides').snapshots(),
              builder: (context, snapshot) {
                final documentCount = (snapshot.data as QuerySnapshot)
                    .docs
                    .length; // Get the document count
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documentCount,
                    itemBuilder: (context, index) {
                      final QueryDocumentSnapshot<Object?> docSnapshot =
                          (snapshot.data as QuerySnapshot).docs[index];
                      final data = docSnapshot.data() as Map<String, dynamic>;
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
                      final availableSeats = data['availableSeats'];
                      final startLocationGeoPoint =
                          data['startLocationGeopoint'];
                      final startLocationLatLng =
                          geoPointToLatLng(startLocationGeoPoint);
                      final destinationGeopoint = data['destinationGeopoint'];
                      final destLocationLatLng =
                          geoPointToLatLng(destinationGeopoint);
                      final driveremail = data['email'];
                      final name = getDriverName(driveremail);

                      print("search results");
                      print(widget.startLat);
                      // print(widget.startLocation);
                      //LatLong(widget.startLat, widget.startLong);
                      if (isWithin5Km(
                                  LatLong(widget.startLat, widget.startLong),
                                  startLocationLatLng) &&
                              isWithin5Km(
                                  LatLong(widget.destLat, widget.destLong),
                                  destLocationLatLng)
                          //(DateTime(2024, 5, 14).compareTo(date) <= 0))
                          ) {
                        return ListTile(
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
                                    // Image.asset(
                                    //   "assets/images/your_image.jpg", // Path to your image
                                    // ),
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
                                      backgroundImage:
                                          AssetImage("assets/images/pp.jpg"),
                                    ),
                                    title: Text(
                                      '$name',
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
                                        Text('4.7',
                                            style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    trailing: ElevatedButton(
                                      onPressed: () {
                                        print(
                                            "USER EMAIL USER EMAIL USER EMAIL USER EMAIL USER EMAIL USER EMAIL USER EMAIL");
                                        print(user!.email);
                                        FirestoreCrud().addRequest(
                                            user!.email,
                                            driver_id,
                                            widget.passengers.toString());

                                        // Handle button press action
                                        print('Request sent');
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
                                      child: Text('Request'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      } else {
                        // print("didnt satisfy");
                        // print(widget.startlat);
                        return SizedBox();
                      }
                    });
              }),
        ),
      ),
    );
  }

  Future<int> getDocumentCount() async {
    // Reference to your Firestore collection
    CollectionReference ridesCollection =
        FirebaseFirestore.instance.collection('Rides');

    // Get the documents in the collection
    QuerySnapshot querySnapshot = await ridesCollection.get();

    // Return the number of documents
    return querySnapshot.docs.length;
  }

  LatLong geoPointToLatLng(GeoPoint geoPoint) {
    return LatLong(geoPoint.latitude, geoPoint.longitude);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    final double distance = 12742 * asin(sqrt(a));
    print("HAHAHA distance AHHAHA");
    print(distance);
    return (distance);
  }

// Function to filter rides within 5 km
  bool isWithin5Km(LatLong startlat, LatLong startLocationGeoPoint) {
    final double distance = calculateDistance(
        startlat.latitude,
        startlat.longitude,
        startLocationGeoPoint.latitude,
        startLocationGeoPoint.longitude);
    if (distance <= 5.0) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getDriverName(String driveremail) async {
    final _firestore = FirebaseFirestore.instance;

    final nameref = await _firestore
        .collection("Users")
        .where('email', isEqualTo: driveremail)
        .get();
    if (nameref.docs.isEmpty) {
      return ""; // Handle case where no user found
    }

    // Assuming there's only one document with the email (modify if needed)
    final doc = nameref.docs.first;
    final name = doc.get('name');
    // Get a reference to the request subcollection
    return name;
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';

// class NearbyPlacesScreen extends StatefulWidget {
//   @override
//   _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
// }

// class _NearbyPlacesScreenState extends State<NearbyPlacesScreen> {
//   final geo = GeoFlutterFire();
//   final _firestore = FirebaseFirestore.instance;
//   List<DocumentSnapshot> _nearbyPlaces = [];

//   @override
//   void initState() {
//     super.initState();
//     _getNearbyPlaces();
//   }

//   Future<void> _getNearbyPlaces() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     double latitude = position.latitude;
//     double longitude = position.longitude;

//     GeoFirePoint center = geo.point(latitude: latitude, longitude: longitude);
//     var collectionReference = _firestore.collection('rides');
//     Stream<List<DocumentSnapshot>> stream =
//         geo.collection(collectionRef: collectionReference).within(
//               center: center,
//               radius: 50,
//               field:
//                   'location', // This should be the field where GeoPoint is stored
//             );

//     stream.listen((List<DocumentSnapshot> documents) {
//       setState(() {
//         _nearbyPlaces = documents;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Nearby Places'),
//         ),
//         body: ListView.builder(
//           itemCount: _nearbyPlaces.length,
//           itemBuilder: (context, index) {
//             var place =
//                 _nearbyPlaces[index].data() as Map<String, dynamic>? ?? {};
//             String start = place['startLocationName'];
//             String end = place['destinationName'];
//             String time = place['time'];
//             String timeFormatted =
//                 time.split(' ')[4].substring(0, 5) + time.split(' ')[5];
//             String email = place['email'];
//             return Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '$start → $end',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           '$timeFormatted',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 4.0),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Text(time),
//                     //     Text(duration),
//                     //   ],
//                     // ),
//                     const Divider(thickness: 1.0),
//                     Row(
//                       children: [
//                         const Icon(Icons.person, size: 16.0),
//                         Text(email),
//                         const Spacer(),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               size: 16.0,
//                               color: Colors.yellow[600],
//                             ),
//                             Text('4.0'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//             // return ListTile(
//             //   title: Text(place['name']),

//             //   subtitle: Text(place['description']),
//             //   // You can add more details or customize the UI as needed
//             // );
//           },
//           // itemBuilder: (context, index) {
//           //   var placeData = _nearbyPlaces[index].data();
//           //   if (placeData != null) {
//           //     var place = placeData!;
//           //     return ListTile(
//           //       title: Text(place['name'] ?? ''),
//           //       subtitle: Text(place['description'] ?? ''),
//           //       // You can add more details or customize the UI as needed
//           //     );
//           //   } else {
//           //     // Handle the case when place data is null, such as showing a loading indicator or placeholder
//           //     return CircularProgressIndicator(); // Example of showing a loading indicator
//           //   }
//           // }),
//         ));
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: NearbyPlacesScreen(),
//   ));
// }
