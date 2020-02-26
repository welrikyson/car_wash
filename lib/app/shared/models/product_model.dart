import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/wash_model.dart';

//TODO: remove this region for oder class/file/partial
//#region Test 
const washSimple = "LAV SIMPLES";
const washSimpleWithWax = "$washSimple C/ CERA";
const washSimpleWitDiesel = "$washSimple C/ DIESEL";
const washFull = "LAV GERAL";
const car = "PASSEI0";
const motorcycle = "MOTO";
const pickup = "UTILITARIO";

final productsMap = {
  WashKind.simple: {
    VehicleKind.car:
        ProductModel._(id: 1, description: "$washSimple - $car", price: 25.00),
    VehicleKind.motorcycle: ProductModel._(
        id: 7, description: "$washSimple - $motorcycle", price: 20.00),
    VehicleKind.pickup: ProductModel._(
        id: 4, description: "$washSimple - $pickup", price: 40.00),
  },
  WashKind.wax: {
    VehicleKind.car: ProductModel._(
        id: 2, description: "$washSimpleWithWax - $car", price: 35.00),
    VehicleKind.motorcycle: ProductModel._(
        id: 8, description: "$washSimpleWithWax - $motorcycle", price: 30.00),
    VehicleKind.pickup: ProductModel._(
        id: 5, description: "$washSimpleWithWax - $pickup", price: 50.00),
  },
  WashKind.full: {
    VehicleKind.car:
        ProductModel._(id: 3, description: "$washFull - $car", price: 60.00),
    VehicleKind.motorcycle: ProductModel._(
        id: 8, description: "$washFull - $motorcycle", price: 30.00),
    VehicleKind.pickup:
        ProductModel._(id: 6, description: "$washFull - $pickup", price: 70.00),
  },
  WashKind.diesel: {
    VehicleKind.car: ProductModel._(
        id: 31, description: "$washSimpleWitDiesel - $car", price: 30.0),
    VehicleKind.motorcycle: ProductModel._(
        id: 33, description: "$washSimpleWitDiesel - $motorcycle", price: 30.0),
    VehicleKind.pickup: ProductModel._(
        id: 32, description: "$washSimpleWitDiesel - $pickup", price: 50.0),
  },
  WashKind.caminhaoP: {
    VehicleKind.truck:
        ProductModel._(id: 9, description: "LAV CAMINHAO PQ", price: 120.0),
  },
  WashKind.caminhaoM: {
    VehicleKind.truck:
        ProductModel._(id: 10, description: "LAV CAMINHAO MD", price: 150.0),
  },
  WashKind.caminhaoG: {
    VehicleKind.truck:
        ProductModel._(id: 11, description: "LAV CARRETA", price: 200.0),
  },
};
//#endregion Test


class ProductModel {
  final int id;
  final String description;
  final double price;

  ProductModel._({this.id, this.description, this.price});
  
  static ProductModel of(WashKind washKind, VehicleKind vehicleKind) {
    //TODO: try cath if no valid index
    return productsMap[washKind][vehicleKind];
  }
}
