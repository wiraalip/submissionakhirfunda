import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:submission2/apiservice/apiservice.dart';
import 'package:submission2/models/searchclass.dart';
import 'package:submission2/provider/listprovider.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final Service service;

  SearchRestaurantProvider({required this.service}) {
    fetchRestaurant(search);
  }

  ResultState? _state;
  SearchRestaurantResult? _restaurantResult;
  String _message = '';
  String _search = '';

  ResultState? get state => _state;
  SearchRestaurantResult? get result => _restaurantResult;
  String get message => _message;
  String get search => _search;

  Future<dynamic> fetchRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = ResultState.loading;
        _search = search;
        notifyListeners();
        final restaurant = await service.getSearch(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No Restaurant Found';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'No Text';
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
