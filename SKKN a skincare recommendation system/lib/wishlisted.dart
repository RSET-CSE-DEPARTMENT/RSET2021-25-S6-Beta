import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<List<dynamic>> wishlistData = [];

  @override
  void initState() {
    super.initState();
    loadWishlistData();
  }

  Future<void> loadWishlistData() async {
    final String rawCsv = await rootBundle.loadString('assets/wishlist.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(rawCsv);
    setState(() {
      wishlistData = csvTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: wishlistData.length,
          itemBuilder: (context, index) {
            var product = wishlistData[index];
            return ListTile(
              title: Text(product[0]),
              subtitle: Text('\$${product[1]}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // Add to cart functionality
                  // You can implement this based on your app's logic
                },
                child: Text('Add to Cart'),
              ),
            );
          },
        ),
      ),
    );
  }
}
