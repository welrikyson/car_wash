import 'package:car_wash/widgets/dialog_search.dart';
import 'package:flutter/material.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  String selectedVehicleType;
  String selectedWashKind;
  String selectedWasher;
  String selectedClient;
  String selectedVehicle;

  onClickCardVehicle(String value) {
    setState(() {
      selectedVehicleType = value;
    });
  }

  onClickCarWashKind(String value) {
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
              Text(
                "Tipo de veiculo",
                style: Theme.of(context).textTheme.headline6,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Carro"),
                            Icon(Icons.directions_car)
                          ],
                        ),
                        color: selectedVehicleType == "Car"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCardVehicle("Car");
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Moto"),
                            Icon(Icons.motorcycle)
                          ],
                        ),
                        color: selectedVehicleType == "Motocicle"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCardVehicle("Motocicle");
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Utilitário"),
                            Icon(Icons.shopping_cart)
                          ],
                        ),
                        color: selectedVehicleType == "Utilitário"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCardVehicle("Utilitário");
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Caminhão"),
                            Icon(Icons.directions_bus)
                          ],
                        ),
                        color: selectedVehicleType == "Truck"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCardVehicle("Truck");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: <Widget>[
              Text(
                "Modo de lavagem",
                style: Theme.of(context).textTheme.headline6,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Simples"),
                            Icon(Icons.local_car_wash)
                          ],
                        ),
                        color: selectedWashKind == "Simples"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCarWashKind("Simples");
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Cera"),
                            Icon(Icons.lightbulb_outline)
                          ],
                        ),
                        color: selectedWashKind == "Cera"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCarWashKind("Cera");
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text("Completa"),
                            Icon(Icons.star)
                          ],
                        ),
                        color: selectedWashKind == "Completa"
                            ? Colors.deepPurple[300]
                            : Colors.white,
                      ),
                      onTap: () {
                        onClickCarWashKind("Completa");
                      },
                    ),
                  ),
                ],
              ),
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
