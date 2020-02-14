import 'dart:convert';

import 'package:car_wash/models/client-model.dart';
import 'package:car_wash/models/vehicle-kind.dart';
import 'package:car_wash/models/vehicle-model.dart';
import 'package:car_wash/models/wash-kind.dart';
import 'package:car_wash/models/washer-model.dart';

class WashModel {
  
  Vehicle vehicle;
  VehicleKind vehicleKind;
  WashKind kind;
  String description;
  WasherModel washer;
  String valueAjusted;
  String phone;

  double get valueCurrent{
    if(this.vehicleKind == null || this.kind == null){
      return 0.0;
    }
    final product = value[this.kind.index][this.vehicleKind.index];
    return product.value;
  }
  //lavador
  ClientModel client;
  //

  WashModel(
      {this.vehicle,
      this.vehicleKind,
      this.washer,
      this.description,
      this.kind,
      this.valueAjusted,
      this.client,
      this.phone});

  Map<String, dynamic> toJson() {
    final product = value[this.kind.index][this.vehicleKind.index];
    return {
      "tipoLavagem": product.id, //id do produto
      "lavagem": product.description, //
      "precoProduto": product.value, //preco original da lavegem

      "cliente": client.id, //id cliente
      "clienteNome": client.name, //
      "clienteFone": phone.replaceAll('-', ''), //

      "veiculo": vehicle.id, //id veiculo
      "veiculoPlaca": vehicle.plate, //
      "veiculoDescricao": vehicle.name,
      "veiculoCor": vehicle.color, //

      "lavador": washer?.id ?? null, //id lavador
      "lavadorDescricao": washer?.nome ?? null, //

      //MEtadados do sistema
      "valorLavagem": valueAjusted, //valor da lavagem alterado
      "flagInsertVeiculo": description, //sinaliza se e novo veiculo
    };
  }  
}
String washModelToJson(Vehicle data) => json.encode(data.toJson());

final value = [
  [
    Product(1, "LAV SIMPLES - PASSEIO", 25.00),
    Product(7, "LAV SIMPLES - MOTO", 20.00),
    Product(4, "LAV SIMPLES - UTILITARIO", 40.00),
    null,
  ],
  [
    Product(2, "LAV SIMPLES C/ CERA - PASSEIO", 35.00),
    Product(8, "LAV SIMPLES C/ CERA - MOTO", 30.00),
    Product(5, "LAV SIMPLES C/ CERA - UTILITARIO", 50.00),    
    null,
  ],
  [
    Product(3, "LAV GERAL - PASSEIO", 60.00),
    Product(16, "LAV GERAL - MOTO", 60.00),   
    Product(6, "LAV GERAL - UTILITARIO", 70.00),    
    null,
  ],
  [
    Product(1, "LAV C/ DIESEL - PASSEIO", 30.0),
    Product(1, "LAV C/ DIESEL - MOTO", 0.0),
    Product(1, "LAV C/ DIESEL - UTILITARIO", 50.0),
    null,
  ],
  [
    null,
    null,
    null,
    Product(4, "CAMINHAO PEQUENO", 120.0),    
  ],
  [
    null,
    null,
    null,
    Product(2, "CAMINHAO MÉDIO", 150.0),    
  ],
  [
    null,
    null,
    null,
    Product(4, "CAMINHAO GRANDE", 200.0),    
  ],

];

class Product {
  int id;
  String description;
  double value;

  Product(this.id, this.description, this.value);
}
