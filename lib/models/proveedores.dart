import 'dart:convert';


class Proveedor {
    Proveedor({
      required this.listProveedores,
    });

  List<ListProveedores>listProveedores;
    
    factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

    factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
      listProveedores:
       List<ListProveedores>.from(json["ListProveedores"].map((x) => Proveedor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ListProveedores": List<dynamic>.from(listProveedores.map((x) => x.toMap())),
    };
}

  class ListProveedores {
    ListProveedores({
        required this.providerId,
        required this.providerName,
        required this.providerLastName,
        required this.providerMail,
        required this.providerState,
     
    });

    int providerId;
    String providerName;
    String providerLastName;
    String providerMail;
    String providerState;

    factory ListProveedores.fromJson(String str) => ListProveedores.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());

    factory ListProveedores.fromMap(Map<String, dynamic> json) => ListProveedores(
      providerId: json["provider_id"],
        providerName: json["provider_name"],
        providerLastName: json["provider_last_name"],
        providerMail: json["provider_mail"],
        providerState: json["product_state"],
       
    );

    Map<String, dynamic> toMap() => {
          "provider_id": providerId,
        "provider_name": providerName,
        "provider_last_name": providerLastName,
        "provider_mail": providerMail,
        "provider_state": providerState,
    };
    ListProveedores copy() => ListProveedores(
      providerId: providerId,
      providerName: providerName,
      providerLastName: providerLastName,
      providerMail: providerMail,
      providerState: providerState,
     );
    
}
  