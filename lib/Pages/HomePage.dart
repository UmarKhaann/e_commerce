import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Pages/FavoritesPage.dart';
import 'package:e_commerce/Pages/add_item.dart';
import 'package:e_commerce/Pages/cart.dart';
import 'package:e_commerce/provider/Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Api/CategoriesType.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Consumer<ItemsProvider>(
      builder: (BuildContext context, favoriteProvider, child) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[200],
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .8,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              contentPadding: const EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              suffixIcon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.filter_alt)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                        itemCount: categoriesType.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                categoriesType[index]["Name"] == "All"
                                    ? Container(
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
                                        child: const CircleAvatar(
                                          radius: 35,
                                          backgroundColor: Colors.white,
                                          child: Icon(Icons.all_inclusive),
                                        ))
                                    : Container(
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
                                          radius: 35,
                                          backgroundImage: AssetImage(
                                              categoriesType[index]["Icon"]),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  categoriesType[index]["Name"],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
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
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15),
                          child: const Icon(
                            Icons.monitor_heart,
                            color: Colors.black,
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "50% OFF",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23),
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
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "New Items",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .31,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: favoriteProvider.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(17)),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    topLeft:
                                                        Radius.circular(15)),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                favoriteProvider.items[index]
                                                    ["Image"],
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${favoriteProvider.items[index]["Title"]}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: SizedBox(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                      const TextSpan(
                                                          text: " \$",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      const WidgetSpan(
                                                          child: SizedBox(
                                                        width: 5,
                                                      )),
                                                      TextSpan(
                                                        text:
                                                            "${favoriteProvider.items[index]["Price"]}",
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                    right: 10,
                                    top: 10,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                          onPressed: () {
                                            favoriteProvider.setFavItem(favoriteProvider.items[index]);
                                          },
                                          icon: favoriteProvider.favItems.contains(favoriteProvider.items[index])
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.black,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  currentIndex: 0,
                  selectedFontSize: 30,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled, size: 32), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_rounded, size: 32),
                        label: "Favorite"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add, size: 32),
                        label: "Add"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag, size: 32),
                        label: "Cart"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person, size: 32), label: " Person"),
                  ],
                  onTap: (int index) {
                    switch (index) {
                      case 1:
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Favorites()));

                        break;
                      case 2:
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddItem()));
                        break;
                      case 3:
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cart()));
                        break;
                      // case 3:
                      //   Navigator.pop(context);
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Favorites()));
                      //   break;
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
