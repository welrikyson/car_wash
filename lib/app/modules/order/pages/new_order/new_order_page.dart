import 'package:car_wash/app/modules/order/pages/new_order/new_order_controller.dart';
import 'package:car_wash/app/modules/order/pages/new_order/selectors.dart';
import 'package:car_wash/app/modules/order/pages/new_order/vehicle_kind_list.dart';
import 'package:car_wash/app/modules/order/pages/new_order/wash_kind_list.dart';
import 'package:car_wash/app/shared/models/vehicle_model.dart';
import 'package:car_wash/app/shared/models/wash_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOrderPage extends StatefulWidget {
  @override
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final NewOrderController controller = NewOrderController();  

  _NewOrderPageState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onInit());
  }

  _onInit() async {
    final chosenVehicleKind = await showSelectorVehicleKind(context);
    print('show selector vehicle done');
    if (chosenVehicleKind != null) {
      setState(() => controller.vehicleKind = chosenVehicleKind);
      final chosenWashKind = await showSelectorWashkind(
          context: context, vehicleKind: chosenVehicleKind);
      if (chosenWashKind != null)
        setState(() => controller.washKind = chosenWashKind);
      print('show selector vehicle done');
      //TODO: show vehicle selector
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text('Nova Lavagem')),
      body: _buildBordy(context),
    );
  }

  //TODO: add animations and validations
  _buildBordy(context) {
    return Form(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(5),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tipo de veiculo',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Wrap(
                        spacing: 5,
                        children: VehicleKind.values.map((v) {
                          final valueKind = vehicleKindCards[v];
                          return ChoiceChip(
                            onSelected: (bool value) {
                              setState(() {
                                controller.vehicleKind =
                                    value ? v : null;
                              });
                            },
                            label: Text(
                              valueKind[0],
                            ),
                            selected: controller.vehicleKind == v,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Modo de lavagem',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Wrap(
                        spacing: 5,
                        children: WashKind.values.map((v) {
                          final washKindCard = washKindCards[v];
                          if (washKindCard == null) return Container();
                          return ChoiceChip(
                            label: Text(washKindCard[0]),
                            onSelected: (value) {
                              setState(() {
                                controller.washKind = value ? v : null;
                              });
                            },
                            selected: controller.washKind == v,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Divider(),
                TextFormField(
                  onTap: () {
                    print('tap cliente text field');
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Veiculo",
                      isDense: true,
                      hintText: 'Selecione um veiculo'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: 'Consumidor',
                  onTap: () {
                    print('tap cliente text field');
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Cliente",
                    isDense: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Telefone",
                    hintText: "99999-99999",
                    isDense: true,
                  ),
                  keyboardType: TextInputType.phone,
                  validator: controller.washValidator.validatePhone,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: 'Lavador',
                  onTap: () {
                    print('tap lavador text field');
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Lavador",
                    isDense: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: "Observações",
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ],
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 5.0, // has the effect of extending the shadow
                  offset: Offset(
                    10.0, // horizontal, move right 10
                    10.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Valor da lavagem",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Container(
                  width: 180,
                  child: TextFormField(
                    enableInteractiveSelection: false,                    
                    inputFormatters: [
                      
                      // CurrencyInputFormatter(),
                    ],
                    style: TextStyle(fontSize: 40.0),
                    textAlign: TextAlign.right,
                    controller: controller.valueTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: "R\$",
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ButtonTheme(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('SALVAR LAVAGEM',
                          style: Theme.of(context)
                              .accentTextTheme
                              .button
                              .copyWith(fontSize: 22)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
