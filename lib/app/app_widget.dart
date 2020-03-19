import 'package:car_wash/app/app_module.dart';
import 'package:car_wash/app/app_module_controller.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  final AppModuleController controller = AppModuleController();

  
  @override
  Widget build(BuildContext context) {
    controller.init();
    return MaterialApp(
      initialRoute: "/",      
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.deepPurple,
      ),
      onGenerateRoute: AppModule.generateRoute,
    );
  }
}