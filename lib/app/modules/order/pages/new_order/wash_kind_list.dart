import 'package:car_wash/app/shared/models/wash_model.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

final Map<WashKind, List> washKindCards = {
  WashKind.simple: ["Simples",CommunityMaterialIcons.shower_head],
    WashKind.wax: ["Cera",CommunityMaterialIcons.pinwheel_outline],
    WashKind.full: ["Completa",CommunityMaterialIcons.car_wash],    
    WashKind.diesel: ["Diesel",Icons.local_gas_station],  
    // WashKind.caminhaoP: ["Pequeno",CommunityMaterialIcons.truck,20.0],
    // WashKind.caminhaoM: ["Médio",CommunityMaterialIcons.truck,30.0],    
    // WashKind.caminhaoG: ["Grande",CommunityMaterialIcons.truck,40.0],    
};