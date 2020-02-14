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
import 'package:car_wash/widgets/dialogs.dart';
import 'package:car_wash/widgets/vehicle-kind-card.dart';
import 'package:car_wash/widgets/wash-kind-card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {
  WashModel washModel = new WashModel();

  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _valueTextController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _focusPrice = FocusNode();

  final service = WashService();

  onClickCardVehicle(VehicleKind value) {
    washModel.kind = null;

    setState(() {
      washModel.vehicleKind = value;
      _valueTextController.updateValue(washModel.valueCurrent);
    });
  }

  onClickCarWashKind(WashKind value) {
    setState(() {
      washModel.kind = value;
      _valueTextController.updateValue(washModel.valueCurrent);
    });
  }

  finderWasher() async {
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
        washModel.phone = result.phone;
        _phoneController.text = washModel.phone;
      });
    }
  }

  _onPressedRestore() {
    setState(() {
      washModel = new WashModel();
      _phoneController.clear();
      _valueTextController.updateValue(0.0);
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
        washModel.phone = result.client?.phone ?? "";
      });
      _phoneController.text = washModel.phone;

      if (_phoneController.text.isEmpty) {
        _phoneFocusNode.requestFocus();
      }
    }
  }

  bool formValide() {
    if (washModel.vehicleKind == null) {
      showSnackBarMessege("Selecione um tipo de veiculo");
      return false;
    }
    if (washModel.kind == null) {
      showSnackBarMessege("Selecione um tipo de lavagem");
      return false;
    }
    if (washModel.vehicle == null) {
      showSnackBarMessege("Selecione um veículo");
      return false;
    }
    if (!phoneValide(_phoneController.text)) {
      showSnackBarMessege("Insira um telefone válido");
      _phoneFocusNode.requestFocus();
      return false;
    }
    if (_valueTextController.numberValue == 0.0 ||
        _valueTextController.text.isEmpty) {
      showSnackBarMessege("Altere valor da lavagem");
      return false;
    }

    return true;
  }

  bool phoneValide(String value) {
    final phone = value.replaceAll('-', '');
    String patttern = r'[0-9]{5}[0-9]{4}';
    RegExp regExp = new RegExp(patttern);
    if (phone.length == 0) {
      return false;
    } else if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }

  showSnackBarMessege(String messege) {
    final sucessBar = SnackBar(
      action: SnackBarAction(
        label: "OK",
        onPressed: () {
          _scaffoldKey.currentState.deactivate();
        },
      ),
      content: Text(messege),
      duration: Duration(
        seconds: 2,
      ),
    );
    _scaffoldKey.currentState.showSnackBar(sucessBar);
  }

  _onPressSave() async {
    try {
      if (formValide()) {
        if (washModel.client == null)
          washModel.client = ClientModel(
              id: 1, name: 'CONSUMIDOR', phone: _phoneController.text);

        this.washModel.valueAjusted =
            _valueTextController.numberValue.toString();
        washModel.phone = _phoneController.text;
        FocusScope.of(context).unfocus();
        Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
        await service.post(entity: this.washModel);
        Navigator.of(_keyLoader.currentContext, rootNavigator: true)
            .pop(); //close the dialoge

        _showSnackBarMessageSucess();
        setState(() {
          washModel = new WashModel();
        });
        _phoneController.clear();
        _valueTextController.updateValue(0.0);
      }
    } catch (ex) {
      _scaffoldKey.currentState.showSnackBar(errorBar);
    }
  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  _showSnackBarMessageSucess({String message = "Salvo com sucesso"}) {
    final sucessBar = SnackBar(
      action: SnackBarAction(
        label: "Ir inicio",
        onPressed: () {
          Navigator.pop(this.context);
        },
      ),
      content: Text(message),
      duration: Duration(
        seconds: 1,
      ),
    );
    _scaffoldKey.currentState.showSnackBar(sucessBar);
  }

  final errorBar = SnackBar(
    content: Text("Erro"),
    duration: Duration(
      seconds: 2,
    ),
  );

  initState() {
    _configPriceField();
    super.initState();
  }

  _configPriceField() {
    _focusPrice.addListener(() {
      if (_focusPrice.hasFocus) {
        _valueTextController.selection = TextSelection(
            baseOffset: 0, extentOffset: _valueTextController.text.length);
      }
    });
  }

  List<Widget> _buildWashKind() {
    List<WashKind> validWashsKind;
    if (washModel.vehicleKind == VehicleKind.truck) {
      validWashsKind = WashKind.values.sublist(4);
    } else {
      validWashsKind = WashKind.values.sublist(0, 4);
    }

    return validWashsKind
        .map((e) => Expanded(
                child: Container(
              height: 70,
              child: fromKind(
                washKind: e,
                onTap: onClickCarWashKind,
                color: washModel.kind == e ? Colors.deepPurple : Colors.white,
              ),
            )))
        .toList();
  }

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
                      children: _buildWashKind(),
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
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);
                    if (value.length == 0) {
                      return 'Please enter mobile number';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
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
                    onChanged: (arg) {
                      washModel.valueAjusted = arg;
                    },
                    focusNode: _focusPrice,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter(),
                    ],
                    style: TextStyle(fontSize: 40.0),
                    textAlign: TextAlign.right,
                    controller: _valueTextController,
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
                      onPressed: _onPressSave,
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
    ));
  }
}
