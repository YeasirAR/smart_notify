import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 41, 46),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 60, 83, 99),
                      ),
                      onPressed: (() => {}),
                      child: const Text('Add Time Based Reminder')),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 60, 83, 99),
                      ),
                      onPressed: (() => {}),
                      child: const Text('Add Location Based Reminder')),
                ),
              ]),
        ),
      ),
    );
  }
}
