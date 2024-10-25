import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:compu_movil_3/entities/provedores_entity.dart';
import 'package:compu_movil_3/models/provedores.list.model.dart';
import 'package:compu_movil_3/models/proveedores.model.dart';

class ProvedoresProvider extends ChangeNotifier {

  
  List<ProvedorEntity>  proveedores = [
    
  ];

  ProvedoresProvider(){
    getProvedores();
  }

  Future<void> getProvedores() async {
    String APIUSER = 'test';
    String APIKEY = 'test2023';
    String BASEURL = '143.198.118.203:8100';
    List<ProviderModel> proveedoresList = [];

    var url = Uri.http(BASEURL,'/product_list_rest/');
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$APIUSER:$APIKEY'))}';
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final Map<String, dynamic> dataDecode = json.decode(response.body);
    final proveedoresListData = ProviderListModel.fromJson(dataDecode);
    proveedoresList = proveedoresListData.listProveedores;
    print(dataDecode);

    proveedores = proveedoresList.map((proveedores) => ProvedorEntity(
      id: proveedores.providerId.toString(),
      name: proveedores.providerName,
      lastName: proveedores.providerLastName,
      providerMail: proveedores.providerMail,
      providerState: proveedores.providerState,
    )).toList();
  }
}