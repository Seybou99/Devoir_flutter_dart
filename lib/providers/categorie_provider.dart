import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String? _category;

  String? get category => _category;

  set category(String? value) {
    _category = value;
    notifyListeners();
  }
}
