import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:submission2/apiservice/apiservice.dart';
import 'package:submission2/provider/listprovider.dart';
import 'package:submission2/provider/restaurantprovider.dart';
import 'package:submission2/widget/restaurantsearch.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController controller = TextEditingController();
  String output = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(service: Service(Client())),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          return Scaffold(
            body: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search_outlined,
                          )),
                      onChanged: (String query) {
                        if (query.isNotEmpty) {
                          setState(() {
                            output = query;
                          });
                          state.fetchRestaurant(output);
                        }
                      },
                    ),
                  ),
                ),
                (output.isEmpty)
                    ? const Center(
                        child: Text('Search Restaurant'),
                      )
                    : Consumer<SearchRestaurantProvider>(
                        builder: ((context, state, _) {
                        if (state.state == ResultState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultState.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.result!.restaurants.length,
                            itemBuilder: (context, index) {
                              var resto = state.result!.restaurants[index];
                              return RestaurantSearch(restaurant: resto);
                            },
                          );
                        } else if (state.state == ResultState.noData) {
                          return Center(child: Text(state.message));
                        } else if (state.state == ResultState.error) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(
                            child: Text('No Internet'),
                          );
                        }
                      }))
              ],
            )),
          );
        },
      ),
    );
  }
}
