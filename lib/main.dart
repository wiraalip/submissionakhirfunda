import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission2/common/navigation.dart';
import 'package:submission2/database/db_helper.dart';
import 'package:submission2/notification/notificationhelper.dart';
import 'package:submission2/preferences/preferences_helper.dart';
import 'package:submission2/provider/databaseprovider.dart';
import 'package:submission2/provider/preferencesprovider.dart';
import 'package:submission2/provider/schedulingprovider.dart';
import 'package:submission2/ui/homescreen.dart';
import 'package:submission2/ui/restaurantdetailpage.dart';
import 'package:submission2/ui/restaurantlistpage.dart';
import 'package:submission2/utils/backgroundservices.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          navigatorKey: navigatorKey,
          routes: {
            RestaurantListPage.routeName: (context) =>
                const RestaurantListPage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  restaurant:
                      ModalRoute.of(context)!.settings.arguments as String,
                )
          },
          home: const RestaurantHomeScreen(),
        );
      }),
    );
  }
}
