import 'dart:convert';

import 'package:car_wash/models/washer-model.dart';
import 'package:dio/dio.dart';

import 'global_datas.dart';

class WasherService {
  static final urlBase = UrlBaseServe;

  static Future<List<WasherModel>> getBy(String query) async {   
    final uri = "/funcionario/lavadorGet/?sessionMob=1";    
    var dio = Dio();
    FormData formData = new FormData.fromMap({ "q": query,});
    final response = await dio.post(urlBase+uri, data: formData);    
    if (response.statusCode == 200) {
      return WasherModel.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }  
}
