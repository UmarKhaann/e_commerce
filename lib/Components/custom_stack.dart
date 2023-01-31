import 'package:flutter/material.dart';

import '../Functions/functions.dart';
import 'custom_positioned_favorite_button.dart';

class CustomStack extends StatelessWidget {
  const CustomStack({
    required this.snapShot,
    required this.index,
    Key? key}) : super(key: key);
  final snapShot;
  final index;

  @override
  Widget build(BuildContext context) {
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
                          Functions f = Functions();
                          f.navigateToItemScreen(
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
          CustomPositionedFavoriteButton(snapShot: snapShot, index: index, right: 20.0,)
        ],
      ),
    );
  }
}
