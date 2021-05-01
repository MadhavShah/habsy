import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateLikes extends StatelessWidget {
  String user_id;
  String post_id;

  UpdateLikes(this.user_id, this.post_id);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference posts = FirebaseFirestore.instance.collection('Post_Details');

    Future<void> updateLikes() {
      // Call the user's CollectionReference to add a new user
      return posts
          .doc(post_id)
          .update({
            'No_of_Likes':FieldValue.increment(1);
            'Likes':FieldValue.arrayUnion(user_id):
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