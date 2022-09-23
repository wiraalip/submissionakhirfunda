import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:submission2/apiservice/apiservice.dart';
import 'package:submission2/models/listclass.dart';

enum ResultState { loading, error, noData, hasData }

class RestaurantProvider extends ChangeNotifier {
  final Service service;

  RestaurantProvider({required this.service}) {
    _fetchAllRestaurant();
  }

  late Welcome _welcome;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Welcome get result => _welcome;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await service.getAllData();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _welcome = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
