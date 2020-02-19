import 'dart:convert';

class ClientModel {
  final int id;
  final String name;
  final String phone;

  ClientModel({this.id,this.name,this.phone});

  factory ClientModel.fromJson(Map<String, dynamic> json) => new ClientModel(
        name: json["descricao"],
        id: int.parse(json["id_cliente"]),
        phone: json["fone"],
      );

  Map<String, dynamic> toJson() => {
        "descricao": name,
        "id": id,
        "fone": phone,
      };

      static List<ClientModel> fromJsonList(List list){
      if(list == null) return null;
      return list
        .map((item) => ClientModel.fromJson(item))
        .toList();
    }
}

ClientModel washKindFromJson(String str) => ClientModel.fromJson(json.decode(str));

String washKindToJson(ClientModel data) => json.encode(data.toJson());