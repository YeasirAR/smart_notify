import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_notify/database/database.dart';
import 'package:timezone/data/latest_all.dart';
import 'alarm/alarm_info.dart';
import 'homepage.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await Hive.initFlutter();
  initializeTimeZones();
  // List<dynamic> alarmList = [];
  // List<AlarmInfo> remList = [];
  var alarmDB = await Hive.openBox('alarmBox');
  var remDB = await Hive.openBox('reminderBox');
  AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );
  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosSettings,
  );
  bool? initilized = await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {});
  // print(initilized);
  // if (alarmDB.get("list") == null) {
  //   alarmDB.putAt(0, []);
  // }
  // if (remDB.get("list") == null) {
  //   remDB.put("list", "");
  // }
  // Database db = Database();
  // if (box.get('list') == null) {
  //   db.createInitialData();
  // }
  // db.updateDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Notify',
      home: const HomePage(),
    );
  }
}
