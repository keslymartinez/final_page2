import 'dart:convert';

import 'package:compu_movil_3/models/proveedores.model.dart';

ProviderListModel providerModelFromJson(String str) => ProviderListModel.fromJson(json.decode(str));

String providerListModelToJson(ProviderListModel data) => json.encode(data.toJson());

class ProviderListModel {
    List<ProviderModel> listProveedores;

    ProviderListModel ({
        required this.listProveedores,
    });

    factory ProviderListModel.fromJson(Map<String, dynamic> json) => ProviderListModel(
        listProveedores: List<ProviderModel>.from(json["ListProveedores"].map((x) => ProviderModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ListProveedores": List<dynamic>.from(listProveedores.map((x) => x.toJson())),
    };
}
