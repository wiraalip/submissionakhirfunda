import 'package:flutter/material.dart';
import 'package:submission2/ui/bookmarkpage.dart';
import 'package:submission2/ui/restaurantdetailpage.dart';
import 'package:submission2/ui/restaurantlistpage.dart';
import 'package:submission2/ui/restaurantsearchpage.dart';
import 'package:submission2/ui/settingpage.dart';

import '../notification/notificationhelper.dart';

class RestaurantHomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => RestaurantHomeScreenState();
}

class RestaurantHomeScreenState extends State<RestaurantHomeScreen> {
  int _selectedIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> _option = <Widget>[
    const RestaurantListPage(),
    const RestaurantSearchPage(),
    const BookmarkPage(),
    const SettingPage(),
  ];

  void _onTapped(int Index) {
    setState(() {
      _selectedIndex = Index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restaurant')),
      body: _option.elementAt(_selectedIndex),
      bottomNavigationBar: _makeBottomNavigationBar(),
    );
  }

  Widget _makeBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(label: 'home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'search', icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: 'bookmark', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(label: 'setting', icon: Icon(Icons.settings)),
      ],
      onTap: (Index) {
        _onTapped(Index);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject('/restaurantdetail');
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
