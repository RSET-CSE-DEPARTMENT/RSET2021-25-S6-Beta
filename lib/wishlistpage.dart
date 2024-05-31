import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<List<dynamic>> products = [];
  String selectedFilter = 'All';
  List<bool> isInWishlistList = [];
  List<bool> isInCartList = [];

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
      // Initialize isInWishlistList and isInCartList with false for each product
      isInWishlistList = List<bool>.filled(products.length, false);
      isInCartList = List<bool>.filled(products.length, false);
    });
  }

  List<List<dynamic>> filterProducts(String filter) {
    if (filter == 'All') {
      return products;
    } else {
      return products.where((product) => product[6] == filter).toList();
    }
  }

  Future<void> addToWishlist(List<dynamic> productDetails, int index) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/wishlist.csv';
    String csvData = productDetails.map((e) => e.toString()).join(',') + '\n';
    File file = File(filePath);

    if (!isInWishlistList[index]) {
      // Add to wishlist
      await file.writeAsString(csvData, mode: FileMode.append);
    } else {
      // Remove from wishlist
      List<String> lines = await file.readAsLines();
      lines.remove(csvData.trim());
      await file.writeAsString(lines.join('\n'));
    }

    // Toggle isInWishlistList for the corresponding index
    setState(() {
      isInWishlistList[index] = !isInWishlistList[index];
    });
  }

  Future<void> addToCart(List<dynamic> productDetails, int index) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/cart.csv';
    String csvData = productDetails.map((e) => e.toString()).join(',') + '\n';
    File file = File(filePath);

    if (!isInCartList[index]) {
      // Add to cart
      await file.writeAsString(csvData, mode: FileMode.append);
    } else {
      // Remove from cart (not implemented here)
    }

    // Toggle isInCartList for the corresponding index
    setState(() {
      isInCartList[index] = !isInCartList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inventory',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedFilter,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 8,
                    style: TextStyle(color: Colors.white),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue ?? 'All';
                      });
                    },
                    items: <String>[
                      'All',
                      'Cleanser',
                      'Peel',
                      'Moisturizer',
                      'Sunscreen',
                      'Serum',
                      'Eye Serum',
                      'Oil'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    dropdownColor: Color.fromARGB(255, 148, 125, 121),
                    borderRadius: BorderRadius.circular(10),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filterProducts(selectedFilter).length,
                itemBuilder: (BuildContext context, int index) {
                  List<dynamic> filteredProducts = filterProducts(selectedFilter);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 148, 125, 121),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                filteredProducts[index][4],
                                width: 125,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    filteredProducts[index][1],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Product Type: ${filteredProducts[index][0]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Price: ${filteredProducts[index][5]}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () async {
                                            await addToWishlist(filteredProducts[index], index);
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.heart,
                                            color: isInWishlistList[index] ? Colors.brown : Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            await addToCart(filteredProducts[index], index);
                                            // setState is not needed here since addToCart already toggles isInCartList
                                          },
                                          icon: Icon(Icons.shopping_cart),
                                          color: isInCartList[index] ? Colors.brown : Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
