import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List<dynamic> alarmList = [];
  List<dynamic> reminderList = [];
  final alarmDB = Hive.box('alarmBox');
  final reminderDB = Hive.box('reminderBox');

  void createInitialDataAlarm() {
    alarmList = [
      ["Alarm Title", "12:00 PM", 40, false],
      ["Alarm Title", "9:00 AM", 40, false],
    ];
  }

  void createInitialDataReminder() {
    reminderList = [
      ["Reminder Title", "12:00 PM", 40, false],
      ["Reminder Title", "9:00 AM", 40, false],
    ];
  }

  void loadDataAlarm() {
    alarmList = alarmDB.get("list");
  }

  void updateDataBaseAlarm() {
    alarmDB.put("list", alarmList);
  }

  void loadDataReminder() {
    reminderList = reminderDB.get("list");
  }

  void updateDataBaseReminder() {
    reminderDB.put("list", reminderList);
  }
}
