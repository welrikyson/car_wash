import 'package:car_wash/app/shared/models/consumer_model.dart';
import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/washer_model.dart';
import 'package:car_wash/app/shared/utils/color_extensions.dart';
import 'package:car_wash/app/shared/models/product_model.dart';

class WashModel {
  VehicleModel vehicle;
  VehicleKind _vehicleKind;
  WashKind _kind;
  String description;
  WasherModel washer;
  double valueAjusted;
  String phone;
  ConsumerModel consumer;  

  set vehicleKind(VehicleKind currentVehicleKind) {
    _vehicleKind = currentVehicleKind;    
    tryRefreshPrice();    
  }

  get vehicleKind{
    return _vehicleKind;
  }

  set kind(WashKind currentKind) {
    _kind = currentKind;    
    tryRefreshPrice();    
  }

  get kind{
    return _kind;
  }




  WashModel(
      {this.vehicle,
      VehicleKind vehicleKind,
      this.washer,
      this.description,
      WashKind kind,
      this.valueAjusted,
      this.consumer,
      this.phone}){
        this.vehicleKind = vehicleKind;
        this.kind = kind;
      }

  Map<String, dynamic> toJson() {
    final product = ProductModel.of(_kind, _vehicleKind);
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

  void tryRefreshPrice() {
    if(_vehicleKind != null && _kind != null){
      valueAjusted = ProductModel.of(_kind, _vehicleKind).price;
    }
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

