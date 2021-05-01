import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String bid,pid;
if (auth.currentUser != null) {
  bid = auth.currentUser.uid;
}

class AddProduct extends StatelessWidget {
  String product_Image;
  String product_Name;
  int price;
  String brand_Id = bid;
  String quantity_In_Stock;
  String description;
  String product_Id;
  int no_of_Comments=0;
  int no_of_Likes=0;
  List<String> comments = [];
  List<String> likes = [];
  // final String product


  AddProduct(this.product_Name, this.product_Image, this.price,this.brand_Id,this.quantity_In_Stock,this.description);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference product_Details = FirebaseFirestore.instance.collection('Product_Details');
    CollectionReference post_Details = FirebaseFirestore.instance.collection('Post_Details');
    
    Future<void> addPost() {
      // Call the user's CollectionReference to add a new user
      return post_Details
          .add({
            'Product_Id': product_Id, // John Doe
            'No_of_Comments': no_of_Comments, // Stokes and Sons
            'No_of_Likes': no_of_Likes,
            'Comments' : comments,
            'Likes' : likes
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
    
    Future<void> addProduct() {
      // Call the user's CollectionReference to add a new user
      return product_Details
          .add({
            'Product_Name': product_Name, // John Doe
            'Product_Image': product_Image, // Stokes and Sons
            'Price': price,
            'Brand_Id' : brand_Id,
            'Quantity_In_Stock' : quantity_In_Stock,
            'Description' : description // 42
          })
          .then((value) => {
                            print("User Added")
                            this.product_Id=value.id;
                            AddPost(this.product_Id, this.no_of_Comments, this.no_of_Likes,this.comments,this.likes);
                            })
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addProduct,
      child: Text(
        "Add Product",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    

    

    return TextButton(
      onPressed: addPost,
      child: Text(
        "Add Post",
      ),
    );
  }
}