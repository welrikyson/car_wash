import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitor de lavagens'),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (_, __) {
          return BottomNavigationBar(
            currentIndex: _pageController?.page?.round() ?? 0,
            onTap: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(microseconds: 300),
                  curve: Curves.easeInOut);
            },
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.list),
                title: new Text('Lavagens'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('buscar'),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/order/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }
  
  List<Widget> get _screens {
    return [
      Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Monitor de lavagens',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '''Aqui serao exibidas suas lavagens com estados difente de concluido!'''
              '''\nEstamos trabalhando nessa funcionalidade.''',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
      
      Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Encontre lavagens',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '''As lavagens do dia atual serao exibidas aqui!'''
              '''\nEstamos trabalhando nessa funcionalidade.''',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    ];
  }
}
