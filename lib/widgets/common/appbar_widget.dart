import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/screens/cart_screen.dart'; // Importer l'écran du panier

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Store',
        style: TextStyle(
          color: Color.fromARGB(255, 17, 76, 240),
          fontSize: 25,
          fontFamily: 'police_1',
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Ouvrir l'écran du panier lorsque l'utilisateur clique sur l'icône du panier
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          icon: const Icon(Icons.shopping_cart_checkout_sharp),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
