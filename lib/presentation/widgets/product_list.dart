import 'package:compu_movil_3/entities/product_entity.dart';
import 'package:compu_movil_3/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  
  final List<ProductEntity> products;
  
  const ProductList({
    super.key,
    required this.products,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItem(
            productId: product.id,
            productName: product.name,
            price: product.price,
            imageUrl: product.imageUrl,
          );
        },
      ),
    );
  }
}