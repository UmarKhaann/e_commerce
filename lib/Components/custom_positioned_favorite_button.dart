import 'package:flutter/material.dart';

import '../Functions/functions.dart';

class CustomPositionedFavoriteButton extends StatelessWidget {
  const CustomPositionedFavoriteButton({
    required this.snapShot, required this.index,
    required this.right,
    Key? key}) : super(key: key);
  final index;
  final snapShot;
  final right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: right,
        top: 10,
        child: CircleAvatar(
            backgroundColor:
            Colors.white,
            child: IconButton(
                onPressed: () {
                  Functions f = Functions();
                  f.setFavorite(snapShot, index);
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
                ))));
  }
}
