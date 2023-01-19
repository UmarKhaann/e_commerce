import 'dart:io';

import 'package:flutter/foundation.dart';

class ItemsProvider with ChangeNotifier {

  final List _cart = [];
  File? _imageFile;
  bool _isLoading = false;

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

  void addToCart(obj) {
    if(_cart.contains(obj)){
      return;
    }else{
      _cart.add(obj);
    }

    notifyListeners();
  }

  void removeFromCart(obj){
    _cart.remove(obj);
    notifyListeners();
  }
}
