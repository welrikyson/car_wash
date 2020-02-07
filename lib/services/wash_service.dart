import 'dart:convert';

import 'package:car_wash/models/wash_kind.dart';
import 'package:http/http.dart' as http;

class WashService {
  Future<List<WashKind>> getWashKinds() async{
    final response =
      await http.get('http://ciadopescado.com.br/gap/produto/lavagemGet/?sessionMob=1');
    if (response.statusCode == 200) {
      return WashKind.fromJsonList(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}