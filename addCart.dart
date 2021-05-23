import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final String uid;
if (auth.currentUser != null) {
  uid = auth.currentUser.uid;
}

class AddToCart extends StatelessWidget {
  String prodId;
  int quantity;
  
  
  

  AddToCart(this.prodId, this.quantity);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference Products = FirebaseFirestore.instance.collection('Cart').doc(uid).collection('Products');
    CollectionReference ProductDetails = FirebaseFirestore.instance.collection('Product_Details');
    int price=0;
    
    Future<void> addTocart()
    {
       return ProductDeails.doc(this.prodId).get()
       .then((value){
       price=value.data()["Price"];
       quantityUpdate();
       costUpdate();
       }
       ).
       catchError((error)=>print("Error"));
    }
    

     

    Future<void> quantityUpdate() {
    
      return Products
          .doc(this.prodId);
          .update({
            'Quantity': FieldValue.increment(this,quantity);
          }).
          .then((value) => print("Cart Added"))
          .catchError((error) => print("Failed to add in cart: $error"));
    }

    Future<void> costUpdate()
    {
      return FirebaseFirestore.instance.collection('Cart').doc(uid).
               update({
                 'Total_Cost': FieldValue.increment(this,quantity*price);
               }).
               .then((value) => print("Amount updated"))
              .catchError((error) => print("Failed  $error"));
    }

    return TextButton(
      onPressed: addTocart,
      child: Text(
        "Add User",
      ),
    );
  }
}
