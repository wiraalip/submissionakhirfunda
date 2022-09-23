import 'dart:convert';

import 'package:submission2/models/detailclass.dart';
import 'package:submission2/models/listclass.dart';
import 'package:http/http.dart' as http;
import 'package:submission2/models/searchclass.dart';

class Service {
  final http.Client client;

  Service(this.client);

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<Welcome> getAllData() async {
    final response = await client.get(Uri.parse('${_baseUrl}list'));
    if (response.statusCode == 200) {
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }

  Future<DetailRestaurantResult> getAllDetail(String id) async {
    final response = await client.get(Uri.parse('${_baseUrl}detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }

  Future<SearchRestaurantResult> getSearch(String query) async {
    final response = await client.get(Uri.parse('${_baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }
  }
}
