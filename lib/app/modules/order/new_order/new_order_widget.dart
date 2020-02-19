import 'package:flutter/material.dart';

class NewOrderWidget extends StatefulWidget {
  @override
  _NewOrderWidgetState createState() => _NewOrderWidgetState();
}

class _NewOrderWidgetState extends State<NewOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Lavagem')
      ),
      body: _buildBordy(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}

_buildBordy() {
  return Form(
    child: ListView(
      padding: EdgeInsets.all(5),
      children: <Widget>[
        TextFormField(
          maxLength:10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Cliente",
          ),
          keyboardType: TextInputType.phone,
        ),
        TextFormField(
          maxLength:10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Telefone",
            hintText: "99999-99999",

          ),
          keyboardType: TextInputType.phone,
        ),
        TextFormField(
          maxLength:10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Observações",
          ),
          keyboardType: TextInputType.multiline,
        ),
        TextFormField(
          maxLength:10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Telefone",
            hintText: "99999-99999",

          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    ),

  );
}

_buildFloatingActionButton() {
  return FloatingActionButton.extended(
    onPressed: null,
    label: Text('SALVAR'),
    icon: Icon(Icons.save),);
}
