import 'dart:convert';
import 'dart:math';

import 'package:compu_movil_3/entities/product_entity.dart';
import 'package:compu_movil_3/models/product_list_model.dart';
import 'package:compu_movil_3/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {

  
  List<ProductEntity> products = [
    
  ];

  ProductProvider(){
    getProducts();
  }

  List<String> categories = [];

  List<ProductEntity> searchedProducts = [];
  String searchedWord = '';


  Future<void> getProducts() async {
    String APIUSER = 'test';
    String APIKEY = 'test2023';
    String BASEURL = '143.198.118.203:8100';
    List<ProductModel> productList = [];

    var url = Uri.http(BASEURL,'ejemplos/product_list_rest/');
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$APIUSER:$APIKEY'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final Map<String, dynamic> dataDecode = json.decode(response.body);
    final productListData = ProductListModel.fromJson(dataDecode);
    productList = productListData.listado;
    print(dataDecode);

    products = productList.map((product) => ProductEntity(
      id: product.productId.toString(),
      name: product.productName,
      description: product.productState,
      price: product.productPrice,
      imageUrl: product.productImage,
      category: getRandomCategory(),
    )).toList();


    
    getCategories();
    notifyListeners();
  }

  Future<void> getCategories() async {
    categories = products.map((product) => product.category).toSet().toList();
    notifyListeners();
  }

  String getRandomCategory() {
    final List<String> categories = ["Electronico", "Computacion", "Oficina"];
    final randomIndex = Random().nextInt( categories.length );

    return categories[ randomIndex ];
  }


  Future<ProductEntity> getProductById( String productId ) async {
    return products.firstWhere(
      (product) => product.id == productId,
      orElse: () => ProductEntity(
        id: '0',
        name: 'Producto no encontrado',
        description: 'No se encontró el producto con el id $productId',
        price: 0,
        category: 'No encontrado'
      ),
    );
  }


  void searchProducts( String searchTerm ) {
    searchedProducts = products.where(
      (product) => product.name.toLowerCase().contains(searchTerm.toLowerCase())
    ).toList();

    searchedWord = searchTerm;

    notifyListeners();
  }

  // Filtra los productos por categoría
  void filterProductsByCategory( String category ) {
    searchedProducts = products.where(
      (product) => product.category == category
    ).toList();

    searchedWord = category;
    notifyListeners();

  }


}