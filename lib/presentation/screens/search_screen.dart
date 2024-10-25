import 'package:compu_movil_3/presentation/providers/product_provider.dart';
import 'package:compu_movil_3/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(productProvider.searchedWord),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Resultados de la búsqueda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runSpacing: 10,
            spacing: 10,
            children: [
              for (final product in productProvider.searchedProducts)
                ProductItem(
                  productId: product.id,
                  productName: product.name,
                  price: product.price,
                  imageUrl: product.imageUrl,
                ),

              const SizedBox(width: double.infinity, height: 30),
            ],
          ),
        ]
      ),
    );
  }
}