import 'package:flutter/material.dart';

class ReusableCard extends StatefulWidget {
  
  final Function onTap;
  final String labelText;
  final Color color;
  final IconData icon;
  final double size;

  ReusableCard({this.onTap, this.labelText,this.color,this.icon,this.size = 40});
  @override
  _ReusableCardState createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(      
      child: Card(        
        child: Column(          
          children: <Widget>[
            Text(widget.labelText),
            Icon(widget.icon,size: widget.size,)
          ],
        ),
        color: widget.color,        
      ),
      onTap: widget.onTap,
    );
  }
}
