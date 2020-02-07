import 'dart:convert';

class WashKind {
  int id;
  String descricao;
  WashKind({this.id, this.descricao});

  factory WashKind.fromJson(Map<String, dynamic> json) => new WashKind(
        descricao: json["descricao"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "descricao": descricao,
        "id": id,
      };

      static List<WashKind> fromJsonList(List list){
      if(list == null) return null;
      return list
        .map((item) => WashKind.fromJson(item))
        .toList();
    }
}

WashKind washKindFromJson(String str) => WashKind.fromJson(json.decode(str));

String washKindToJson(WashKind data) => json.encode(data.toJson());
