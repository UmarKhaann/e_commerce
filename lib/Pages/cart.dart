import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';


class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
    );
  }
}
