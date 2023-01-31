import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Pages/item_screen.dart';

class Functions{
  final fireStoreRef = FirebaseFirestore.instance.collection("Items");

  void setFavorite(snapShot, index) {
    bool fav;
    fav = !(snapShot.data!.docs[index]["isFavorite"]);
    fireStoreRef
        .doc(snapShot.data!.docs[index].id.toString())
        .update({"isFavorite": fav});
  }

  navigateToItemScreen(context, snapShot, index, id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemScreen(
                id: id,
                isFavorite: snapShot.data!.docs[index]['isFavorite'],
                title: snapShot.data!.docs[index]['title'],
                price: snapShot.data!.docs[index]['price'],
                description: snapShot.data!.docs[index]['description'],
                imageUrl: snapShot.data!.docs[index]['imageUrl'])));
  }
}