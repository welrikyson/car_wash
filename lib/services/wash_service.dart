import 'package:car_wash/models/wash-model.dart';
import 'package:dio/dio.dart';

import 'global_datas.dart';



class WashService {  
  var dio = Dio();
  static final urlBase = UrlBaseServe;
  Future post({WashModel entity}) async{
    final uri = "/lavafacil/lavagem/cadastrarLavagem/?sessionMob=1";
    
    var map = entity.toJson();
    map.addAll({      
      "idEmpresa": 1,
      "idUsuario": 1,      
      "nomeUsuario": "Bruno",     
      "flagInsertVeiculo": entity.vehicle.id== null ? 1 : 0,      
    });    
    FormData formData = new FormData.fromMap(map);
    final response = await dio.post(urlBase+uri, data: formData);    

    if (response.statusCode == 200) {
      return ;//Vehicle.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}