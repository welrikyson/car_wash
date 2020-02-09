import 'package:flutter/material.dart';

class DialogSearch extends StatefulWidget {
  @override
  _DialogSearchState createState() => _DialogSearchState();
}

class _DialogSearchState extends State<DialogSearch> {
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
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Placa ou nome",
                      isDense: true),
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        subtitle: Text("Geral"),
                        title: Text("Geral"),
                        onTap: () {
                          Navigator.pop(context, "Geral");
                        },
                      ),
                      ListTile(
                        subtitle: Text("GOl VW"),
                        title: Text("XYX-1111"),
                        onTap: () {
                          Navigator.pop(context, "XYX-1111");
                        },
                      ),
                      ListTile(
                        subtitle: Text("Fiat Uno"),
                        title: Text("NOP-0000"),
                        onTap: () {},
                      ),
                    ],
                  ),
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
}