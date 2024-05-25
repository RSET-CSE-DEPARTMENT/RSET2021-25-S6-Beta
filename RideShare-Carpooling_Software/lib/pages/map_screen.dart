import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:ride_share_test/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:ride_share_test/services/auth.dart';

// class MapScreenPage extends StatefulWidget {
//   const MapScreenPage({super.key});

//   @override
//   State<MapScreenPage> createState() => _MapScreenPageState();
// }

class MapScreenPage extends StatefulWidget {
  final GeoPoint startLat;
  final GeoPoint destLat;

  const MapScreenPage({
    Key? key,
    required this.startLat,
    required this.destLat,
  }) : super(key: key);

  @override
  State<MapScreenPage> createState() => _MapScreenPageState();
}

class _MapScreenPageState extends State<MapScreenPage> {
  @override
  void initState() {
    super.initState();
    destLatLng = geoPointToLatLng(widget.destLat);
    startLatLng = geoPointToLatLng(widget.startLat);
  }

  @override
  void dispose() {
    positionStreamSubscription.cancel();
    super.dispose();
  }

  final User? user = Auth().currentUser;
  late StreamSubscription<Position> positionStreamSubscription;
  late LatLng destLatLng;
  late LatLng startLatLng;
  String userEmail = "";
  bool isRideStarted = false;
  List listofpoint = [];
  List<LatLng> points = [];

  getCoordinates() async {
    var response = await http.get(getRouteUrl(
        "${startLatLng.longitude}, ${startLatLng.latitude}",
        "${destLatLng.longitude}, ${destLatLng.latitude}"));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listofpoint = data['features'][0]['geometry']['coordinates'];
        points = listofpoint
            .map((e) => LatLng(e[1].toDouble(), e[0].toDouble()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Or TextDirection.rtl
      child: Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
          FlutterMap(
            options: MapOptions(
              cameraConstraint: CameraConstraint.unconstrained(),
              initialZoom: 14.5,
              initialCenter:
                  LatLng(widget.startLat.latitude, widget.startLat.longitude),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                // Plenty of other options available!
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                        widget.startLat.latitude, widget.startLat.longitude),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.assistant_navigation,
                          color: Colors.blue,
                          size: 45,
                        ),
                        Text(
                          'Start',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            letterSpacing: 3,
                            fontWeight:
                                FontWeight.w700, // Adjust weight as needed
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                        widget.destLat.latitude, widget.destLat.longitude),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 51,
                        ),
                        Text(
                          'End',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            letterSpacing: 3,
                            fontWeight:
                                FontWeight.w700, // Adjust weight as needed
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.blue,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          !isRideStarted
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isRideStarted = true;
                          });
                          getCoordinates();
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
                        child: Text(
                          '   Start ride   ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust for desired squareness
                          ),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'Cancel ride',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0),
                  child: Container(
                    height: 60.0, // Adjust height as needed
                    width: double.infinity, // Adjust width as needed
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust corner radius as desired
                    ),
                    child: Center(
                      child: Text(
                        'Ride in progress',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          letterSpacing: 3,
                          fontWeight:
                              FontWeight.w700, // Adjust weight as needed
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
        ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       isRideStarted = true;
        //     });
        //     getCoordinates();
        //   },
        //   child: const Icon(Icons.location_on),
        // ),
      ),
    );
  }

  LatLng geoPointToLatLng(GeoPoint geoPoint) {
    return LatLng(geoPoint.latitude, geoPoint.longitude);
  }
}
