import 'dart:io';

import 'package:flutter/foundation.dart';

class ItemsProvider with ChangeNotifier {

  File? _imageFile;
  bool _isLoading = false;
  Map _cartValues = {};

  get cartValues => _cartValues;
  get imageFile => _imageFile;
  get isLoading => _isLoading;

  void setCartValues(index, newValue){
    if(!cartValues.containsKey(index)){
      _cartValues[index] = newValue;
    }
    notifyListeners();
  }

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
  //
  // void addToCart(obj) {
  //   if(_cart.contains(obj)){
  //     return;
  //   }else{
  //     _cart.add(obj);
  //   }
  //
  //   notifyListeners();
  // }
  //
  // void removeFromCart(obj){
  //   _cart.remove(obj);
  //   notifyListeners();
  // }
}
