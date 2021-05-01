import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddComment extends StatelessWidget {
  String user_id;
  String post_id;
  String comment_text;
  bool isVisible;
  String comment_id;

  AddComment(this.user_id, this.post_id, this.comment_text, this.isVisible, this.comment_id);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference comments = FirebaseFirestore.instance.collection('Comments');

    Future<void> addComment() {
      // Call the user's CollectionReference to add a new user
      return comments
          .add({
            'User_Id':user_id,
            'Post_Id':post_id,
            'Description':comment_text,
            'isVisible':isVisible
          })
          .then((value) =>{ print("User Added")
                            comment_id = value.id;
                            UpdateComment(this.user_id, this.post_id, this.comment_text, this.isVisible);
                            })
          .catchError((error) => print("Failed to add user: $error"));
    }

    CollectionReference posts = FirebaseFirestore.instance.collection('Post_Details');
    
    Future<void> updateComment() {
      // Call the user's CollectionReference to add a new user
      return posts
          .doc(post_id);
          .update({
            'Comment_List':FieldValue.arrayUnion(comment_id)
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