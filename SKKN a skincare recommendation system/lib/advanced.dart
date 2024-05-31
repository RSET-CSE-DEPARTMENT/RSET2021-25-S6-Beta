// advanced.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'second.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: AdvancedPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class AdvancedPage extends StatefulWidget {
  @override
  _AdvancedPageState createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage> {
  late List<List<dynamic>> csvData;
  late Map<String, List<String>> dataFromTxt;

  @override
  void initState() {
    super.initState();
    loadCSV();
    loadDataFromTxt();
  }

  Future<void> loadCSV() async {
    final String rawCSV = await rootBundle.loadString('assets/product.csv');
    csvData = CsvToListConverter().convert(rawCSV);
    setState(() {}); // Refresh the UI after loading CSV data
  }

  Future<void> loadDataFromTxt() async {
    final String rawTxt = await rootBundle.loadString('assets/data.txt');
    List<String> lines = rawTxt.split('\n');
    dataFromTxt = {};
    for (String line in lines) {
      List<String> parts = line.split(',');
      if (parts.length >= 2) {
        String productType = parts[0];
        String data = parts[1];
        if (!dataFromTxt.containsKey(productType)) {
          dataFromTxt[productType] = [];
        }
        dataFromTxt[productType]?.add(data.trim());
      }
    }
    setState(() {}); // Refresh the UI after loading data from txt
  }

  List<String>? getDataForProductType(String productType) {
    return dataFromTxt[productType];
  }

  List<Product> getProductsWithPriceForType(String productType) {
    List<Product> products = [];
    for (var row in csvData) {
      if (row.length >= 7 && row[6] == productType) {
        products.add(Product(name: row[1], price: row[5], image: row[6])); 
      }
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/advance.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Cleanser',
                        products: getProductsWithPriceForType('Cleanser'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Exfoliant',
                        products: getProductsWithPriceForType('Exfoliant'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Moisturizer',
                        products: getProductsWithPriceForType('Moisturizer'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Toner',
                        products: getProductsWithPriceForType('Toner'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Serum',
                        products: getProductsWithPriceForType('Serum'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Mask',
                        products: getProductsWithPriceForType('Mask'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Treatment',
                        products: getProductsWithPriceForType('Treatment'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Sunscreen',
                        products: getProductsWithPriceForType('Sunscreen'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0), // Add padding to shift the container to the side
                      child: HeadingWithBox(
                        title: 'Lip Balm',
                        products: getProductsWithPriceForType('Lip Balm'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePages()),
                    );
                  },
                  child: Text('Go To Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeadingWithBox extends StatelessWidget {
  final String title;
  final List<Product>? products;

  const HeadingWithBox({Key? key, required this.title, this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 87, 59, 41),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          padding: EdgeInsets.all(20),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              if (products != null && products!.isNotEmpty)
                for (Product product in products!)
                  GestureDetector(
                    onTap: () {
                      // Handle tapping on the product (e.g., navigate to product details page)
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 223, 190, 147),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/${product.image}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(product.name),
                          Text(product.price),
                          IconButton(
                            onPressed: () {
                              // Handle adding/removing from wishlist
                            },
                            icon: Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                    ),
                  ),

              if (products == null || products!.isEmpty)
                Center(
                  child: Text('No data available'),
                ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class Product {
  final String name;
  final String price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}