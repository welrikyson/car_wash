import 'package:car_wash/app/modules/order/new_order/new_order_widget.dart';
import 'package:car_wash/app/modules/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppModule{


  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OrderWidget());
      case '/order/new':
        // Validation of correct data type
        // if (args is String) {
        //   return MaterialPageRoute(
        //     builder: (_) => SecondPage(
        //           data: args,
        //         ),
        //   );
        // }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return MaterialPageRoute(builder: (_) => NewOrderWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
  
}
  
