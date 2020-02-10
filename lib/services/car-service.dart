import 'package:car_wash/models/vehicle-model.dart';

class VehicleService {
  static Future<List<Vehicle>> getBy(String query) async => await Mock.getByQuery(query);
}

class Mock {
  static Future<List<Vehicle>> getByQuery(String query) {    
    Future<List<Vehicle>> futureListResults = Future(() {
      return vehicles.where((element) => element.name.contains(query)||   element.plate.contains(query)).toList();
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
