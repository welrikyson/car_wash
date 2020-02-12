import 'package:car_wash/models/wash-model.dart';
// import 'package:car_wash/models/wash_kind.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

class WashService {
  // Future<List<WashKind>> getWashKinds() async{
  //   final response =
  //     await http.get('http://ciadopescado.com.br/gap/produto/lavagemGet/?sessionMob=1');
  //   if (response.statusCode == 200) {
  //     return WashKind.fromJsonList(json.decode(response.body));
  //   } else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load post');
  //   }
  // }
  var dio = Dio();
  Future post({WashModel entity}) async{
    final uri = "http://192.168.0.63/lavafacil/lavagem/cadastrarLavagem/?sessionMob=1";
    
    var map = entity.toJson();
    map.addAll({      
      "idEmpresa": 1,
      "idUsuario": 1,      
      "nomeUsuario": "Bruno",     
      "flagInsertVeiculo": entity.vehicle.id== null ? 1 : 0,      
    });    
    FormData formData = new FormData.fromMap(map);
    final response = await dio.post(uri, data: formData);    

    if (response.statusCode == 200) {
      return ;//Vehicle.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}