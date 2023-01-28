import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Components/filtered_category.dart';
import 'package:e_commerce/Pages/categories.dart';
import 'package:e_commerce/Pages/favorites_page.dart';
import 'package:e_commerce/Pages/add_item.dart';
import 'package:e_commerce/Pages/cart.dart';
import 'package:e_commerce/Pages/item_screen.dart';
import 'package:e_commerce/Pages/profile_screen.dart';
import 'package:e_commerce/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Api/categories_type.dart';

class HomePageTab extends StatelessWidget {
  HomePageTab({Key? key}) : super(key: key);
  final fireStore = FirebaseFirestore.instance.collection('Items').orderBy('id', descending: true).snapshots();
  final fireStoreRef = FirebaseFirestore.instance.collection("Items");

  void setFavorite(snapShot, index) {
    bool fav;

    // fav = !(snapShot.data!.docs[index]["isFavorite"]);

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
    final size = MediaQuery.of(context).size;
    return Consumer<ItemsProvider>(
      builder: (BuildContext context, favoriteProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[200],
          body: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Search",
                                  contentPadding: const EdgeInsets.all(20),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  suffixIcon: const Icon(Icons.search)))),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.filter_alt)
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: categoriesType.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.only(
                                    top: 30,right: 10,left: 10),
                                child: Column(
                                  children: [
                                    categoriesType[index]["Name"] == "All"
                                        ? GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const CategoriesScreen()));
                                      },
                                          child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 7,
                                                  color: Colors.grey,
                                                  spreadRadius: .5,
                                                  offset: Offset(0.0, 0.75))
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: size.height * .04,
                                            backgroundColor: Colors.white,
                                            child: const Icon(
                                                Icons.all_inclusive),
                                          )),
                                        )
                                        : GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FilteredCategory(category: categoriesType[index]["Name"])));
                                      },
                                          child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 7,
                                              color: Colors.grey,
                                              spreadRadius: .5,
                                            )
                                          ],
                                      ),
                                      child: CircleAvatar(
                                          radius: size.height * .04,
                                          backgroundImage: AssetImage(
                                              categoriesType[index]
                                              ["Icon"]),
                                          backgroundColor: Colors.white,
                                      ),
                                    ),
                                        ),
                                    SizedBox(
                                      height: size.height * .01,
                                    ),
                                    Text(
                                      categoriesType[index]["Name"],
                                    )
                                  ],
                                ));
                          })),
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: .1,
                                color: Colors.grey.shade300)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * .02, horizontal: 10),
                          child: ListTile(
                              horizontalTitleGap: 25,
                              leading: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 4,
                                            color: Colors.grey,
                                            spreadRadius: 2)
                                      ],
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(15),
                                  child: const Icon(
                                    Icons.monitor_heart,
                                    color: Colors.black,
                                  )),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "50% OFF",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("on all women's shoes"),
                                ],
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )))),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  const Text(
                    "New Items",
                    style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: fireStore,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const Expanded(
                              child:
                              Center(child: CircularProgressIndicator()));
                        }
                        if (snapShot.hasError) {
                          return const Center(
                              child: Text("an error has occurred"));
                        }
                        return snapShot.data!.docs.isNotEmpty
                            ? Expanded(
                            flex: 2,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapShot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 2),
                                            borderRadius:
                                            BorderRadius.circular(
                                                17)),
                                        child: Stack(children: [
                                          Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Hero(
                                                  tag:
                                                  'image${snapShot.data!.docs[index].id}',
                                                  child: Container(
                                                      height: size.height *
                                                          .24,
                                                      width: size.width *
                                                          .44,
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.only(
                                                              topRight:
                                                              Radius.circular(
                                                                  15),
                                                              topLeft: Radius.circular(
                                                                  15)),
                                                          image: DecorationImage(
                                                              fit: BoxFit
                                                                  .cover,
                                                              image: NetworkImage(snapShot
                                                                  .data!
                                                                  .docs[index]["imageUrl"])))),
                                                ),
                                                SizedBox(
                                                  height:
                                                  size.height * .01,
                                                ),
                                                Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 20),
                                                    child: Text(
                                                        "${snapShot.data!.docs[index]["title"]}",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .grey,
                                                            fontSize:
                                                            16))),
                                                SizedBox(
                                                    width: 180,
                                                    height:
                                                    size.height *
                                                        .04,
                                                    child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(
                                                            left:
                                                            10),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              RichText(
                                                                  text: TextSpan(
                                                                      style: const TextStyle(color: Colors.black),
                                                                      children: [
                                                                        const TextSpan(
                                                                            text: " \$",
                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                                        const WidgetSpan(child: SizedBox(width: 5)),
                                                                        TextSpan(
                                                                            text: "${snapShot.data!.docs[index]["price"]}",
                                                                            style: const TextStyle(
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w500,
                                                                            ))
                                                                      ])),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    navigateToItemScreen(
                                                                        context,
                                                                        snapShot,
                                                                        index,
                                                                        snapShot.data!.docs[index].id.toString());
                                                                  },
                                                                  icon:
                                                                  const Icon(Icons.add))
                                                            ])))
                                              ]),
                                          Positioned(
                                              right: 10,
                                              top: 10,
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                  Colors.white,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setFavorite(
                                                            snapShot,
                                                            index);
                                                      },
                                                      icon: snapShot
                                                          .data!
                                                          .docs[index]
                                                      [
                                                      'isFavorite']
                                                          ? const Icon(
                                                        Icons
                                                            .favorite,
                                                        color: Colors
                                                            .black,
                                                      )
                                                          : const Icon(
                                                        Icons
                                                            .favorite_outline,
                                                        color: Colors
                                                            .black,
                                                      ))))
                                        ])),
                                  );
                                }))
                            : const Expanded(
                            child: Center(
                                child: Text(
                                    "There isn't any data to show")));
                      })
                ],
              )),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> body = [
    HomePageTab(),
    Favorites(),
    const AddItem(),
    const Cart(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsProvider>(
      builder: (BuildContext context, favoriteProvider, child) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[200],
            body: Center(child: body[_currentIndex],),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.black),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.amber,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  selectedFontSize: 30,
                  onTap: (int newIndex) {
                    setState(() {
                      _currentIndex = newIndex;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled, size: 32), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_rounded, size: 32),
                        label: "Favorite"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add, size: 32), label: "Add"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag, size: 32),
                        label: "Cart"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person, size: 32), label: " Person"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
