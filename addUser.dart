import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final String uid;
if (auth.currentUser != null) {
  uid = auth.currentUser.uid;
}

class AddUser extends StatelessWidget {
  String name;
  String email_Id;
  String address;
  bool is_Brand;
  int phone_No;
  int pincode;

  AddUser(this.name, this.email_Id, this.address, this.is_Brand, this.phone_No, this.pincode);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('Customer_Details');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .doc(uid);
          .set({
            'Name': name, // John Doe
            'Email_Id': email_Id, // Stokes and Sons
            'Address': address, // 42
            'Phone_No': phone_No,
            'Is_Brand': is_Brand,
            'Pincode': pincode
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}