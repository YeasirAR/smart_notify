import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_notify/Reminder/Reminder_info.dart';
import 'package:smart_notify/database/database.dart';
import 'package:smart_notify/database/nav_icons.dart';
import 'package:smart_notify/homepage.dart';
import 'package:timezone/timezone.dart';

import '../main.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  List listItems = [];
  late int listLength;
  String reminderTitle = 'No Title';
  String reminderLocation = 'No Location';
  double reminderRadius = 0.5;
  TimeOfDay _time = TimeOfDay.now();
  final reminderDB = Hive.box('ReminderBox');
  DataBase db = DataBase();
  late double latitude, longitude;
  //late int ReminderID;
  @override
  void initState() {
    // listItems.add(ReminderInfo("FYDP CLASS", "12:00 PM", true));
    // listItems.add(ReminderInfo("SAD CLASS", "11:30 AM", false));
    // listItems.add(ReminderInfo("MAD CLASS", "10:00 AM", true));
    //listLength = listItems.length;
    if (reminderDB.get("id") == null) {
      db.createInitialDataReminder();
    } else {
      db.loadDataReminder();
    }
    // there already exists data
    // db.updateDataBase();
    //db.loadData();

    super.initState();
  }

  void crateListItem() {
    db.reminderID++;
    db.reminderList.add([
      reminderTitle,
      _time.format(context),
      40,
      true,
      false,
      0,
      0,
      0,
      db.reminderID
    ]);
    // ReminderDB.put("list", listItems);
    //ReminderDB.put("list", listItems);
    //print(ReminderDB.get("list"));
    db.updateDataBaseReminder();
    // db.loadData();
  }

  void crateListItemLocation() {
    db.reminderID++;
    db.reminderList.add([
      reminderTitle,
      reminderLocation,
      20,
      true,
      true,
      latitude,
      longitude,
      reminderRadius,
      db.reminderID
    ]);
    // ReminderDB.put("list", listItems);
    // ReminderDB.put("list", listItems);
    db.updateDataBaseReminder();
    // db.loadData();
    // print(ReminderDB.get("list"));
  }

  void createLocationBasedReminder() {
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
                  "ADD LOCATION Reminder",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  reminderTitle = value;
                },
                decoration: const InputDecoration(
                    // icon: Icon(
                    //   Icons.text_fields,
                    //   color: Colors.white,
                    // ),
                    label: Text("Reminder Title",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.white)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: 'Enter Reminder title',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 150, 148, 148),
                        fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    reminderTitle = value;
                  },
                  decoration: const InputDecoration(
                      // icon: Icon(
                      //   Icons.location_city,
                      //   color: Colors.white,
                      // ),
                      label: Text("Reminder Radius",
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
                      hintText: 'Enter Reminder radius in Km',
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
                        latitude = pickedData.latLong.latitude;
                        longitude = pickedData.latLong.longitude;
                        reminderLocation = pickedData.address.substring(0, 20);
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

  void createTimeBasedReminder() {
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
                        "ADD Reminder",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        reminderTitle = value;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.text_fields, color: Colors.white),
                          label: Text("Reminder Title",
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
                          hintText: 'Enter Reminder title',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 150, 148, 148),
                              fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          reminderTitle = value;
                        },
                        focusNode: FocusNode(
                            canRequestFocus: false,
                            descendantsAreFocusable: false),
                        readOnly: true,
                        onTap: () {
                          createTimeReminder();
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
                            hintText: 'Enter Reminder time',
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

  DateTime join(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  void createTimeReminder() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        crateListItem();
        showNotification(join(DateTime.now(), newTime));
        Navigator.pop(context);
      });
    }
  }

  void createLocationReminder() {
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
                  reminderLocation = pickedData.address.substring(0, 20);
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

  void createReminder() {
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
                      "ADD Reminder",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      reminderTitle = value;
                    },
                    decoration: const InputDecoration(
                        label: Text("Reminder Title",
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
                        hintText: 'Enter Reminder title',
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
                              createTimeBasedReminder();
                            });
                          },
                          child: const Text('Add Time Based Reminder')),
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 60, 83, 99),
                        ),
                        onPressed: (() => {createLocationReminder()}),
                        child: const Text('Add Location Based Reminder')),
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
                reminderTitle = "Time Reminder";
                createTimeBasedReminder();
                _key.currentState?.toggle();
              },
              child: const Text("Add Time Based Reminder",
                  style: TextStyle(fontSize: 15))),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 60, 83, 99),
              ),
              onPressed: () {
                reminderTitle = "Location Reminder";
                createLocationBasedReminder();
                _key.currentState?.toggle();
              },
              child: const Text(
                "Location  Based  Reminder",
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
          itemCount: db.reminderList.length,
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
                                db.reminderList[index][2].toDouble() == 20
                                    ? Icons.location_pin
                                    : NavIcons.reminder,
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
                            db.reminderList[index][0],
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              top: db.reminderList[index][2] == 20 ? 10 : 0),
                          child: Text(
                            db.reminderList[index][1],
                            style: TextStyle(
                                fontSize: db.reminderList[index][2].toDouble(),
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
                                value: db.reminderList[index][3],
                                // value: db.info[index],
                                height: 25,
                                width: 40,
                                onToggle: (v) {
                                  setState(() {
                                    db.reminderList[index][3] = v;
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
                                    db.reminderList.removeAt(index);
                                    db.updateDataBaseReminder();
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

  void showNotification(DateTime scheduleDate) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "OPEN UP ", "ITS FCUKING FBI",
        priority: Priority.max, importance: Importance.max);

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));
    // DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(db.reminderID, "OPEN UP ",
        "ITS FCUKING FBI", TZDateTime.from(scheduleDate, local), notiDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload");
  }

  // void checkForNotification() async {
  //   NotificationAppLaunchDetails? details =
  //       await notificationsPlugin.getNotificationAppLaunchDetails();

  //   if (details != null) {
  //     if (details.didNotificationLaunchApp) {
  //       NotificationResponse? response = details.notificationResponse;

  //       if (response != null) {
  //         String? payload = response.payload;
  //       }
  //     }
  //   }
  // }
}
