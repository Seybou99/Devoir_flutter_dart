import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:store/models/categorie.dart';

class CategoriesService {
  Future<List<Category>> getCategories() async {
    Uri uri = Uri.parse('https://fakestoreapi.com/products/categories');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Echec de chargeemnt des categories');
    }
  }
}
