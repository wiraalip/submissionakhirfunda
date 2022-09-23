import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:submission2/apiservice/apiservice.dart';
import 'package:submission2/provider/listprovider.dart';
import 'package:submission2/widget/restaurantlist.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurantlist';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(service: Service(Client())),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('No Internet Connection'),
            );
          }
        },
      ),
    );
  }
}
