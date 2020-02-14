import 'dart:async';

import 'package:car_wash/models/vehicle-model.dart';
import 'package:car_wash/services/car-service.dart';

import 'package:car_wash/shared/masked_text_input_formatter.dart';
import 'package:flutter/material.dart';

class DialogSearch extends StatefulWidget {
  @override
  _DialogSearchState createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
  final TextEditingController _searchQuery = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final FocusNode _textFocus = new FocusNode();
  bool _isSearching = false;
  String _error;
  List<Vehicle> _results = List();

  Timer debounceTimer;

  _DialogSearchState() {
    _searchQuery.addListener(() {
      if (_textFocus.hasFocus) {
        if (debounceTimer != null) {
          debounceTimer.cancel();
        }
        debounceTimer = Timer(Duration(milliseconds: 500), () {
          if (this.mounted) {
            performSearch(_searchQuery.text);
          }
        });
      }
    });
  }
  final minCaracters = 3;

  void performSearch(String query) async {
    if (query.length < minCaracters) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });
    try {
      final repos = await VehicleService.getBy(query);
      if (this._searchQuery.text == query && this.mounted) {
        setState(() {
          _isSearching = false;
          if (repos != null) {
            _results = repos;
          } else {
            _error = 'Error searching repos';
          }
        });
      }
    } catch (ex) {
      setState(() {
        print("erro");
        _isSearching = false;
        _error = 'Error ${ex.toString()}';
      });
    }
  }

  _onPressConfirm() {
    final name = _clientNameController.text;
    final plate = _searchQuery.text;

    if(!validePlate(plate) | (name.length < 2)) return;

    final newClient = Vehicle(name: name, plate: plate);
    Navigator.pop(context, newClient);
  }

  bool validePlate(String value){
    final plate = value;

    if(plate.length < 7)return false;

    String patttern = r'[A-Z]{3}[-][0-9]{4}';
    RegExp regExp = new RegExp(patttern);
    if (regExp.hasMatch(value)) {
      return true;
    }

    String pattternMerc = r'[A-Z]{3}[-][0-9]{1}[A-Z]{1}[0-9]{2}';
    RegExp regExpMerc = new RegExp(pattternMerc);
    if (regExpMerc.hasMatch(value)) {
      return true;
    }   

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Veículos",
                style: Theme.of(context).textTheme.display1,
              ),
              TextField(
                inputFormatters: [
                  MaskedTextInputFormatter(
                    mask: 'xxx-xxxx',
                    separator: '-',
                  )
                ],
                controller: _searchQuery,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                focusNode: _textFocus,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Placa",
                    isDense: true),
                onEditingComplete: () {
                  print("enter");
                },
              ),
              SizedBox(
                height: 300,
                child: buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Key _formKey = GlobalKey<FormState>();

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return Center(child: Text('Buscando na api...'));
    } else if (_error != null) {
      return Text(_error);
    } else if (_searchQuery.text.isEmpty) {
      return Text('Inicie a busca digitando na barra de busca');
    } else if (_searchQuery.text.length < minCaracters) {
      return Text('Informe a placa do veículo');
    } else {
      if (_results.isEmpty) {
        return Column(
          children: <Widget>[
            Text("Sem resultados, enter para cadastrar"),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (String arg) {
                      if (arg.length < 2) {
                        return 'Nome deve ter mais que 2 caracteres.';
                      } else
                        return null;
                    },
                    controller: _clientNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "nome",
                        isDense: true),
                  ),
                  DropdownButton(
                    onChanged: (arg) {},
                    items: ["preto", "branco"]
                        .map((color) => DropdownMenuItem(child: Text(color)))
                        .toList(),
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text("CONFIRMAR"),
              onPressed: _onPressConfirm,
            ),
          ],
        );
      }
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            var result = _results[index];
            return ListTile(
              subtitle: Text(result.name),
              title: Text(result.plate),
              onTap: () {
                Navigator.pop(context, result);
              },
            );
          });
    }
  }
}
