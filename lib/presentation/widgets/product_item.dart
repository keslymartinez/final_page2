import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {

  final String productId;
  final String productName;
  final int price;
  final String? imageUrl;

  const ProductItem({
    super.key,
    required this.productId,
    required this.productName,
    required this.price,
    this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    final Color color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return SizedBox(
      width: 250,
      child: Card(
        color: color, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Center(
                child: Image.network(
                  imageUrl ?? 'https://via.placeholder.com/150',
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
      
              // Nombre del producto
              Text(
                productName,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
      
              // Precio del producto
              Text(
                '\$$price',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 15),

              // Botón
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    navigateToProductDetail( context, productId );
                  },
                  child: const Text('Ver detalles'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}