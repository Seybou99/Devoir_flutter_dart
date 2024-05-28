import 'package:flutter/material.dart';
import 'package:store/widgets/common/appbar_widget.dart';
import 'package:store/widgets/product-details/product_details_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      Scaffold permet l'architecturer l'application 
      body : définir le contenu ppl de l'écran 
      Appbar : barre de navigation 
      Drawer : menu coulissant 
      FloatingButton : bouton flottant ...
    */
    return const Scaffold(
      appBar: AppbarWidget(),
/*       drawer: DrawerWidget(),
 */
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsWidget(),
          ],
        ),
      ),
    );
  }
}
