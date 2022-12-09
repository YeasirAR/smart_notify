import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_notify/database.dart';
import 'package:smart_notify/homepage.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Database db = Database();
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<bool> val = <bool>[false, true, false];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 41, 46),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 62, 75),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(children: [
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
                        "2:30 PM",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: FlutterSwitch(
                          value: db.info[index],
                          onToggle: (v) {
                            setState(() {
                              db.loadData();
                              db.info[index] = !db.info[index];
                              db.updateDataBase();
                            });
                          },
                        )),
                    const Padding(
                        padding: EdgeInsets.only(left: 15), child: null),
                  ],
                )
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
