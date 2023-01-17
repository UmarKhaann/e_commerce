import 'package:e_commerce/Pages/HomePage.dart';
import 'package:e_commerce/Pages/add_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Provider.dart';
import 'FavoritesPage.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 18,
          ),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<ItemsProvider>(
        builder: (context, favoriteProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: favoriteProvider.cart.length,
                    itemBuilder: (context, index) {
                      return Container();
                    }),
              )
            ],
          );
        },
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
            currentIndex: 3,
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
                  icon: Icon(Icons.shopping_bag, size: 32), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 32), label: " Person"),
            ],
            onTap: (int index) {
              switch (index) {
                case 0:
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                  break;
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
              }
            },
          ),
        ),
      ),
    );
  }
}
