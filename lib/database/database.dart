import 'package:hive_flutter/hive_flutter.dart';

class DataBase {
  List<dynamic> alarmList = [];
  List<dynamic> reminderList = [];
  final alarmDB = Hive.box('alarmBox');
  final reminderDB = Hive.box('reminderBox');
  int alarmID = 0;
  int reminderID = 1000;

  void createInitialDataAlarm() {
    // alarmList = [
    //   ["Time Alarm", "12:00 PM", 40, false, false, 0, 0, 0],
    //   //title -- time/lication -- font size -- isEnabled -- islocation -- lat--long --rad
    //   [
    //     "Location Alarm",
    //     "UIU Playground",
    //     20,
    //     false,
    //     true,
    //     23.798811,
    //     90.449632,
    //     0.5
    //   ],
    // ];
    alarmID = 0;
  }

  void createInitialDataReminder() {
    // reminderList = [
    //   ["Time Reminder", "12:00 PM", 40, false, false, 0, 0, 0],
    //   [
    //     "Location Reminder",
    //     "UIU Playground",
    //     20,
    //     false,
    //     true,
    //     23.798811,
    //     90.449632,
    //     0.5
    //   ],
    // ];
    reminderID = 1000;
  }

  void loadDataAlarm() {
    alarmList = alarmDB.get("list");
    alarmID = alarmDB.get("id");
  }

  void updateDataBaseAlarm() {
    alarmDB.put("list", alarmList);
    alarmDB.put("id", alarmID);
  }

  void loadDataReminder() {
    reminderList = reminderDB.get("list");
    reminderID = reminderDB.get("id");
  }

  void updateDataBaseReminder() {
    reminderDB.put("list", reminderList);
    reminderDB.put("id", reminderID);
  }
}
