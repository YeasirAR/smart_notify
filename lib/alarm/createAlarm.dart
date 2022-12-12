import 'package:flutter/material.dart';

class CreateAlarm extends StatefulWidget {
  const CreateAlarm({super.key});

  @override
  State<CreateAlarm> createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          backgroundColor: Color.fromARGB(255, 19, 40, 48),
          content: Container(
            alignment: Alignment.center,
            height: 500,
            width: 400,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
  }
}