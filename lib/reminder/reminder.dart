import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_notify/Reminder/Reminder_info.dart';
import 'package:smart_notify/database/database.dart';
import 'package:smart_notify/homepage.dart';

// import 'createReminder.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  List<ReminderInfo> listItems = [];
  Database db = Database();
  late int listLength;
  String ReminderTitle = 'No Title';
  String ReminderLocation = 'No Location';
  double ReminderRadius = 1;
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    // listItems.add(ReminderInfo("FYDP CLASS", "12:00 PM", true));
    // listItems.add(ReminderInfo("SAD CLASS", "11:30 AM", false));
    // listItems.add(ReminderInfo("MAD CLASS", "10:00 AM", true));
    //listLength = listItems.length;
    super.initState();
  }

  void crateListItem() {
    listItems.add(ReminderInfo(ReminderTitle, _time.format(context), 40, true));
  }

  void crateListItemLocation() {
    listItems.add(ReminderInfo(ReminderTitle, ReminderLocation, 20, true));
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
        Navigator.pop(context);
      });
    }
  }

  void createLocationReminder() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 19, 40, 48),
          content: OpenStreetMapSearchAndPick(
              center: LatLong(23.7980746, 90.4490231),
              buttonColor: Color.fromARGB(255, 37, 54, 68),
              buttonText: 'Set Current Location',
              onPicked: (pickedData) {
                // print(pickedData.latLong.latitude);
                // print(pickedData.latLong.longitude);
                // print(pickedData.address);
                setState(() {
                  ReminderLocation = pickedData.address.substring(0, 20);
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
                      "ADD Reminder",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      ReminderTitle = value;
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
                              createTimeReminder();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 41, 46),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createReminder();
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
                            listItems[index].textSize == 20
                                ? Icons.location_city
                                : Icons.timelapse,
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
                      padding: EdgeInsets.only(
                          left: 15,
                          top: listItems[index].textSize == 20 ? 10 : 0),
                      child: Text(
                        listItems[index].time_location,
                        style: TextStyle(
                            fontSize: listItems[index].textSize,
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
