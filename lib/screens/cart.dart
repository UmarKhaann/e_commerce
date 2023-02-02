import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';


class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 18,),
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
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: favoriteProvider.cartValues.length,
                      itemBuilder: (context, index) {
                        final key = favoriteProvider.cartValues.keys.elementAt(index);
                        final value = favoriteProvider.cartValues.values.elementAt(index);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.radio_button_off),
                            Padding(
                                padding: const EdgeInsets.all(15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    width: size.width * .17,
                                    height: size.height * .08,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          value["imageUrl"]),
                                    ),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value['title'].toString(), style: const TextStyle(fontSize: 16, color: Colors.grey),),
                                RichText(text: TextSpan(
                                    style:
                                    const TextStyle(color: Colors.black),
                                  children: [
                                    const TextSpan(text: "\$", style: TextStyle(fontSize: 15)),
                                    const WidgetSpan(child: SizedBox(
                                      width: 5,
                                    )),
                                    TextSpan(text: value['price'].toString(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),)
                                  ]
                                )),
                              ],
                            ),
                            Expanded(child: Container()),
                            const Icon(Icons.remove),
                            const SizedBox(width: 15,),
                            const Text("01", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),),
                            const SizedBox(width: 15,),
                            const Icon(Icons.add)
                          ],
                        );
                      }),
                ),
                Expanded(child: Container(color: Colors.white,))
              ],
            ),
          );
        },
      ),
    );
  }
}
