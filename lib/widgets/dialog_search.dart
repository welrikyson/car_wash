import 'dart:async';

import 'package:car_wash/models/vehicle-model.dart';
import 'package:car_wash/services/car-service.dart';
import 'package:flutter/material.dart';

class DialogSearch extends StatefulWidget {
  @override
  _DialogSearchState createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<Vehicle> _results = List();

  Timer debounceTimer;

  _DialogSearchState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
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
                style: Theme.of(context).textTheme.headline5,
              ),
              TextField(
                controller: _searchQuery,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Placa ou nome",
                    isDense: true),
              ),
              SizedBox(
                height: 300,
                child: buildBody(context),
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("Adicionar")),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return Center(child: Text('Buscando na api...'));
    } else if (_error != null) {
      return Text(_error);
    } else if (_searchQuery.text.isEmpty) {
      return Text('Inicie a busca digitando na barra de busca');
    } else {
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            var result = _results[index];
            return ListTile(
              subtitle: Text(result.name),
              title: Text(result.plate),
              onTap: () {
                Navigator.pop(context, result.plate);
              },
            );
          });
    }
  }
}
