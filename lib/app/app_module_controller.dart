import 'package:shared_preferences/shared_preferences.dart';

class AppModuleController {
  AppModuleController(){

  }

  init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.get('user');
    if(user == null){
      print('Null user');
    }
  }  
}   