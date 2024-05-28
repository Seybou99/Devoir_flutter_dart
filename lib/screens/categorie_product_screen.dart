import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/categorie_provider.dart';
// import 'package:store/providers/category_provider.dart';
import 'package:store/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store/providers/product_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<List<Product>> fetchProducts(String category) async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context).category;

    return Scaffold(
      appBar: AppBar(
        title: Text(category ?? 'Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Ajout du padding total
        child: FutureBuilder<List<Product>>(
          future: fetchProducts(category!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products found'));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        // Centrer le texte du prix
                        child: Text(
                          '\$${product.price}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            //read : ecrire (setter) /mettre a jour les proprietes product de ProductProvider
                            context.read<ProductProvider>().product = product;
                            /* 
              naviguer vers un ecran
              context :  ecran en cours d'affichage
             */
                            context.pushNamed('product-details');
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            side: BorderSide.none,
                            shape: const BeveledRectangleBorder(),
                          ),
                          child: const Text('View'),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
