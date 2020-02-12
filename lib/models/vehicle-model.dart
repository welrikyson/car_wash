import 'dart:convert';

import 'package:car_wash/models/client-model.dart';
import 'package:flutter/cupertino.dart';

class Vehicle {
  final int id;
  final String  plate;
  final String name;
  final Color color;
  final ClientModel client;

  Vehicle({this.id, this.color, this.plate, this.name,this.client});
  factory Vehicle.fromJson(Map<String, dynamic> json) => new Vehicle(
        plate: json["placa"],
        name: json["descricao"],
        id: int.parse(json["id_veiculo"]),
        client: ClientModel( 
          id: int.parse(json["id_cliente"]),
          name: json["nome_cliente"],
          phone: json["fone_contato"],
          )
      );

  Map<String, dynamic> toJson() => {
        "descricao": name,
        "placa": plate,
      };

      static List<Vehicle> fromJsonList(List list){
      if(list == null) return null;
      return list
        .map((item) => Vehicle.fromJson(item))
        .toList();
    }
}

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));

String washKindToJson(Vehicle data) => json.encode(data.toJson());