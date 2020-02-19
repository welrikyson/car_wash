import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  onTabTapped(value) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitor de lavagens'),
        centerTitle: true,
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/order/new');

        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Início'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.notifications),
          title: new Text('Notificações'),
        ),
      ],
    );
  }

  Widget _buildBody() => Center(
        child: Column(
          children: <Widget>[
            Text(""),
            Text("GAP"),
          ],
        ),
      );
}
