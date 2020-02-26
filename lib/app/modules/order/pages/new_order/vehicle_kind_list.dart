import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

const Map<VehicleKind, List> vehicleKindCards = {
  VehicleKind.car: ["Carro", Icons.directions_car],
  VehicleKind.motorcycle: ["Moto", Icons.motorcycle],
  VehicleKind.pickup: ["Utilitario", CommunityMaterialIcons.car_pickup],
  VehicleKind.truck: ["Caminhão", CommunityMaterialIcons.truck]
};