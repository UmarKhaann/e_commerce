import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/item_screen.dart';

class FilteredCategory extends StatelessWidget {
  final String category;
  FilteredCategory({
    required this.category,
    Key? key}) : super(key: key);

  final fireStoreRef = FirebaseFirestore.instance.collection("Items");

  void setFavorite(snapShot, index)async {
    bool fav;
    if (snapShot.data!.docs[index]["isFavorite"] != true) {
      fav = true;
    } else {
      fav = false;
    }
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

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance
        .collection('Items').where('category', arrayContains: category)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(category),
        actions: const [
          Icon(Icons.filter_alt),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<ItemsProvider>(
          builder: (BuildContext context, favoriteProvider, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapShot.hasError) {
                  return const Center(child: Text("an error has occurred"));
                }
                String items = '';
                snapShot.data!.docs.length != 1 ? items = "Items" : items = "Item";
                return snapShot.data!.docs.isNotEmpty
                    ? Column(
                  children: [
                    Text('${snapShot.data!.docs.length.toString()} $items', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
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
                            return Center(
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                snapShot.data!.docs[index]
                                                ['imageUrl'],
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${snapShot.data!.docs[index]["title"]}",
                                        style:
                                        const TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: SizedBox(
                                          height: 40,
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                      const TextSpan(
                                                        text: "\$",
                                                      ),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                            width: 5,
                                                          )),
                                                      TextSpan(
                                                        text:
                                                        "${snapShot.data!.docs[index]["price"]}",
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  navigateToItemScreen(
                                                      context,
                                                      snapShot,
                                                      index,
                                                      snapShot.data!.docs[index].id.toString());
                                                },
                                                icon: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    right: 20,
                                    top: 10,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                          onPressed: () {
                                            setFavorite(snapShot, index);
                                          },
                                          icon: snapShot.data!.docs[index]["isFavorite"] ? const Icon(
                                            Icons.favorite,
                                            color: Colors.black,
                                          ) : const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
                    : Center(
                  child:
                  Text("There isn't anything data of category $category"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
