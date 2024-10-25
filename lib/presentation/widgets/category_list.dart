import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {

    final bgColor = Theme.of(context).colorScheme.primary;
    final textColor = Theme.of(context).colorScheme.onPrimary;

    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 60, 
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: ElevatedButton(
              onPressed: () {
                final category = productProvider.categories[index];
                productProvider.filterProductsByCategory( category );

                // Navegar a la pantalla de búsqueda
                navigateTo( context, AppRoutes.search );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: bgColor,
                foregroundColor: textColor,
              ),
              child: Text(productProvider.categories[index]),
            ),
          );
        },
      ),
    );
  }
}