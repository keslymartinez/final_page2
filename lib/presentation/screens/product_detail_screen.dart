import 'package:compu_movil_3/entities/product_entity.dart';
import 'package:compu_movil_3/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {

  const ProductDetailScreen({
    super.key, 

  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    
    final String productID = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del producto'),
      ),
      body: FutureBuilder(
        future: productProvider.getProductById( productID ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ProductDetail(product: snapshot.data);
          }
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  
  final ProductEntity? product;
  
  const ProductDetail({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagen del producto
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product!.imageUrl ?? 'https://via.placeholder.com/300',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
    
          // Nombre del producto
          Text(
            product!.name,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
    
          // Precio del producto
          Text(
            '\$${product!.price}',
            style: const TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 228, 231, 230),
            ),
          ),
          const SizedBox(height: 15),
    
          // Descripción del producto
          Text(
            product!.description ?? 'Producto sin descripción.',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const Spacer(),
    
          // Botón "Añadir al carrito"
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                // primary: Color(0xFF1E88E5), // Color azul
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Añadir al carro',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
