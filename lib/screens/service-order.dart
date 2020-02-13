import 'package:car_wash/models/client-model.dart';
import 'package:car_wash/models/vehicle-kind.dart';
import 'package:car_wash/models/vehicle-model.dart';
import 'package:car_wash/models/wash-kind.dart';
import 'package:car_wash/models/wash-model.dart';
import 'package:car_wash/models/washer-model.dart';
import 'package:car_wash/services/wash_service.dart';
import 'package:car_wash/shared/currency_input_formatter.dart';
import 'package:car_wash/shared/masked_text_input_formatter.dart';
import 'package:car_wash/widgets/dialog_seach_consumer.dart';
import 'package:car_wash/widgets/dialog_seach_washer.dart';
import 'package:car_wash/widgets/dialog_search.dart';
import 'package:car_wash/widgets/vehicle-kind-card.dart';
import 'package:car_wash/widgets/wash-kind-card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  WashModel washModel =
      new WashModel(washer: WasherModel(id: 1, nome: "Lavador"));
  String selectedWasher;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _valueTextController = TextEditingController(text: "R\$ 0,00");

  FocusNode _phoneFocusNode = FocusNode();

  final service = WashService();

  onClickCardVehicle(VehicleKind value) {
    setState(() {
      washModel.vehicleKind = value;
      _valueTextController.text = washModel.valueCurrent;
    });
  }

  onClickCarWashKind(WashKind value) {
    setState(() {
      washModel.kind = value;
      _valueTextController.text = washModel.valueCurrent;
    });
  }

  finderWasher() async{
    final result = await showDialog<WasherModel>(
      context: context,
      builder: (context) => DialogSearchWasher(),
    );
    if (result != null) {
      setState(() {
        washModel.washer = result;
      });
    }
  }

  finderClient() async {
    ClientModel result = await showDialog<ClientModel>(
      context: context,
      builder: (context) => DialogSearchConsumer(),
    );
    if (result != null) {
      setState(() {
        washModel.client = result;
      });
    }
  }

  _onPressedRestore() {
    setState(() {
      washModel = new WashModel(washer: WasherModel(id: 1, nome: "Lavador"));
      _phoneController.clear();
      _valueTextController.text ="R\$ 0,00";
    });
  }

  finderVehicle() async {
    Vehicle result = await showDialog<Vehicle>(
      context: context,
      builder: (context) => DialogSearch(),
    );
    if (result != null) {
      setState(() {
        washModel.vehicle = result;
        washModel.client = result.client;        
        washModel.phone = result.client.phone;

      });
      _phoneController.text = washModel.phone;

      if (_phoneController.text.isEmpty) {
        _phoneFocusNode.requestFocus();
      }
    }
  }

  _onPressSave() async {
    //TODO: validation phone number
    washModel.valueAjusted = _valueTextController.text.replaceAll('R\$ ', '');
    try {      
      if (washModel.client == null)
        washModel.client = ClientModel(
            id: 1, name: 'CONSUMIDOR', phone: _phoneController.text);
      else
        washModel.client = ClientModel(
            id: washModel.client.id,
            name: washModel.client.name,
            phone: _phoneController.text);

      await service.post(entity: this.washModel);
      _showSnackBarMessageSucess();
      setState(() {
        washModel = new WashModel(washer: WasherModel(id: 1, nome: "Lavador"));
      });
      _phoneController.clear();
    } catch (ex) {
      _scaffoldKey.currentState.showSnackBar(errorBar);
    }
  }

  _showSnackBarMessageSucess({String message = "Salva com sucesso"}) {
    final sucessBar = SnackBar(
      action: SnackBarAction(
        label: "Ir inicio",
        onPressed: () {
          Navigator.pop(this.context);
        },
      ),
      content: Text(message),
      duration: Duration(
        seconds: 2,
      ),
    );
    _scaffoldKey.currentState.showSnackBar(sucessBar);
  }

  final errorBar = SnackBar(
    content: Text("Salvo com sucesso"),
    duration: Duration(
      seconds: 2,
    ),
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.restore),
                onPressed: _onPressedRestore,
              ),
            ],
          )
        ],
        title: Text("Lavagem"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tipo de veículo",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Row(
                      children: VehicleKind.values
                          .map((e) => Expanded(
                                child: VehicleKindCard(
                                  vehicleKind: e,
                                  onTap: onClickCardVehicle,
                                  color: washModel.vehicleKind == e
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
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Row(
                        children: WashKind.values
                            .map((e) => Expanded(
                                    child: fromKind(
                                  washKind: e,
                                  onTap: onClickCarWashKind,
                                  color: washModel.kind == e
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
                            Container(
                              child: washModel.vehicle == null
                                  ? Text('Veículo')
                                  : Column(
                                      children: <Widget>[
                                        Text(
                                          washModel.vehicle.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        Text(washModel.vehicle.plate),
                                      ],
                                    ),
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
                            Icon(Icons.person_outline),
                            Container(
                              child: washModel.client == null
                                  ? Text('Consumidor')
                                  : Column(
                                      children: <Widget>[                                        
                                        Text(washModel.client.name),
                                      ],
                                    ),
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
                TextFormField(
                  focusNode: _phoneFocusNode,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixText: "(92) ",                  
                    hintText: 'Telefone',
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Telefone do consumidor',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    MaskedTextInputFormatter(
                      mask: 'xxxxx-xxxx',
                      separator: '-',
                    ),
                  ],
                  keyboardType: TextInputType.phone,                  
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
                            Text(washModel.washer?.nome ?? "Lavador"),
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
                  onChanged: (arg) {
                    washModel.description = arg;
                  },
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(10),
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
                SizedBox(height: 10,),
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
                    inputFormatters: [
                       WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    style: TextStyle(fontSize: 40.0),
                    textAlign: TextAlign.right,
                    controller: _valueTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(                    
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
                  onPressed: _onPressSave,
                  child: Text('SALVAR LAVAGEM',
                      style: Theme.of(context).accentTextTheme.button.copyWith(fontSize: 22)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
              ],
            ),
          ),
          
        ],
      ),
    ));
  }
}
