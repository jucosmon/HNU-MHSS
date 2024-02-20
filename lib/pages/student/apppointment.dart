import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentScheduling(),
    );
  }
}

class AppointmentScheduling extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppointmentScheduling> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 200),
            const Text(
              'Appointment Scheduling',
              style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
              ),
              padding: EdgeInsets.all(20.0),
              height: 75,
              child: Text(
                'Selected Date: ${selectedDate.toLocal()}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
              ),
              padding: EdgeInsets.all(20.0),
              height: 75,
              child: Text('Selected Time: ${selectedTime.format(context)}',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
