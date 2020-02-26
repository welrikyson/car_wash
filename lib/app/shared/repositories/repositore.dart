import 'package:car_wash/app/shared/repositories/global_datas.dart';
import 'package:dio/dio.dart';

abstract class Repositore {
  static dynamic post(String uri, dynamic entity) async {
    final token = '?sessionMob=1';
    final router = UrlBaseServe + uri + token;
    var dio = Dio();
    var entityJson = entity.toJson();
    FormData formData = new FormData.fromMap(entityJson);
    final response = await dio.post(router, data: formData);
    if (response.statusCode == 200) {
      return; //Vehicle.fromJsonList(json.decode(response.data));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
