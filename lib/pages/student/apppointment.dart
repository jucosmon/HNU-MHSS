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
  _StudentHomePage createState() => _StudentHomePage();
}

class _StudentHomePage extends State<AppointmentScheduling> {
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
        title: const Text(
          'Appointment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        automaticallyImplyLeading: true,
        actions: [
          // Three-dots icon
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add three-dots icon here
              showPopupMenu(context);
            },
          ),
        ],
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
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20.0),
              height: 75,
              child: Text(
                'Selected Date: ${selectedDate.toLocal()}',
                style: const TextStyle(
                    fontSize: 20, color: Colors.black), // Black font color
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[200], // Background color
              ),
              child: const Text('Select Date',
                  style: TextStyle(color: Colors.black)), // Black font color
            ),
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20.0),
              height: 75,
              child: Text(
                'Selected Time: ${selectedTime.format(context)}',
                style: const TextStyle(
                    fontSize: 20, color: Colors.black), // Black font color
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[200], // Background color
              ),
              child: const Text('Select Time',
                  style: TextStyle(color: Colors.black)), // Black font color
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }

  // Add this method to show the popup menu
  void showPopupMenu(BuildContext context) {
    // Show a popup menu
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 80.0, 0.0, 0.0),
      items: [
        const PopupMenuItem(
          child: Text('Home'),
          // Add your action for Option 1 here
        ),
        const PopupMenuItem(
          child: Text('Profile'),
          // Add your action for Option 2 here
        ),
        const PopupMenuItem(
          child: Text('Check in'),
          // Add your action for Option 2 here
        ),
        // Add more options as needed
      ],
    );
  }
}
