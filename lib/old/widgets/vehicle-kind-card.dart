import 'package:car_wash/models/vehicle-kind.dart';
import 'package:car_wash/widgets/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

const Map<VehicleKind,List> vehicleKindCards = {
    VehicleKind.car: ["Carro",Icons.directions_car],
    VehicleKind.motorcycle: ["Moto",Icons.motorcycle],
    VehicleKind.pickup: ["Utilitario",CommunityMaterialIcons.car_pickup],
    VehicleKind.truck: ["Caminhão",CommunityMaterialIcons.truck],
};
class VehicleKindCard extends StatefulWidget {
  final VehicleKind vehicleKind;
  final Color color;
  final Function(VehicleKind vehicleKind) onTap;
  
  VehicleKindCard({Key key, this.vehicleKind, this.color, this.onTap,}) : super(key: key);
  @override
  _VehicleKindCardState createState() => _VehicleKindCardState();
}

class _VehicleKindCardState extends State<VehicleKindCard> {
  String title = "";
  IconData iconData;
  @override
  void initState() {    
    var value = vehicleKindCards[widget.vehicleKind];
    title = value[0];
    iconData = value[1];
    super.initState();
    //
  }
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: widget.color,
      onTap: ()=>widget.onTap(widget.vehicleKind),
      icon: iconData,
      labelText: title,
    );
  }
}