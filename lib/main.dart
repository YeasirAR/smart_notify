import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_notify/database/database.dart';
import 'homepage.dart';

void main() async {
  // await Hive.initFlutter();
  // var box = await Hive.openBox('mybox');
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
