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

  String get valueCurrent{
    if(this.vehicleKind == null || this.kind == null){
      return "R\$ 0,00";
    }
    final product = value[this.vehicleKind.index][this.kind.index];
    return "R\$ ${product.value.replaceAll('.', ',')}";
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
    final product = value[this.vehicleKind.index][this.kind.index];
    return {
      "tipoLavagem": product.id, //id do produto
      "lavagem": product.description, //
      "precoProduto": product.value, //preco original da lavegem

      "cliente": client.id, //id cliente
      "clienteNome": client.name, //
      "clienteFone": client.phone, //

      "veiculo": vehicle.id, //id veiculo
      "veiculoPlaca": vehicle.plate, //
      "veiculoDescricao": vehicle.name,
      "veiculoCor": vehicle.color, //

      "lavador": washer.id, //id lavador
      "lavadorDescricao": washer.nome, //

      //MEtadados do sistema
      "valorLavagem": valueAjusted, //valor da lavagem alterado
      "flagInsertVeiculo": description, //sinaliza se e novo veiculo
    };
  }  
}
String washModelToJson(Vehicle data) => json.encode(data.toJson());

final value = [
  [
    Product(1, "LAV SIMPLES - PASSEIO", "25.00"),
    Product(7, "LAV SIMPLES - MOTO", "20.00"),
    Product(4, "LAV SIMPLES - UTILITARIO", "40.00"),
    Product(9, "LAV SIMPLES - CAMINHAO", "120.00"),
  ],
  [
    Product(2, "LAV SIMPLES C/ CERA - PASSEIO", "35.00"),
    Product(8, "LAV SIMPLES C/ CERA - MOTO", "30.00"),
    Product(5, "LAV SIMPLES C/ CERA - UTILITARIO", "50.00"),
    Product(10, "LAV SIMPLES C/ CERA - CAMINHAO", "120.00"),
  ],
  [
    Product(3, "LAV GERAL - PASSEIO", "60.00"),
// values[2][1] = Product(1,"LAV GERAL - MOTO","");,
    Product(6, "LAV GERAL - UTILITARIO", "70.00"),
    Product(11, "LAV GERAL - CAMINHAO", "200.00"),
  ],
  [
    Product(1, "LAV C/ DIESEL - PASSEIO", ""),
    Product(1, "LAV C/ DIESEL - MOTO", ""),
    Product(1, "LAV C/ DIESEL - UTILITARIO", ""),
    Product(1, "LAV C/ DIESEL - CAMINHAO", ""),
  ],
];

class Product {
  int id;
  String description;
  String value;

  Product(this.id, this.description, this.value);
}
