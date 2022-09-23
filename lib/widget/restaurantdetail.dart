import 'package:flutter/material.dart';
import 'package:submission2/models/detailclass.dart';

class RestaurantDetailWidget extends StatelessWidget {
  static const routeName = 'restaurantdetail';

  final Restaurant restaurant;

  const RestaurantDetailWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}')),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              restaurant.name,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 17),
                    Text(
                      restaurant.rating.toString(),
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 17,
                        color: Colors.red,
                      ),
                      Text(
                        restaurant.address,
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Description : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(restaurant.description),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Menu :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'Foods',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text('Drinks',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurant.menus.foods.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ListTile(
                      selectedTileColor: Colors.amber,
                      title: Text(
                        restaurant.menus.foods[index].name,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 100,
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurant.menus.drinks.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ListTile(
                      selectedTileColor: Colors.amber,
                      title: Text(
                        restaurant.menus.drinks[index].name,
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Comment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          ListBody(
            children: restaurant.customerReviews.map((review) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text(
                          review.name.characters.elementAt(0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.name),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(review.date,
                                style: TextStyle(fontSize: 12)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(review.review),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      )),
    );
  }
}
