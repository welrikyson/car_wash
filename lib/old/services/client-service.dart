import 'dart:convert';

import 'package:car_wash/models/client-model.dart';
import 'package:dio/dio.dart';

import 'global_datas.dart';

class ClientService {
  static final urlBase = UrlBaseServe;

  static Future<List<ClientModel>> getBy(String query) async {   
    
    final uri = "/cliente/clienteGet/?sessionMob=1";
    var dio = Dio();
    FormData formData = new FormData.fromMap({ "q": query,});
    final response = await dio.post(urlBase+uri, data: formData);    
    if (response.statusCode == 200) {
     return ClientModel.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<ClientModel>> getLocalBy(String query) async {   
    return Mock.getByQuery(query);    
  }
}

class Mock {
  static Future<List<ClientModel>> getByQuery(String query) {
    Future<List<ClientModel>> futureListResults = Future(() {
      return vehicles
          .where((element) =>
              element.name.contains(query))
          .toList();
    });
    return futureListResults;
  }
}

final List<ClientModel> vehicles = [
  ClientModel(id:1,name: "ROBOT CLIENT 1", phone: "91111-2222"),
  ClientModel(id:2,name: "ROBOT CLIENT 2", phone: "91111-2222"),
  ClientModel(id:3,name: "ROBOT CLIENT 3", phone: "91111-2222"),
  ClientModel(id:4,name: "ROBOT CLIENT 4", phone: "91111-2222"),
  ClientModel(id:5,name: "ROBOT CLIENT 5", phone: "91111-2222"),
  ClientModel(id:6,name: "ROBOT CLIENT 6", phone: "91111-2222"),
];