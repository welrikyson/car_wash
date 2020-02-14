import 'package:car_wash/models/wash-kind.dart';
import 'package:car_wash/widgets/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

const Map<WashKind,List> vehicleKindCards = {
    WashKind.simple: ["Simples",CommunityMaterialIcons.shower_head],
    WashKind.wax: ["Cera",CommunityMaterialIcons.pinwheel_outline],
    WashKind.full: ["Completa",CommunityMaterialIcons.car_wash],    
    WashKind.diesel: ["Diesel",Icons.local_gas_station],  
    WashKind.caminhaoP: ["Pequeno",CommunityMaterialIcons.truck,20.0],
    WashKind.caminhaoM: ["Médio",CommunityMaterialIcons.truck,30.0],    
    WashKind.caminhaoG: ["Grande",CommunityMaterialIcons.truck,40.0],    
};

 ReusableCard fromKind({WashKind washKind,Color color, Function(WashKind) onTap}){
    final values = vehicleKindCards[washKind];
    final title = values[0];
    final icon = values[1];
    final size = values.length > 2? values[2]: 40.0;
    return ReusableCard(icon: icon,labelText: title,color: color,onTap: (){onTap(washKind);},size: size,);
  }
