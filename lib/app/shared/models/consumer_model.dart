import 'dart:convert';

class ConsumerModel {
  final int id;
  final String name;
  final String contact;
  final String phone;

  ConsumerModel({this.id,this.name,this.phone,this.contact});

  factory ConsumerModel.fromJson(Map<String, dynamic> json) => new ConsumerModel(
        name: json["descricao"],
        id: int.parse(json["id_cliente"]),
        phone: json["fone"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "descricao": name,
        "id": id,
        "fone": phone,
        "contato":contact,
      };

      static List<ConsumerModel> fromJsonList(List list){
      if(list == null) return null;
      return list
        .map((item) => ConsumerModel.fromJson(item))
        .toList();
    }
}

ConsumerModel washKindFromJson(String str) => ConsumerModel.fromJson(json.decode(str));

String washKindToJson(ConsumerModel data) => json.encode(data.toJson());