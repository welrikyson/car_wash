import 'dart:convert';
import 'global_datas.dart';
import 'package:car_wash/models/vehicle-model.dart';
import 'package:dio/dio.dart';

class VehicleService {
  static final urlBase = UrlBaseServe;

  static Future<List<Vehicle>> getBy(String query) async {   
    final uri = "/veiculo/veiculoGet/?sessionMob=1";    
    var dio = Dio();
    FormData formData = new FormData.fromMap({ "q": query,});
    final response = await dio.post(urlBase+uri, data: formData);    
    if (response.statusCode == 200) {
      return Vehicle.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Vehicle>> getLocalBy(String query) async {   
    return Mock.getByQuery(query);    
  }
}

class Mock {
  static Future<List<Vehicle>> getByQuery(String query) {
    Future<List<Vehicle>> futureListResults = Future(() {
      return vehicles
          .where((element) =>
              element.name.contains(query) || element.plate.contains(query))
          .toList();
    });
    return futureListResults;
  }
}

final List<Vehicle> vehicles = [
  Vehicle(name: "Uno", plate: "NOF-0566"),
  Vehicle(name: "Ferrari", plate: "NOP-0566"),
  Vehicle(name: "Lamborgni", plate: "XOV-0566"),
  Vehicle(name: "Limosine", plate: "XZO-0566"),
  Vehicle(name: "Fusca", plate: "EOP-0566"),
  Vehicle(name: "Toro", plate: "XYZ-0566"),
];
