import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/models/categorie.dart';
import 'package:store/providers/categorie_provider.dart';
import 'package:store/screens/categorie_product_screen.dart';
import 'package:store/services/categories_service.dart';
import 'package:store/utils/category_icons.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(
          top: 35,
          left: 15,
          right: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                CloseButton(),
              ],
            ),
            const Text('Categories'),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: CategoriesService().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading categories'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories found'));
                  } else {
                    final categories = snapshot.data!;
                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          leading: Icon(
                              categoryIcons[category.name] ?? Icons.category),
                          title: Text(category.name),
                          onTap: () {
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .category = category.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductsScreen()),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
