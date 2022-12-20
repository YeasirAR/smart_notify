import 'package:flutter/material.dart';

class AlarmInfo {
  String title;
  String time_location;
  //TimeOfDay time;
  double textSize;
  bool isEnabled;
  AlarmInfo(this.title, this.time_location, this.textSize, this.isEnabled);
}
