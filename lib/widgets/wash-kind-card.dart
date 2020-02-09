import 'package:car_wash/models/wash-kind.dart';
import 'package:car_wash/widgets/reusable_card.dart';
import 'package:flutter/material.dart';

const Map<WashKind,List> vehicleKindCards = {
    WashKind.simple: ["Simples",Icons.directions_car],
    WashKind.wax: ["Cera",Icons.motorcycle],
    WashKind.full: ["Completa",Icons.directions_railway],    
};

 ReusableCard fromKind({WashKind washKind,Color color, Function(WashKind) onTap}){
    final values = vehicleKindCards[washKind];
    final title = values[0];
    final icon = values[1];
    return ReusableCard(icon: icon,labelText: title,color: color,onTap: (){onTap(washKind);},);
  }
