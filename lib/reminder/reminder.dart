import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_notify/alarm/alarm_info.dart';
import 'package:smart_notify/database/database.dart';
import 'package:smart_notify/database/nav_icons.dart';
import 'package:smart_notify/homepage.dart';


class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  List listItems = [];
  late int listLength;
  String alarmTitle = 'No Title';
  String alarmLocation = 'No Location';
  double alarmRadius = 1;
  TimeOfDay _time = TimeOfDay.now();
  final alarmDB = Hive.box('alarmBox');
  DataBase db = DataBase();
  @override
  void initState() {
    // listItems.add(AlarmInfo("FYDP CLASS", "12:00 PM", true));
    // listItems.add(AlarmInfo("SAD CLASS", "11:30 AM", false));
    // listItems.add(AlarmInfo("MAD CLASS", "10:00 AM", true));
    //listLength = listItems.length;
    if (alarmDB.get("list") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    // there already exists data
    // db.updateDataBase();
    //db.loadData();

    super.initState();
  }

  void crateListItem() {
    db.alarmList.add([alarmTitle, _time.format(context), 40, true]);
    // alarmDB.put("list", listItems);
    //alarmDB.put("list", listItems);
    //print(alarmDB.get("list"));
    db.updateDataBase();
    // db.loadData();
  }

  void crateListItemLocation() {
    db.alarmList.add([alarmTitle, alarmLocation, 20, true]);
    // alarmDB.put("list", listItems);
    // alarmDB.put("list", listItems);
    db.updateDataBase();
    // db.loadData();
    // print(alarmDB.get("list"));
  }

  void createLocationBasedAlarm() {
    showBarModalBottomSheet(
      context: context,
      backgroundColor: Color.fromARGB(255, 49, 63, 72),
      builder: (context) => SizedBox(
        //height: 500,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "ADD LOCATION ALARM",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  alarmTitle = value;
                },
                decoration: const InputDecoration(
                    // icon: Icon(
                    //   Icons.text_fields,
                    //   color: Colors.white,
                    // ),
                    label: Text("Alarm Title",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.white)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Enter alarm title',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 150, 148, 148),
                        fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    alarmTitle = value;
                  },
                  decoration: const InputDecoration(
                      // icon: Icon(
                      //   Icons.location_city,
                      //   color: Colors.white,
                      // ),
                      label: Text("Alarm Radius",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.white)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: 'Enter alarm radius in Km',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 150, 148, 148),
                          fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 500,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 2, right: 2),
                  child: OpenStreetMapSearchAndPick(
                    center: LatLong(23.7980746, 90.4490231),
                    buttonColor: const Color.fromARGB(255, 37, 54, 68),
                    buttonText: 'Set Current Location',
                    onPicked: (pickedData) {
                      // print(pickedData.latLong.latitude);
                      // print(pickedData.latLong.longitude);
                      // print(pickedData.address);
                      setState(() {
                        alarmLocation = pickedData.address.substring(0, 20);
                        crateListItemLocation();
                        Navigator.pop(context);
                        // Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dtp() {}
  void createTimeBasedAlarm() {
    showBarModalBottomSheet(
        context: context,
        backgroundColor: Color.fromARGB(255, 49, 63, 72),
        builder: (context) => SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "ADD ALARM",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        alarmTitle = value;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.text_fields, color: Colors.white),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          alarmTitle = value;
                        },
                        focusNode: FocusNode(
                            canRequestFocus: false,
                            descendantsAreFocusable: false),
                        readOnly: true,
                        onTap: () {
                          createTimeAlarm();
                        },
                        decoration: const InputDecoration(
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            label: Text("Pick Time",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: 'Enter alarm time',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 150, 148, 148),
                                fontSize: 20)),
                      ),
                    )
                  ],
                ),
              ),
            ));
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

  void createLocationAlarm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 19, 40, 48),
          content: OpenStreetMapSearchAndPick(
              center: LatLong(23.7980746, 90.4490231),
              buttonColor: const Color.fromARGB(255, 37, 54, 68),
              buttonText: 'Set Current Location',
              onPicked: (pickedData) {
                // print(pickedData.latLong.latitude);
                // print(pickedData.latLong.longitude);
                // print(pickedData.address);
                setState(() {
                  alarmLocation = pickedData.address.substring(0, 20);
                  crateListItemLocation();
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }),
          title: const Text(
            "Pick a location",
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  void createAlarm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 19, 40, 48),
          content: Container(
              alignment: Alignment.center,
              height: 250,
              width: 400,
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "ADD ALARM",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      alarmTitle = value;
                    },
                    decoration: const InputDecoration(
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
                              createTimeBasedAlarm();
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
                        onPressed: (() => {createLocationAlarm()}),
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

  final _key = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 41, 46),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        backgroundColor: Colors.blueGrey,
        closeButtonStyle: const ExpandableFabCloseButtonStyle(
            backgroundColor: Colors.red,
            child: Icon(Icons.close, color: Colors.white)),
        onOpen: () {},
        key: _key,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 60, 83, 99),
              ),
              onPressed: () {
                alarmTitle = "Time Alarm";
                createTimeBasedAlarm();
                _key.currentState?.toggle();
              },
              child: const Text("Add Time Based Alarm",
                  style: TextStyle(fontSize: 15))),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 60, 83, 99),
              ),
              onPressed: () {
                alarmTitle = "Location Alarm";
                createLocationBasedAlarm();
                _key.currentState?.toggle();
              },
              child: const Text(
                "Location  Based  Alarm",
                style: TextStyle(fontSize: 15),
              )),
        ],
        child: const Icon(Icons.add, color: Colors.white),
        type: ExpandableFabType.up,
        distance: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.separated(
          itemCount: db.alarmList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 62, 75),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0),
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
                                db.alarmList[index][2].toDouble() == 20
                                    ? Icons.location_pin
                                    : NavIcons.alarm,
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
                            db.alarmList[index][0],
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              top: db.alarmList[index][2] == 20 ? 10 : 0),
                          child: Text(
                            db.alarmList[index][1],
                            style: TextStyle(
                                fontSize: db.alarmList[index][2].toDouble(),
                                color: Colors.white),
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
                                value: db.alarmList[index][3],
                                // value: db.info[index],
                                height: 25,
                                width: 40,
                                onToggle: (v) {
                                  setState(() {
                                    db.alarmList[index][3] = v;
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
                                    db.alarmList.removeAt(index);
                                    db.updateDataBase();
                                    // db.loadData();
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
