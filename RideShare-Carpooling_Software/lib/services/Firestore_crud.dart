import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreCrud {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  void createUser(
      String? name, String? age, String? email, String? mobileNumber) {
    // Define the data you want to write
    Map<String, dynamic> data = {
      'name': name,
      'age': age,
      'email': email,
      'mobile_number': mobileNumber,
      'distance_travelled': '0',
      'emergency_contact': "",
      'level': 'Bronze',
      'rides_as_passenger': '0',
      'rides_as_driver': '0'
    };

    // Add the data to Firestore
    _firestore.collection('Users').add(data);
  }

  Future<bool> checkUserExists(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("Users")
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> editUsreDetails(
      String contact, String age, String emergencyContact, String bio) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .where('email', isEqualTo: currentUser?.email)
          .get();

      // Check if there's at least one document that matches the query
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming you want to update the first document that matches the query
        String documentId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(documentId)
            .update({
          'age': age,
          'emergency_contact': emergencyContact,
          'mobile_number': contact,
          'bio': bio
        });
      } else {
        print("No document found with specified field value.");
      }
    } catch (e) {
      print("Error updating document field: $e");
    }
  }

  Future<void> publishRide(
      String? startLocationName,
      String? destinationName,
      String? email,
      DateTime date,
      DateTime time,
      String availableSeats,
      GeoPoint startLocationGeopoint,
      GeoPoint destinationGeopoint) async {
    // Define the data you want to write
    Map<String, dynamic> data = {
      'startLocationName': startLocationName,
      'destinationName': destinationName,
      'email': email,
      'date': date,
      'time': time,
      'availableSeats': availableSeats,
      'startLocationGeopoint': startLocationGeopoint,
      'destinationGeopoint': destinationGeopoint,
    };

    // Add the data to Firestore
    await _firestore.collection('Rides').add(data);
  }

  Future<void> addRequest(String? senderId, String docId, String seats) async {
    final _firestore = FirebaseFirestore.instance;

    // Create a reference to the document
    final docRef = _firestore.collection('Rides').doc(docId);

    final nameref = await _firestore
        .collection("Users")
        .where('email', isEqualTo: senderId)
        .get();
    if (nameref.docs.isEmpty) {
      return null; // Handle case where no user found
    }

    // Assuming there's only one document with the email (modify if needed)
    final doc = nameref.docs.first;
    final userDocId = doc.id;
    final userDocRef = _firestore.collection('Users').doc(userDocId);

    final name = doc.get('name');
    // Get a reference to the request subcollection
    final requestCollectionRef = docRef.collection('Requests');
    final userRequestCollectionRef = userDocRef.collection('Requests');

    // Prepare data for the request document
    final requestData = {
      'senderId': name,
      'isAccepted': false,
      'seatRequested': seats,
      'senderEmail': senderId
    };

    final userRequestData = {
      'rideReference': docId,
      'isAccepted': false,
    };
    // Add the request document with a unique ID within the subcollection
    await requestCollectionRef.add(requestData);
    await userRequestCollectionRef.add(userRequestData);
  }

  Future<String> getAvailableSeats(String documentId) async {
    final docRef =
        FirebaseFirestore.instance.collection("Rides").doc(documentId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      return data['availableSeats']
          as String; // Cast to String type (adjust if different)
    } else {
      // Document not found handling
      return ""; // Or handle as needed
    }
  }

  Future<bool> acceptRequest(
      String ridedocref, String reqdocref, String requestedSeats) async {
    try {
      DocumentReference rideSnapshot =
          await FirebaseFirestore.instance.collection("Rides").doc(ridedocref);
      final reqdoc = rideSnapshot.collection("Requests").doc(reqdocref);
      String availableSeats = await getAvailableSeats(ridedocref);

      if (int.parse(availableSeats) < int.parse(requestedSeats)) {
        print("IFIFIFIFFIFIFIFI");
        print("FALSE");
        return false;
      } else {
        final updateRideData = {
          'availableSeats':
              (int.parse(availableSeats) - int.parse(requestedSeats))
                  .toString(),
        };

        // Check if there's at least one document that matches the query
        final updateData = {
          // Update sender name if needed
          'isAccepted':
              true, // Update acceptance status // Update requested seats
        };

        // Update the document with the prepared data
        await reqdoc.update(updateData);
        await rideSnapshot.update(updateRideData);
        print('Request updated successfully!');

        return true;
      }
    } on FirebaseException catch (e) {
      print('Error updating request: ${e.message}');
      return false;
      // Handle potential errors (e.g., throw an exception)
    }
  }

  Future<bool> removeRequest(
      String ridedocref, String reqdocref, String requestedSeats) async {
    try {
      DocumentReference rideSnapshot =
          await FirebaseFirestore.instance.collection("Rides").doc(ridedocref);
      final reqdoc = rideSnapshot.collection("Requests").doc(reqdocref);
      String availableSeats = await getAvailableSeats(ridedocref);

      final updateRideData = {
        'availableSeats':
            (int.parse(availableSeats) + int.parse(requestedSeats)).toString(),
      };

      // Check if there's at least one document that matches the query
      final updateData = {
        // Update sender name if needed
        'isAccepted':
            false, // Update acceptance status // Update requested seats
      };

      // Update the document with the prepared data
      await reqdoc.update(updateData);
      await rideSnapshot.update(updateRideData);
      print('Request updated successfully!');

      return true;
    } on FirebaseException catch (e) {
      print('Error updating request: ${e.message}');
      return false;
      // Handle potential errors (e.g., throw an exception)
    }
  }

  Future<void> declineRequest(String ridedocref, String reqdocref) async {
    try {
      DocumentReference rideSnapshot =
          await FirebaseFirestore.instance.collection("Rides").doc(ridedocref);
      final reqdoc = rideSnapshot.collection("Requests").doc(reqdocref);
      // Check if there's at least one document that matches the query

      // Update the document with the prepared data
      await reqdoc.delete();
      print('Request deleted successfully!');
    } on FirebaseException catch (e) {
      print('Error updating request: ${e.message}');
      // Handle potential errors (e.g., throw an exception)
    }
  }

  void deleteRequest(String userDocId, String requestId) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userDocId)
        .collection("Requests")
        .doc(requestId)
        .delete()
        .then((_) {
      print('Document successfully deleted');
    }).catchError((error) {
      print('Error deleting document: $error');
    });
  }

  void setCurrentRide(String valueToCheck, String rideDocRef) {
    // Reference to the Firestore collection
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Users');

    // Query for the document based on the field to check
    collectionRef
        .where('email', isEqualTo: valueToCheck)
        .get()
        .then((QuerySnapshot querySnapshot) {
      // Iterate over the documents matching the query
      querySnapshot.docs.forEach((doc) {
        // Reference to the document
        DocumentReference docRef = collectionRef.doc(doc.id);

        // Update the document with the new field value
        docRef.update({'currentRide': rideDocRef}).then((_) {
          print('Field successfully updated');
        }).catchError((error) {
          print('Error updating field: $error');
        });
      });
    }).catchError((error) {
      print('Error querying documents: $error');
    });
  }
}
