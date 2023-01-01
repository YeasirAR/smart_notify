import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_notify/database/database.dart';
import 'package:timezone/data/latest_all.dart';
import 'alarm/alarm_info.dart';
import 'homepage.dart';
import 'notiy/noficication.dart';

void main() async {
  await Hive.initFlutter();
  initializeTimeZones();
  NotificationController.initializeLocalNotifications();
  // List<dynamic> alarmList = [];
  // List<AlarmInfo> remList = [];
  var alarmDB = await Hive.openBox('alarmBox');
  var remDB = await Hive.openBox('reminderBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Notify',
      navigatorKey: navigatorKey,
      home: const HomePage(),
    );
  }
}
