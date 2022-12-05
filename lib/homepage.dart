// ignore: file_names
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'nav_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Alarm Page',
      style: optionStyle,
    ),
    Text(
      'Reminder Page',
      style: optionStyle,
    ),
    Text(
      'Timer Page',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: const Text('Smart Notify'),
        //backgroundColor: Color.fromARGB(255, 65, 63, 63),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: NavIcons.alarm,
                  text: 'Alarms',
                ),
                GButton(
                  icon: NavIcons.reminder,
                  text: 'Reminders',
                ),
                GButton(
                  icon: NavIcons.timer,
                  text: 'Timer',
                ),
                GButton(
                  icon: NavIcons.stopwatch,
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
