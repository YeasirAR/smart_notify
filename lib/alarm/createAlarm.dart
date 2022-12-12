import 'package:flutter/material.dart';

class CreateAlarm extends StatefulWidget {
  const CreateAlarm({super.key});

  @override
  State<CreateAlarm> createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  TimeOfDay _time = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    void createTimeAlarm() async {
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _time,
      );
      if (newTime != null) {
        setState(() {
          _time = newTime;
          Navigator.pop(context);
        });
      }
      //print(_time.format(context));
    }

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
                onChanged: (value) {},
                decoration: InputDecoration(
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
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: SizedBox(
                  width: 500,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 60, 83, 99),
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
                      backgroundColor: const Color.fromARGB(255, 60, 83, 99),
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
  }
}
