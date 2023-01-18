import 'dart:io';

import 'package:flutter/foundation.dart';

class ItemsProvider with ChangeNotifier {
  final List _items = [
    {
      "Image": "assets/images/shoe5.jpg",
      "Title": "Sneakers",
      "Price": "60.00",
      "Category": "Shoes"
    },
    {
      "Image": "assets/images/shoex.jpg",
      "Title": "Red Boots",
      "Price": "40.00",
      "Category": "Shoes"
    },
    {
      "Image": "assets/images/hoodie1.jpg",
      "Title": "Hoodie",
      "Price": "30.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/kurta1.jpg",
      "Title": "Kurta",
      "Price": "85.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/shorts1.jpg",
      "Title": "Shorts",
      "Price": "35.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/dress1.jpg",
      "Title": "Dress",
      "Price": "35.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/shoe3.jpg",
      "Title": "Yellow Boots",
      "Price": "40.00",
      "Category": "Shoes"
    },
    {
      "Image": "assets/images/shirt2.jpg",
      "Title": "Shirt",
      "Price": "20.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/shoe6.jpg",
      "Title": "Sneakers",
      "Price": "40.00",
      "Category": "Shoes"
    },
    {
      "Image": "assets/images/9.jpg",
      "Title": "Sweater",
      "Price": "40.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/shirt1.jpg",
      "Title": "Blue Shirt",
      "Price": "40.00",
      "Category": "Clothing"
    },
    {
      "Image": "assets/images/dress2.jpg",
      "Title": "Dress",
      "Price": "40.00",
      "Category": "Clothing"
    },
  ];
  final List _favItems = [];
  final List _cart = [];
  File? _imageFile;
  bool _isLoading = false;

  get items => _items;

  get favItems => _favItems;

  get cart => _cart;

  get imageFile => _imageFile;

  get isLoading => _isLoading;

  void setIsLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  void setImageFile(newFile) {
    if (newFile != null) {
      _imageFile = File(newFile);
    } else {
      _imageFile = null;
    }
    notifyListeners();
  }

  void setFavItem(obj) {
    if (!_favItems.contains(obj)) {
      _favItems.add(obj);
    } else {
      _favItems.remove(obj);
    }
    notifyListeners();
  }

  void addToCart(obj) {
    _cart.add(obj);
    notifyListeners();
  }
}
