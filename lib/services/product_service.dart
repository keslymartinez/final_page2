import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:compu_movil_3/models/product.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _password = 'test2023';

  List<Listado> products = [];
  Listado? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final productsMap = Product.fromJson(response.body);
  
    products = productsMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Listado product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await this.createProduct(product);
    } else {
      await this.updateProduct(product);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProduct(Listado product) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_edit_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //aqui se actualiza el listado
    final index = products
        .indexWhere((element) => element.productId == product.productId);
    products[index] = product;
    return '';
  }

  Future createProduct(Listado product) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.products.add(product);
    return '';
  }

  Future deleteProducts(Listado product, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_del_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: product.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.products.clear();
    loadProducts();
    Navigatior.of(context).pushNamed('list');
    return '';
  }


}

class Navigatior {
  static of(BuildContext context) {}
}
