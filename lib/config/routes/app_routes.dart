

import 'package:compu_movil_3/presentation/screens/auth/auth_screen.dart';
import 'package:compu_movil_3/presentation/screens/error_screen.dart';
import 'package:compu_movil_3/presentation/screens/home_screen.dart';
import 'package:compu_movil_3/presentation/screens/product_detail_screen.dart';
import 'package:compu_movil_3/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';

/*

  Cómo agregar una nueva ruta:
  1. Agregar la ruta en appRoutes. /nombre-ruta: ( context ) => const Screen(),
  2. Añadir la ruta al enum AppRoutes, para facilitar su uso en el código
  3. Añadir la ruta al mapa de la función getRoutes. AppRoute: '/nombre-ruta'

  Cómo navegar a una ruta:
  1. Desde cualquier parte de la app, invocar navigateTo( context, AppRoutes.nombreRuta )

*/


// Rutas de la aplicación
final Map<String, Widget Function( BuildContext )> appRoutes = {

  '/home': ( context ) => const HomeScreen(),
  '/auth': ( context ) => const AuthScreen(),
  '/product-detail': ( context ) => const ProductDetailScreen(),
  '/search': ( context ) => const SearchScreen(),
  '/404': ( context ) => const Text('404 Not Found'),

};


enum AppRoutes {
  auth,
  home,
  onGenerateRoute,
  productDetail,
  search,
}


Route<dynamic> onGenerateRoute(RouteSettings settings) {
  if (settings.name == '/product-detail') {
    // final String productId = settings.arguments as String;
    return MaterialPageRoute(
      builder: (context) {
        return const ProductDetailScreen();
      },
    );
  }

  return MaterialPageRoute(
    builder: (context) => const ErrorScreen(), 
  );
}

// Función para obtener la ruta de una pantalla a partir de un enum
String getRoute( AppRoutes route ) {
  final Map<AppRoutes, String> routes = {
    AppRoutes.home: '/home',
    AppRoutes.auth: '/auth',
    AppRoutes.productDetail: '/product-detail',
    AppRoutes.search: '/search',
  };
  
  return routes[ route ] ?? '/404';
}

// Funciones de navegación
void navigateTo( BuildContext context, AppRoutes route ) {
  Navigator.pushNamed( context, getRoute( route ) );
}


// Navega a la pantalla del producto con el id especificado
void navigateToProductDetail( BuildContext context, String productId ) {
  Navigator.pushNamed(
    context,
    getRoute( AppRoutes.productDetail ),
    arguments: productId,
  );
}


void navigateBack( BuildContext context ) {
  Navigator.pop( context );
}