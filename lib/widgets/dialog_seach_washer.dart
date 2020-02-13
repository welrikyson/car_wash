import 'dart:async';

import 'package:car_wash/models/washer-model.dart';
import 'package:car_wash/services/washer-service.dart';
import 'package:flutter/material.dart';

class DialogSearchWasher extends StatefulWidget {
  @override
  _DialogSearchWasherState createState() => _DialogSearchWasherState();
}

class _DialogSearchWasherState extends State<DialogSearchWasher> {
  final TextEditingController _searchQuery = TextEditingController();
  
  final FocusNode _textFocus = new FocusNode();
  bool _isSearching = false;
  String _error;
  List<WasherModel> _results = List();

  Timer debounceTimer;

  _DialogSearchWasherState() {
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

    final repos = await WasherService.getBy(query);
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
                "Lavadores",
                style: Theme.of(context).textTheme.display1,
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

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return Center(child: Text('Buscando na api...'));
    } else if (_error != null) {
      return Text(_error);
    } else if (_searchQuery.text.isEmpty) {
      return Text('Inicie a busca digitando na barra de busca');
    } else if (_searchQuery.text.length < minCaracters) {
      return Text('Informe a nome do lavador');
    } else {
      if (_results.isEmpty) {
        return Column(
          children: <Widget>[
            Text("Sem resultados, enter para cadastrar"),            
          ],
        );
      }
      return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _results.length,
          itemBuilder: (BuildContext context, int index) {
            var result = _results[index];
            return ListTile(
              subtitle: Text(result.id.toString()),
              title: Text(result.nome),
              onTap: () {
                Navigator.pop(context, result);
              },
            );
          });
    }
  }
}
