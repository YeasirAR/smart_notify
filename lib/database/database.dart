import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List<dynamic> alarmList = [];

  // reference our box
  final _myBox = Hive.box('alarmBox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    alarmList = [
      ["Alarm Title", "9:45 AM", 40, true],
      ["Alarm Title", "9:45 AM", 40, true],
    ];
  }

  // load the data from database
  void loadData() {
    alarmList = _myBox.get("list");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("list", alarmList);
  }
}
