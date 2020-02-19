import 'package:car_wash/old/models/vehicle-kind.dart';
import 'package:car_wash/shared/widgets/group_select.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class NewOrderWidget extends StatefulWidget {
  @override
  _NewOrderWidgetState createState() => _NewOrderWidgetState();
}

class _NewOrderWidgetState extends State<NewOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Lavagem')),
      body: _buildBordy(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}

const Map<VehicleKind, List> vehicleKindCards = {
  VehicleKind.car: ["Carro", Icons.directions_car],
  VehicleKind.motorcycle: ["Moto", Icons.motorcycle],
  VehicleKind.pickup: ["Utilitario", CommunityMaterialIcons.car_pickup],
  VehicleKind.truck: ["Caminhão", CommunityMaterialIcons.truck]
};
_buildBordy(context) {
  return Form(
    child: ListView(
      padding: EdgeInsets.all(5),
      children: <Widget>[
        GroupSelect(
          items: VehicleKind.values.map((v) {
            print(v.index);
            final valueKind = vehicleKindCards[v];
            return Container(
              child: Column(
                children: <Widget>[
                  Text(valueKind[0]),
                  Icon(valueKind[1]),
                ],
              ),
            );
          }).toList(),
          onSelectChange: (value){
            print('Selected change');
          },
        ),
        TextFormField(
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Cliente",
          ),
          keyboardType: TextInputType.phone,
        ),
        TextFormField(
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Telefone",
            hintText: "99999-99999",
          ),
          keyboardType: TextInputType.phone,
        ),
        TextFormField(
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Observações",
          ),
          keyboardType: TextInputType.multiline,
        ),
        TextFormField(
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Telefone",
            hintText: "99999-99999",
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    ),
  );
}

_buildFloatingActionButton() {
  return FloatingActionButton.extended(
    onPressed: null,
    label: Text('SALVAR'),
    icon: Icon(Icons.save),
  );
}
