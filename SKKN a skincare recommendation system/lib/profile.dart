import 'package:flutter/material.dart';
import 'wishlistpage.dart';
import 'payment.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String location;

  const ProfilePage({Key? key, required this.name, required this.email, required this.location}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 120.0,
            left: 20.0,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage('assets/images/profile_background.jpg'),
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.location,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.0), // Adjusted space for top section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60.0, // Fixed height for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle "Your Orders" button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaymentPage()),
                          );
                        },
                        child: Text('Pay Here'),
                      ),
                    ),
                    Container(
                      height: 60.0, // Fixed height for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle "Your Account" button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePageDetails()),
                          );
                        },
                        child: Text('Your Account'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0), // Added space between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60.0, // Fixed height for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle "Buy Again" button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BuyAgainPage()),
                          );
                        },
                        child: Text('   Wishlist '),
                      ),
                    ),
                    Container(
                      height: 60.0, // Fixed height for button
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle "Your List" button press
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WishlistPage()),
                          );
                        },
                        child: Text('  Your List  '),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ProfilePageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying user's orders or a message if no orders exist
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Account'),
      ),
      body: Center(
        child: Text('Display user orders here'),
      ),
    );
  }
}
class BuyAgainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying products for re-purchase
    return Scaffold(
      appBar: AppBar(
        title: Text('WishList'),
      ),
      body: Center(
        child: Text('wishlisted products here'),
      ),
    );
  }
}

class YourListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the UI for displaying the user's wishlist or saved items list
    return MaterialApp(
       // Disable debug banner
      home: WishlistPage(),
    );
  }
}
