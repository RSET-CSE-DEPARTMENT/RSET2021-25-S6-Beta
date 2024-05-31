import 'package:flutter/material.dart';
import 'package:csv/csv.dart'; // Import CSV package
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<List<dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    loadProductData();
  }

  Future<void> loadProductData() async {
    final String csvString = await rootBundle.loadString('assets/product.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);
    setState(() {
      products = csvTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'), // Your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      products[index][4], // Product picture URL (assuming it's in the 5th column)
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index][1], // Product name (assuming it's in the 2nd column)
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Product Type: ${products[index][0]}', // Skintype (assuming it's in the 1st column)
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Concern: ${products[index][2]}', // Concern (assuming it's in the 3rd column)
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Open product URL in browser
                            // You can use the url_launcher package to launch URLs
                          },
                          child: Text('View Product'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}