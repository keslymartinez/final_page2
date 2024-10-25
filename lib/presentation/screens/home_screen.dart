import 'package:compu_movil_3/config/routes/app_routes.dart';
import 'package:compu_movil_3/presentation/providers/product_provider.dart';
// import 'package:compu_movil_3/presentation/screens/product_detail_screen.dart';
import 'package:compu_movil_3/presentation/widgets/category_list.dart';
import 'package:compu_movil_3/presentation/widgets/product_list.dart';
import 'package:compu_movil_3/presentation/widgets/searcher.dart';
import 'package:compu_movil_3/presentation/widgets/user_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final listado = Provider.of<ProductoProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.store),
        title: const Text('Store'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.account_circle),
            itemBuilder: ( context ) => [
              const PopupMenuItem(
                value: 'logout',
                child: UserStatus(),
              )
            ]
          )
        ]
      ),
      
      body: ListView(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Searcher( onSubmit: ( String searchedTerm ){
              productProvider.searchProducts( searchedTerm );
              navigateTo(context, AppRoutes.search);
            }),
          ),

          // Categorías
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Busca por categoria',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const CategoryList(),
          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Podrían interesarte...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ProductList( products: productProvider.products ),


        ]
      ),
    );
  
  }
}

