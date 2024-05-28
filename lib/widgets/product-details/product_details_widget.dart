import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/product.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Product? product = context.watch<ProductProvider>().product;

    return Column(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(product!.image)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          product.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          product.price.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .addToCart(product);
          },
          child: const Text('Add to Cart'),
        ),
      ],
    );
  }
}
