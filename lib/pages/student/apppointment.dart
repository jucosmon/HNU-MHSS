import 'package:flutter/material.dart';

class MyAppointment extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MyAppointment({super.key, required this.userData});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentScheduling(
        userData: userData,
      ),
    );
  }
}

class AppointmentScheduling extends StatefulWidget {
  final Map<String, dynamic> userData;

  const AppointmentScheduling({super.key, required this.userData});
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
      appBar: AppBar(
        title: const Text('Appointment',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.deepPurple[400],
        /*leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentHomePage(,),
              ),
            );
          },
        ), */
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 50),
            const Text(
              'Appointment Scheduling',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20.0),
              height: 75,
              child: Text(
                'Selected Time: ${selectedTime.format(context)}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
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
