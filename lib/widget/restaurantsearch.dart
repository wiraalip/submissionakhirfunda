import 'package:flutter/material.dart';
import 'package:submission2/models/searchclass.dart';
import 'package:submission2/ui/restaurantdetailpage.dart';

class RestaurantSearch extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantSearch({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RestaurantDetailPage(restaurant: restaurant.id);
        }));
      },
      child: Card(
        child: Row(children: <Widget>[
          Expanded(
            child: Hero(
              tag: restaurant.pictureId,
              child: Container(
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                restaurant.name,
              )
            ],
          ))
        ]),
      ),
    );
  }
}
