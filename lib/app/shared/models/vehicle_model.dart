import 'dart:convert';
import 'dart:ui';

import 'package:car_wash/app/shared/models/consumer_model.dart';

class VehicleModel {
  final int id;
  final String  plate;
  final String name;
  final Color color;
  final ConsumerModel consumer;

  VehicleModel({this.id, this.color, this.plate, this.name,this.consumer});
  factory VehicleModel.fromJson(Map<String, dynamic> json) => new VehicleModel(
        plate: json["placa"],
        name: json["descricao"],
        id: int.parse(json["id_veiculo"]),
        consumer: json["id_cliente"] == null ? null :ConsumerModel( 
          id: int.tryParse((json["id_cliente"])),
          name: json["nome_cliente"],
          phone: json["fone_contato"],
          )
      );

  Map<String, dynamic> toJson() => {
        "descricao": name,
        "placa": plate,
      };

      static List<VehicleModel> fromJsonList(List list){
      if(list == null) return null;
      return list
        .map((item) => VehicleModel.fromJson(item))
        .toList();
    }
}

VehicleModel vehicleFromJson(String str) => VehicleModel.fromJson(json.decode(str));

String washKindToJson(VehicleModel data) => json.encode(data.toJson());

enum VehicleKind {
  car,
  motorcycle,  
  pickup,
  truck,  
}