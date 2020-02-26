import 'package:car_wash/app/modules/order/pages/new_order/vehicle_kind_list.dart';
import 'package:car_wash/app/modules/order/pages/new_order/wash_kind_list.dart';
import 'package:car_wash/app/shared/models/product_model.dart';
import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/wash_model.dart';
import 'package:flutter/material.dart';

final shapeRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
  topLeft: const Radius.circular(10),
  topRight: const Radius.circular(10),
));
showSelectorWashkind({BuildContext context, VehicleKind vehicleKind}) async {
  return await showModalBottomSheet(
      shape: shapeRadius,
      context: context,
      builder: (context) => Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Modo de lavagem',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Column(
                  children: WashKind.values
                      .map((e) {
                        final washKind = washKindCards[e];                        
                        if(washKind == null ) return Container();
                        final price = ProductModel.of(e, vehicleKind).price;
                        return ListTile(
                            title: Text(washKind[0]),
                            leading: Icon(washKind[1]),
                            trailing: Text('R\$ $price'),
                            onTap: () {
                              Navigator.pop(context,e);
                            },
                          );})
                      .toList(),
                ),
              ],
            ),
          ));
}

showSelectorVehicleKind(BuildContext context) async {
  return await showModalBottomSheet(
      elevation: 50,
      context: context,
      shape: shapeRadius,
      builder: (context) => Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Selecione o tipo do Veiculo',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Wrap(
                  spacing: 5,
                  children: VehicleKind.values.map((v) {
                    final valueKind = vehicleKindCards[v];
                    return ListTile(
                      onTap: () async {
                        Navigator.of(context).pop(v);
                        //showSelectorWashkind();
                      },
                      leading: Icon(valueKind[1]),
                      title: Text(valueKind[0]),
                    );
                  }).toList(),
                ),
              ],
            ),
          ));
}
