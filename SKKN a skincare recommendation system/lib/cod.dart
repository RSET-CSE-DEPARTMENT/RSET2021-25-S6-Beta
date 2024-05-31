import 'package:flutter/material.dart';
import 'package:skkn/orderdetails.dart';

class CodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: CodPage(),
    );
  }
}

class CodPage extends StatefulWidget {
  @override
  _CodPageState createState() => _CodPageState();
}

class _CodPageState extends State<CodPage> {
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _contactDetailsController = TextEditingController();
  String selectedCountryCode = '+1'; // Default country code (e.g., +1 for USA)

  Map<String, int> countryMobileLength = {
    '+1': 10, // USA
    '+91': 10, // India
    '+44': 10, // UK
    // Add more country codes and their respective mobile number lengths here
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'), // Adjust the image path as needed
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Instructions:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '1. Please keep exact cash ready for payment.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '2. Provide accurate delivery details including full address.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery Address:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _streetNameController,
                      decoration: InputDecoration(
                        labelText: 'Street Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _cityNameController,
                      decoration: InputDecoration(
                        labelText: 'City Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _houseNameController,
                      decoration: InputDecoration(
                        labelText: 'House Name/Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _pincodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Pincode',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _landmarkController,
                      decoration: InputDecoration(
                        labelText: 'Nearby Landmark',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: selectedCountryCode,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: '+1',
                          child: Text('+1 (USA)'),
                        ),
                        DropdownMenuItem(
                          value: '+91',
                          child: Text('+91 (India)'),
                        ),
                        DropdownMenuItem(
                          value: '+44',
                          child: Text('+44 (UK)'),
                        ),
                        // Add more country codes here
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _contactDetailsController,
                        maxLength: countryMobileLength[selectedCountryCode],
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Contact Details (${countryMobileLength[selectedCountryCode]} digits)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement your Cash on Delivery logic here
                    String streetName = _streetNameController.text;
                    String cityName = _cityNameController.text;
                    String houseName = _houseNameController.text;
                    String pincode = _pincodeController.text;
                    String landmark = _landmarkController.text;
                    String contactDetails = _contactDetailsController.text;

                    if (streetName.isEmpty ||
                        cityName.isEmpty ||
                        houseName.isEmpty ||
                        pincode.isEmpty ||
                        landmark.isEmpty ||
                        contactDetails.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Please enter all details'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Proceed with order placement
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Order Placed'),
                            content: Text('Your order has been placed successfully!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  //Navigator.push(
                         // context,
                        //  MaterialPageRoute(builder: (context) => ()),
                       // );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Proceed with Cash on Delivery'),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(CodApp());
}
