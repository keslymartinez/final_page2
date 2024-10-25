import 'package:compu_movil_3/models/proveedores.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ProvedorService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _password = 'test2023';

  List<ListProveedores> proveedores = [];
  ListProveedores? SelectProverdores;
  bool isLoading = true;
  bool isEditCreate = true;

  ProvedorService() {
    loadProveedores();
  }
  Future loadProveedores() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/product_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final proveedoresMap = Proveedor.fromJson(response.body);
  
    proveedores = proveedoresMap.listProveedores;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(ListProveedores proveedor) async {
    isEditCreate = true;
    notifyListeners();
    if (proveedor.providerId == 0) {
      await this.createProduct(proveedor as Proveedor);
    } else {
      await this.updateProduct(proveedor);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateProduct(ListProveedores proveedor) async {
    final url = Uri.http(
      _baseUrl,
      '/provider_edit_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //aqui se actualiza el listado
    final index = proveedores
        .indexWhere((element) => element.providerId == proveedor.providerId);
    proveedores[index] = proveedor;
    return '';
  }

  Future createProduct(Proveedor proveedor) async {
    final url = Uri.http(
      _baseUrl,
      '/provider_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedores.add(proveedor as ListProveedores);
    return '';
  }

  Future deleteProducts(ListProveedores proveedor, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      '/provider_del_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_user:$_password'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedores.clear();
    loadProveedores();
    Navigatior.of(context).pushNamed('list');
    return '';
  }

}

class Navigatior {
  static of(BuildContext context) {}
}
