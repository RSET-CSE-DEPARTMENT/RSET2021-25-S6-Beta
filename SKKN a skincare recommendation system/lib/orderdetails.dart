import 'package:flutter/material.dart';

class OrderDetailsPages extends StatelessWidget {
  final String streetName;
  final String cityName;
  final String houseName;
  final String pincode;
  final String landmark;
  final String contactDetails;

  OrderDetailsPages({
    required this.streetName,
    required this.cityName,
    required this.houseName,
    required this.pincode,
    required this.landmark,
    required this.contactDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Street Name: $streetName'),
            Text('City Name: $cityName'),
            Text('House Name/Number: $houseName'),
            Text('Pincode: $pincode'),
            Text('Nearby Landmark: $landmark'),
            Text('Contact Details: $contactDetails'),
            // Add more order details as needed
          ],
        ),
      ),
    );
  }
}
