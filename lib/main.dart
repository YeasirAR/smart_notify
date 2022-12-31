import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_notify/database/database.dart';
import 'alarm/alarm_info.dart';
import 'homepage.dart';

void main() async {
  await Hive.initFlutter();
  // List<dynamic> alarmList = [];
  // List<AlarmInfo> remList = [];
  var alarmDB = await Hive.openBox('alarmBox');
  var remDB = await Hive.openBox('reminderBox');
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
