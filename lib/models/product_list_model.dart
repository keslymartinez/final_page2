import 'dart:convert';

import 'package:compu_movil_3/models/product_model.dart';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
    List<ProductModel> listado;

    ProductListModel({
        required this.listado,
    });

    factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        listado: List<ProductModel>.from(json["Listado"].map((x) => ProductModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toJson())),
    };
}

