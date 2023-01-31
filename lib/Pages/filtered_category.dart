import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Components/custom_stack.dart';
import 'package:e_commerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Functions/functions.dart';

class FilteredCategory extends StatelessWidget {
  FilteredCategory({required this.category, Key? key}) : super(key: key);

  final String category;
  final fireStoreRef = FirebaseFirestore.instance.collection("Items");
  Functions functions = Functions();

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance
        .collection('Items')
        .where('category', arrayContains: category)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(category),
          actions: const [Icon(Icons.filter_alt), SizedBox(width: 10)],
        ),
        body: SafeArea(child: Consumer<ItemsProvider>(
            builder: (BuildContext context, favoriteProvider, child) {
          return StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapShot.hasError) {
                return const Center(child: Text("an error has occurred"));
              }
              String items = '';
              snapShot.data!.docs.length != 1
                  ? items = "Items"
                  : items = "Item";
              return snapShot.data!.docs.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          '${snapShot.data!.docs.length.toString()} $items',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10),
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 150 / 205,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0),
                                  itemCount: snapShot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return CustomStack(snapShot: snapShot, index: index);
                                  },
                                )))
                      ],
                    )
                  : Center(
                      child: Text(
                          "There isn't anything data of category $category"));
            },
          );
        })));
  }
}
