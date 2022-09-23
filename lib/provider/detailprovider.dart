import 'dart:io';

import 'package:flutter/material.dart';
import 'package:submission2/apiservice/apiservice.dart';
import 'package:submission2/models/detailclass.dart';
import 'package:submission2/provider/listprovider.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final Service service;
  final String id;

  late DetailRestaurantResult _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.service}) {
    getDetail(id);
  }

  DetailRestaurantResult get result => _detailRestaurant;
  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> getDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await service.getAllDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No internet";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
