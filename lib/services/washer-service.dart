import 'dart:convert';

import 'package:car_wash/models/washer-model.dart';
import 'package:dio/dio.dart';

class WasherService {

  static Future<List<WasherModel>> getBy(String query) async {   
    final uri = "http://ciadopescado.com.br/gap/funcionario/lavadorGet/?sessionMob=1";
    //final uri = "http://192.168.0.63/lavafacil/cliente/clienteGet/?sessionMob=1";
    var dio = Dio();
    FormData formData = new FormData.fromMap({ "q": query,});
    final response = await dio.post(uri, data: formData);    
  
    

    

    if (response.statusCode == 200) {     

     return WasherModel.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }  
}
