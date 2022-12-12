import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_notify/database/database.dart';
import 'package:smart_notify/homepage.dart';

import 'createAlarm.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  List<bool> val = [false, true, false];
  Database db = Database();
  void createTimeAlarm() async {
    TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
  }

  void createAlarm() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateAlarm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 41, 46),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAlarm();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 62, 75),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Icon(
                            Icons.text_snippet_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(
                            Icons.timelapse,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Fydp Class",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "12:30 PM",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: FlutterSwitch(
                            value: val[index],
                            // value: db.info[index],
                            height: 25,
                            width: 40,
                            onToggle: (v) {
                              setState(() {
                                val[index] = v;
                                // db.loadData();
                                // db.info[index] = !db.info[index];
                                // db.updateDataBase();
                              });
                            },
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: IconButton(
                            icon: Icon(Icons.delete_rounded),
                            color: Colors.white,
                            iconSize: 32,
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        )),
                  ],
                ),
              ]),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
