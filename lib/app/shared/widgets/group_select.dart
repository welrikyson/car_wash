import 'package:flutter/material.dart';

class GroupSelect extends StatefulWidget {
  final Function(Widget selectedItem) onSelectChange;
  final List<Widget> items;

  const GroupSelect({Key key, this.onSelectChange,this.items}) : super(key: key);
  @override
  _GroupSelectState createState() => _GroupSelectState();
}

class _GroupSelectState extends State<GroupSelect> {

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return SafeArea(
      child: Row(
        children: items.map(
            (e){
              Expanded expanded;
              expanded = Expanded(
                child: Container(
                  child: InkWell(
                    child: e,
                    onTap: (){
                      itemTab(expanded);
                    },
                  ),
                ),
              );
              return expanded;
            }
        ).toList(),
      ),
    );
  }

  void itemTab(Expanded e) {
    if(widget.onSelectChange != null)widget.onSelectChange(e);
  }
}
