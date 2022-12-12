import 'package:flutter/material.dart';

class ReminderInfo {
  String title;
  TimeOfDay time;
  bool isEnabled;
  ReminderInfo(this.title, this.time, this.isEnabled);
}
