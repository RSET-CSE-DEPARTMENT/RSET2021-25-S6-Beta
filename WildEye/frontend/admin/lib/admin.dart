import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class adminChatScreen extends StatefulWidget {
  const adminChatScreen({super.key});

  @override
  State<adminChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<adminChatScreen> {
  final TextEditingController messgcontroller = TextEditingController();
  final List<List<String>> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchingData(); // Fetch messages on initialization
  }

  void _fetchingData() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('messgtable')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        messages.clear(); // Clear the current messages
        snapshot.docs.forEach((doc) {
          final id = doc['id'] as String;
          final message = doc['message'] as String;
          messages.add([id, message]);
          //print(messages); // Add both id and message to the list
        });
      });
    });
  }

  void handletxt() async {
    if (messgcontroller.text.isNotEmpty) {
      // Check for empty message
      String message = messgcontroller.text;
      messgcontroller.text = "";
      await Firebase.initializeApp();
      FirebaseFirestore obj = FirebaseFirestore.instance;
      try {
        await obj.collection('messgtable').add({
          'id': 'ADMIN', // Consider changing 'id' if not needed
          'message': message,
          'time': DateTime.now(),
        });
        setState(() {
          messages.add([message]); // Update UI with sent message (optional)
        });
      } catch (e) {
        print('error entering message data: $e');
      }
    }
  }

  Widget _writelist(int text) {
    //print(text);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0), // Add vertical space between messages
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Align messages to the right
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.7, // Set max width for message container
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.orange[200], // Background color
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              messages[text][0] + ':--\t' + messages[text][1],
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(width: 8.0), // Add space between message container and icon
        ],
        //print(text, "done");
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This line hides the back button
        title: Text('Inbox Chatroom'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, int index) => _writelist(index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messgcontroller,
                    decoration: InputDecoration(
                      hintText: "Enter message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: handletxt,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
