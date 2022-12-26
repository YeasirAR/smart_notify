import 'package:flutter/material.dart';

class ReminderInfo {
  String title;
  String time_location;
  //TimeOfDay time;
  double textSize;
  bool isEnabled;
  ReminderInfo(this.title, this.time_location, this.textSize, this.isEnabled);
}
