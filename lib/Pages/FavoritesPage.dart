import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Pages/HomePage.dart';
import 'package:e_commerce/Pages/add_item.dart';
import 'package:e_commerce/Pages/cart.dart';
import 'package:e_commerce/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  Favorites({Key? key}) : super(key: key);

  final firestore = FirebaseFirestore.instance
      .collection('Items')
      .where('isFavorite', isEqualTo: true)
      .snapshots();
  final fireStoreRef = FirebaseFirestore.instance.collection("Items");

  void setFavorite(snapShot, index) {
    bool fav;
    if (snapShot.data!.docs[index]["isFavorite"] != true) {
      fav = true;
    } else {
      fav = false;
    }
    fireStoreRef
        .doc(snapShot.data!.docs[index].id.toString())
        .update({"isFavorite": fav ?? false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Favorites"),
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
                return snapShot.data!.docs.isNotEmpty
                    ? Padding(
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
                                                onPressed: () {},
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
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child:
                            Text("There isn't anything selected as Favorite"),
                      );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.black),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: 1,
            selectedFontSize: 30,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 32), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded, size: 32),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add, size: 32), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag, size: 32), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 32), label: " Person"),
            ],
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  break;
                case 2:
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItem()));
                  break;
                case 3:
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
