import 'package:flutter/widgets.dart';
import 'package:store/models/product.dart';

class ProductProvider extends ChangeNotifier {
  //stocker un produit
  Product? _prodcut;

  // getter / setter
  Product? get product => _prodcut;

  set product(Product? value) {
    _prodcut = value;
    //notifyListeners : permet de mettre a jour le secouteurs du provider
    notifyListeners();
  }
}
