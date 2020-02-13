import 'dart:async';

import 'package:car_wash/models/client-model.dart';
import 'package:car_wash/services/client-service.dart';
import 'package:flutter/material.dart';

class DialogSearchConsumer extends StatefulWidget {
  @override
  _DialogSearchConsumerState createState() => _DialogSearchConsumerState();
}

class _DialogSearchConsumerState extends State<DialogSearchConsumer> {
  final TextEditingController _searchQuery = TextEditingController();
  final TextEditingController _vehicleNameController = TextEditingController();
  final FocusNode _textFocus = new FocusNode();
  bool _isSearching = false;
  String _error;
  List<ClientModel> _results = List();

  Timer debounceTimer;

  _DialogSearchConsumerState() {
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

    //TODO: remove this

    final repos = await ClientService.getBy(query);
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
  }

  _onPressConfirm() {
    final name = _vehicleNameController.text;
    final plate = _searchQuery.text;    
    final newVehicle = ClientModel(name: name, phone: plate);
    Navigator.pop(context, newVehicle);
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
                "Clientes",
                style: Theme.of(context).textTheme.headline5,
              ),
              TextField(                
                controller: _searchQuery,
                textCapitalization: TextCapitalization.characters,
                autofocus: true,
                focusNode: _textFocus,                
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nome",
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
      return Text('Informe a nome do cliente');
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
                    controller: _vehicleNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "nome",
                        isDense: true),
                  ),
                  DropdownButton(
                    onChanged: (arg){},
                    items: ["preto","branco"].map((color)=> DropdownMenuItem(child: Text(color))).toList(),
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
              subtitle: Text(result.phone),
              title: Text(result.name),
              onTap: () {
                Navigator.pop(context, result);
              },
            );
          });
    }
  }
}
