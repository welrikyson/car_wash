import 'package:car_wash/models/vehicle-kind.dart';
import 'package:car_wash/models/wash-kind.dart';
import 'package:car_wash/widgets/dialog_search.dart';
import 'package:car_wash/widgets/vehicle-kind-card.dart';
import 'package:car_wash/widgets/wash-kind-card.dart';
import 'package:flutter/material.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  VehicleKind selectedVehicleKind;
  WashKind selectedWashKind;
  String selectedWasher;
  String selectedClient;
  String selectedVehicle;

  onClickCardVehicle(VehicleKind value) {
    setState(() {
      selectedVehicleKind = value;
    });
  }

  onClickCarWashKind(WashKind value) {
    setState(() {
      selectedWashKind = value;
    });
  }

  finderWasher() {
    setState(() {
      selectedWasher = "Pedro Lavador";
    });
  }

  finderClient() {
    setState(() {
      selectedClient = "Welrikyson felix";
    });
  }

  finderVehicle() async {
    String result = await showDialog<String>(
      context: context,
      builder: (context) => DialogSearch(),
    );
    if (result != null) {
      setState(() {
        selectedVehicle = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {},
              ),
            ],
          )
        ],
        title: Text("Nova Lavagem"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tipo de veículo",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                children: VehicleKind.values
                    .map((e) => Expanded(
                          child: VehicleKindCard(
                            vehicleKind: e,
                            onTap: onClickCardVehicle,
                            color: selectedVehicleKind == e
                                ? Colors.deepPurple
                                : Colors.white,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Modo de lavagem",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                  children: WashKind.values
                      .map((e) => Expanded(
                              child: fromKind(
                            washKind: e,
                            onTap: onClickCarWashKind,
                            color: selectedWashKind == e
                                ? Colors.deepPurple
                                : Colors.white,
                          )))
                      .toList()),
            ],
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.directions_car),
                      Text(
                        selectedVehicle == null ? 'Veículo' : selectedVehicle,
                      ),
                    ],
                  ),
                ),
                onTap: finderVehicle,
              )
            ],
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person),
                      Text(
                        selectedClient == null ? 'Cliente' : selectedClient,
                      ),
                    ],
                  ),
                ),
                onTap: finderClient,
              )
            ],
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.invert_colors,
                      ),
                      Text(
                        selectedWasher == null ? 'Lavador' : selectedWasher,
                      ),
                    ],
                  ),
                ),
                onTap: finderWasher,
              )
            ],
          ),
          TextField(
            onSubmitted: (input) {},
            decoration: InputDecoration(
                hintText: 'Observação sobre a lavagem',
                prefixIcon: Icon(Icons.note),
                labelText: 'Observações',
                helperText: '*opcional'),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    ));
  }
}
