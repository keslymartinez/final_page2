/*import 'package:compu_movil_3/presentation/widgets/product_list_rest.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ProductoProvider extends ChangeNotifier {
  String APIUSER = 'test';
  String APIKEY = 'test2023';
  String BASEURL = '143.198.118.203:8100';
  List<Listado> ListadoProducto = [];


 
 ProductoProvider() {
  getProducto();
 }

getProducto() async {
  var url = Uri.http(BASEURL,'ejemplos/product_list_rest/');
  String basicAuth = 'Basic ${base64Encode(utf8.encode('$APIUSER:$APIKEY'))}';
  final response = await http.get(url, headers: {'authorization': basicAuth});
  final Map<String, dynamic> dataDecode = json.decode(response.body);
  final product_list_rest = ProductListRest.fromJson(dataDecode);
  ListadoProducto = product_list_rest.listado;
  print(dataDecode);
  notifyListeners();

}
}
*/