import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission2/models/listclass.dart';
import 'package:submission2/provider/databaseprovider.dart';
import 'package:submission2/ui/restaurantdetailpage.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Card(
              color: Colors.white70,
              shadowColor: Colors.black,
              child: ListTile(
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeBookmark(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addBookmark(restaurant),
                      ),
                title: Text(restaurant.name),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RestaurantDetailPage(restaurant: restaurant.id);
                  }));
                },
                subtitle: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.amber,
                            size: 15,
                          ),
                          Text(restaurant.city),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.yellow,
                          ),
                          Text(restaurant.rating.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
