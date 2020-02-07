import 'package:car_wash/models/wash_kind.dart';
import 'package:car_wash/services/wash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  void _showDialog() {
    showDialog(      
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Row(            
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
              Text('Salvando')
            ],
          ),
          content: Text('Inserindo registro'),
        );
      },
    );
  }
  @override
  void initState(){
    initilizer();
  }

  initilizer()async{
    List<WashKind> washKindsFind = await WashService().getWashKinds();
    List<DropdownMenuItem<WashKind>> dropWashKinds = 
    washKindsFind.map<DropdownMenuItem<WashKind>>((WashKind value) {
                  return DropdownMenuItem<WashKind>(
                    value: value,
                    child: Text(value.descricao),
                  );
                }).toList();


    washKinds = dropWashKinds;
    dropdownValue = washKindsFind.first;
  }
  

  List<DropdownMenuItem<WashKind>> washKinds;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();  
  WashKind dropdownValue;
  String dropdownConsumerValue = 'Bruno';
  String dropdownWasherValue = 'Bruno';
  @override
  Widget build(BuildContext context) {
    var controllerInput = TextEditingController(
      text: dropdownConsumerValue
    );
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: _showDialog,
                  ),
                ],
              )
            ],
            title: Text("Service Order"),
          ),
          body: ListView(
            children: <Widget>[          
              DropdownButtonFormField<WashKind>(
                
                isDense: true,            
                decoration: InputDecoration(
                    labelText: 'Tipo de lavagem',
                    prefixIcon: Icon(Icons.local_car_wash)),
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                hint: Text('Tipo lavagem'),
                onChanged: (WashKind newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: washKinds,
              ),
              TextField(
                controller: controllerInput,
            autofocus: true,
            onSubmitted: (input) {},
            decoration: InputDecoration(
                hintText: 'Valor da lavagem',
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Valor',
                prefixText: 'R\$ '),
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.sentences,
          ),
          DropdownButtonFormField<String>(
            isDense: true,
            decoration: InputDecoration(
                labelText: 'Consumidor',
                prefixIcon: Icon(Icons.airline_seat_recline_extra)),
            value: dropdownConsumerValue,
            icon: Icon(Icons.arrow_drop_down),
            hint: Text('Consumidor'),
            onChanged: (String newValue) {
              setState(() {
                dropdownConsumerValue = newValue;
              });
            },
            items: <String>[
              'Bruno',
              'Geral',
              'Wel',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextFormField(
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(12),
              WhitelistingTextInputFormatter.digitsOnly,
              BlacklistingTextInputFormatter.singleLineFormatter,
            ],
            decoration: InputDecoration(
              hintText: 'Telefone',
              prefixIcon: Icon(Icons.phone),
              labelText: 'Fone',
              helperText: '*opcional',
              prefixText: '(+55) 92 9 ',
            ),
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
          ),
          DropdownButtonFormField<String>(
            isDense: true,
            decoration: InputDecoration(
                labelText: 'Lavador', prefixIcon: Icon(Icons.person)),
            value: dropdownWasherValue,
            icon: Icon(Icons.arrow_drop_down),
            hint: Text('Lavador'),
            onChanged: (String newValue) {
              setState(() {
                dropdownWasherValue = newValue;
              });
            },
            items: <String>[
              'Bruno',
              'Geral',
              'Wel',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            autofocus: true,
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
    );
  }
}
