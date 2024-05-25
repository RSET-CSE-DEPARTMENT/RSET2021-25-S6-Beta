import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ride_share_test/pages/search_results_page.dart';
import 'package:ride_share_test/pages/start_location_select_page.dart';
import 'package:ride_share_test/pages/destination_select_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _startLocationController;
  late TextEditingController _destinationController;
  late TextEditingController _dateController;
  String _startLocation = "";
  String _destination = "";
  double _startLat = 0.0;
  double _startLong = 0.0;
  double _destLong = 0.0;
  double _destLat = 0.0;

  DateTime? _date = DateTime.now();
  int _passengers = 1;

  @override
  void initState() {
    super.initState();
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
    _dateController = TextEditingController();
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
              "Find a ride",
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
                        _startLocation = value;
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
                              _startLocation = "";
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
                  _destination = value;
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
                        _destination = "";
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
              child: Text("Seats needed",
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
                      child: Text('Search',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          )),
                      onPressed: () {
                        if (_startLocation.isEmpty ||
                            _destination.isEmpty ||
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultsPage(
                                  startLat: _startLat,
                                  startLong: _startLong,
                                  destLat: _destLat,
                                  destLong: _destLong,
                                  startLocation: _startLocation,
                                  destination: _destination,
                                  date: _date!,
                                  passengers: _passengers,
                                ),
                              ));
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
      _startLocation = result[0];
      _startLat = result[1];
      _startLong = result[2];
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
      _destination = result[0];
      _destLat = result[1];
      _destLong = result[2];
    });
  }

  @override
  void dispose() {
    _startLocationController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _change() {
    String temp = _startLocation;
    setState(() {
      _startLocation = _destination;
      _destination = temp;
      _startLocationController.text = _startLocation;
      _destinationController.text = _destination;
    });
  }
}
