import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ride_share_test/pages/home.dart';
import 'package:ride_share_test/pages/start_location_select_page.dart';
import 'package:ride_share_test/pages/destination_select_page.dart';
import 'package:ride_share_test/services/Firestore_crud.dart';
import 'package:ride_share_test/services/auth.dart';

class PublishPage extends StatefulWidget {
  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  late TextEditingController _startLocationController;
  late TextEditingController _destinationController;
  late TextEditingController _dateController;
  String _startLocationName = "";
  String _destinationName = "";
  double _startLocationLat = 0.0;
  double _destinationLat = 0.0;
  double _startLocationLong = 0.0;
  double _destinationLong = 0.0;
  DateTime? _date = DateTime.now();
  int _passengers = 1;
  late bool hasPublished;

  final User? user = Auth().currentUser;

  Future<void> checkHasPublished() async {
    // Your code to retrieve data from Firestore (using docRef.get())
    QuerySnapshot ridesSnapshot = await FirebaseFirestore.instance
        .collection('Rides')
        .where('email', isEqualTo: user!.email)
        .get();

    if (ridesSnapshot.docs.isNotEmpty) {
      setState(() {
        hasPublished = true;
      });
    } else {
      hasPublished = false;
    }

    // final docSnapshot = await docRef.get();
    // return docSnapshot;
  }

  @override
  void initState() {
    super.initState();
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
    _dateController = TextEditingController();
    checkHasPublished();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Publish a ride",
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 27,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("Where",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextField(
                      controller: _startLocationController,
                      readOnly: true,
                      canRequestFocus: false,
                      onChanged: (value) {
                        _startLocationName = value;
                      },
                      onTap: () {
                        _navigateAndDisplayStartSelection(context);
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _startLocationController.clear();
                              _startLocationName = "";
                            });
                          },
                          icon: Icon(Icons.clear_outlined),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_outlined,
                          size: 32,
                        ),
                        prefixIconColor: _startLocationController.text == ""
                            ? Colors.grey
                            : Colors.green,
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green,
                            )),
                        labelText: 'Leaving from...',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    onPressed: _change,
                    icon: Icon(
                      Icons.swap_vert,
                      size: 35,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 50.0, top: 16.0),
              child: TextField(
                controller: _destinationController,
                readOnly: true,
                canRequestFocus: false,
                onChanged: (value) {
                  _destinationName = value;
                },
                onTap: () {
                  _navigateAndDisplayDestinationSelection(context);
                },
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _destinationController.clear();
                        _destinationName = "";
                      });
                    },
                    icon: Icon(Icons.clear_outlined),
                  ),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 32,
                  ),
                  prefixIconColor: _destinationController.text == ""
                      ? Colors.grey
                      : Colors.green,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      )),
                  labelText: 'Going to...',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 30.0),
              child: Text("When",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 50.0),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                canRequestFocus: false,
                onTap: () async {
                  _date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                  if (_date != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat.MMMMEEEEd().format(_date!);
                    });
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _dateController.clear();
                        _date = null;
                      });
                    },
                    icon: Icon(Icons.clear_outlined),
                  ),
                  prefixIcon: Icon(
                    Icons.calendar_today_outlined,
                    size: 28,
                  ),
                  prefixIconColor:
                      _dateController.text == "" ? Colors.grey : Colors.green,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                      )),
                  labelText: 'Pick a date',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 30.0),
              child: Text("Seats available",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        onPressed: () {
                          if (_passengers > 1) {
                            setState(() {
                              _passengers--;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.green[400],
                        ),
                        iconSize: 40.0,
                      ),
                    ),
                    Text("$_passengers"),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: IconButton(
                          onPressed: () {
                            if (_passengers < 9) {
                              setState(() {
                                _passengers++;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.green[400],
                            size: 40.0,
                          )),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          foregroundColor: Colors.white),
                      child: Text('Publish',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )),
                      onPressed: () {
                        if (hasPublished == false) {
                          if (_startLocationName.isEmpty ||
                              _destinationName.isEmpty ||
                              _date == null) {
                            var snackBar = SnackBar(
                                duration: Durations.long2,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),
                                content: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 12.0),
                                    child: Icon(
                                      Icons.error_outline,
                                      size: 27.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("Fill all fields.")
                                ]));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            FirestoreCrud()
                                .publishRide(
                                    _startLocationName,
                                    _destinationName,
                                    user?.email,
                                    _date!,
                                    _date!,
                                    _passengers.toString(),
                                    GeoPoint(
                                        _startLocationLat, _startLocationLong),
                                    GeoPoint(_destinationLat, _destinationLong))
                                .then((value) =>
                                    HomePage().navigateToPage(context, 2));
                          }
                        } else {
                          var snackBar = SnackBar(
                              duration: Durations.extralong4,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              content: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 12.0),
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 27.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("You have already published a ride.")
                              ]));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplayStartSelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StartLocationSelectPage(),
          fullscreenDialog: true),
    );
    setState(() {
      _startLocationController.text = result[0];
      _startLocationName = result[0];
      _startLocationLat = result[1];
      _startLocationLong = result[2];
    });
  }

  Future<void> _navigateAndDisplayDestinationSelection(
      BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DestinationSelectPage(), //DestinationSelectPage(),
          fullscreenDialog: true),
    );
    setState(() {
      _destinationController.text = result[0];
      _destinationName = result[0];
      _destinationLat = result[1];
      _destinationLong = result[2];
    });
  }

  @override
  void dispose() {
    _startLocationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _change() {
    String temp = _startLocationName;
    setState(() {
      _startLocationName = _destinationName;
      _destinationName = temp;
      _startLocationController.text = _startLocationName;
      _destinationController.text = _destinationName;
    });
  }
}
