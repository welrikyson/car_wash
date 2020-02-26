import 'package:car_wash/app/shared/models/consumer_model.dart';
import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/washer_model.dart';
import 'package:car_wash/app/shared/utils/color_extensions.dart';
import 'package:car_wash/app/shared/models/product_model.dart';

class WashModel {
  VehicleModel vehicle;
  VehicleKind vehicleKind;
  WashKind kind;
  String description;
  WasherModel washer;
  String valueAjusted;
  String phone;
  ConsumerModel consumer;  
  WashModel(
      {this.vehicle,
      this.vehicleKind,
      this.washer,
      this.description,
      this.kind,
      this.valueAjusted,
      this.consumer,
      this.phone});

  Map<String, dynamic> toJson() {
    final product = ProductModel.of(kind, vehicleKind);
    return {
      "tipoLavagem": product.id, //id do produto
      "lavagem": product.description, //
      "precoProduto": product.price, //preco original da lavegem

      "cliente": consumer.id, //id cliente
      "clienteNome": consumer.name, //
      "clienteFone": phone.replaceAll('-', ''), //

      "veiculo": vehicle.id, //id veiculo
      "veiculoPlaca": vehicle.plate, //
      "veiculoDescricao": vehicle.name,
      "veiculoCor": vehicle.color?.toHex(false) ?? null, //

      "lavador": washer?.id ?? null, //id lavador
      "lavadorDescricao": washer?.nome ?? null, //

      //MEtadados do sistema
      "valorLavagem": valueAjusted, //valor da lavagem alterado
      "flagInsertVeiculo": description, //sinaliza se e novo veiculo
    };
  }

}

enum WashKind{
  simple,
  wax,
  diesel,
  full,  
  caminhaoP,
  caminhaoM,
  caminhaoG,
}

