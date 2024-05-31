import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatelessWidget {
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PaymentOptionButton(
                icon: Icons.money_rounded,
                label: 'Cash on Delivery',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CodPage()),
                  );
                },
              ),
              SizedBox(height: 20),
              PaymentOptionButton(
                icon: Icons.payment,
                label: 'UPI Payment',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpiPaymentPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const PaymentOptionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(label),
        ],
      ),
    );
  }
}

class CodPage extends StatelessWidget {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Delivery Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1. Deliver the package to the address provided by the user.',
              ),
              SizedBox(height: 5),
              Text(
                '2. Ensure that the user is available at the provided address to accept the delivery.',
              ),
              SizedBox(height: 5),
              Text(
                '3. Collect the amount from the user for the product ordered.',
              ),
              SizedBox(height: 5),
              Text(
                '4. Inform the user about the estimated delivery time.',
              ),
              SizedBox(height: 5),
              Text(
                '5. Sign the delivery receipt.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpiPaymentPage extends StatelessWidget {
  final TextEditingController _upiIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _transactionNoteController =
      TextEditingController();

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
          child: Column(
            children: [
              TextField(
                controller: _upiIdController,
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _transactionNoteController,
                decoration: InputDecoration(
                  labelText: 'Transaction Note',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String _upiId = _upiIdController.text;
                  String _amount = _amountController.text;
                  String _transactionNote = _transactionNoteController.text;

                  if (_upiId.isEmpty || _amount.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields are required')),
                    );
                    return;
                  }

                  initiateUpiPayment(
                    context: context,
                    upiId: _upiId,
                    amount: _amount,
                    transactionNote: _transactionNote,
                  );
                },
                child: Text('Pay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initiateUpiPayment({
    required BuildContext context,
    required String upiId,
    required String amount,
    required String transactionNote,
  }) async {
    // Your UPI payment logic here
    // For example:
    // final response = await SomeUpiPlugin.initiateTransaction();
    // Handle the response accordingly
  }
}
