import 'dart:convert';

class WasherModel {
  final int id;
  final String nome;
  WasherModel({this.id, this.nome});
  factory WasherModel.fromJson(Map<String, dynamic> json) => new WasherModel(
        nome: json["descricao"],
        id: int.parse(json["id_funcionario"]),
      );

  Map<String, dynamic> toJson() => {
        "id_funcionario": id,
        "descricao": nome,
      };

  static List<WasherModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => WasherModel.fromJson(item)).toList();
  }
}

WasherModel vehicleFromJson(String str) =>
    WasherModel.fromJson(json.decode(str));

String washKindToJson(WasherModel data) => json.encode(data.toJson());
