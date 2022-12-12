import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_notify/alarm/alarm_info.dart';
import 'package:smart_notify/database/database.dart';
import 'package:smart_notify/homepage.dart';

import 'createAlarm.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  List<AlarmInfo> listItems = [];
  Database db = Database();
  late int listLength;
  String alarmTitle = 'No Title';
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    // listItems.add(AlarmInfo("FYDP CLASS", "12:00 PM", true));
    // listItems.add(AlarmInfo("SAD CLASS", "11:30 AM", false));
    // listItems.add(AlarmInfo("MAD CLASS", "10:00 AM", true));
    //listLength = listItems.length;
    super.initState();
  }

  void crateListItem() {
    listItems.add(AlarmInfo(alarmTitle, _time, true));
  }

  void createTimeAlarm() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        crateListItem();
        Navigator.pop(context);
      });
    }
  }

  void createAlarm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 19, 40, 48),
          content: Container(
              alignment: Alignment.center,
              height: 250,
              width: 400,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "ADD ALARM",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      alarmTitle = value;
                    },
                    decoration: InputDecoration(
                        label: Text("Alarm Title",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Enter alarm title',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 150, 148, 148),
                            fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: SizedBox(
                      width: 500,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 60, 83, 99),
                          ),
                          onPressed: () {
                            setState(() {
                              //Navigator.pop(context);
                              createTimeAlarm();
                            });
                          },
                          child: const Text('Add Time Based Alarm')),
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 60, 83, 99),
                        ),
                        onPressed: (() => {}),
                        child: const Text('Add Location Based Alarm')),
                  ),
                ],
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: listItems.length,
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        listItems[index].title,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        listItems[index].time.format(context),
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
                            value: listItems[index].isEnabled,
                            // value: db.info[index],
                            height: 25,
                            width: 40,
                            onToggle: (v) {
                              setState(() {
                                listItems[index].isEnabled = v;
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
                              setState(() {
                                listItems.removeAt(index);
                              });
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
