// ignore: file_names
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'alarm/alarm.dart';
import 'database/nav_icons.dart';
import 'reminder/reminder.dart';
import 'timer/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool val = true;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Alarm(),
    Reminder(),
    Text(
      "Timer",
      style: optionStyle,
    ),
    Text(
      'Stopwatch Page',
      style: optionStyle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 41, 46),
      appBar: AppBar(
        elevation: 20,
        title: const Text('Smart Notify'),
        backgroundColor: Color.fromARGB(255, 36, 49, 58),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 36, 49, 58),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: Color.fromARGB(255, 36, 49, 58),
              rippleColor: Color.fromARGB(255, 38, 54, 63)!,
              hoverColor: Color.fromARGB(255, 32, 42, 48)!,
              gap: 8,
              activeColor: Color.fromARGB(255, 255, 255, 255),
              iconSize: 24,
              textSize: 1,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromARGB(255, 50, 65, 75)!,
              color: Color.fromARGB(255, 0, 0, 0),
              tabs: const [
                GButton(
                  icon: NavIcons.alarm,
                  iconColor: Colors.white,
                  text: 'Alarms',
                ),
                GButton(
                  icon: NavIcons.reminder,
                  iconColor: Colors.white,
                  text: 'Reminders',
                ),
                GButton(
                  icon: NavIcons.timer,
                  iconColor: Colors.white,
                  text: 'Timer',
                ),
                GButton(
                  icon: NavIcons.stopwatch,
                  iconColor: Colors.white,
                  text: 'Stopwatch',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
  // bottomNavigationBar: Container(
  //   color: Colors.black,
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
  //     child: GNav(
  //       backgroundColor: Colors.black,
  //       color: Colors.white,
  //       activeColor: Colors.white,
  //       tabBackgroundColor: Colors.grey.shade800,
  //       gap: 8,
  //       padding: EdgeInsets.all(10),
  //       onTabChange: (index) {
  //         print(index);
  //       },
  //       tabs: const [
  //         GButton(icon: Icons.alarm, text: 'Alarm'),
  //         GButton(icon: Icons.lock_clock, text: 'Reminder'),
  //         GButton(icon: Icons.timer, text: 'Timer'),
  //         GButton(icon: Icons.alarm, text: 'Stopwatch'),
  //       ],
  //     ),
  //   ),
  // ),
