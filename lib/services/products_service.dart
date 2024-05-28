import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/config/config.dart';
import 'package:store/models/product.dart';

class ProductsService {
  //Recuperer tout les produits

  Future<List<Product>> getProducts() async {
    //requete en GET
    Uri uri = Uri.parse('${Config.API_URL}/products');
    http.Response response = await http.get(uri);

    //recupere rla reponses
    if (response.statusCode == 200) {
      //convertir les données en json
      List data = jsonDecode(response.body);

      //renvoyer une liste d'objet
      return data
          .map(
            (dynamic value) => Product(
                id: value['id'],
                title: value['title'],
                price: value['price'],
                description: value['description'],
                category: value['category'],
                image: value['image'],
                rating: value['rating']),
          )
          .toList();
    } else {
      throw Error();
    }
  }
}
