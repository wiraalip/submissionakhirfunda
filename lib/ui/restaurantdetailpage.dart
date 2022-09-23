import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:submission2/apiservice/apiservice.dart';

import 'package:submission2/provider/detailprovider.dart';
import 'package:submission2/provider/listprovider.dart';
import 'package:submission2/widget/restaurantdetail.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurantdetail';
  final String restaurant;
  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Restaurant'),
      ),
      body: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) => DetailRestaurantProvider(
            service: Service(Client()), id: restaurant),
        child: Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            final restaurants = state.result.restaurants;
            return RestaurantDetailWidget(restaurant: restaurants);
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text('No Internet Connection'),
            );
          }
        }),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
