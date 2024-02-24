import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/display_appointments.dart';

class AppointmentScheduling extends StatefulWidget {
  final String counselorId;
  final Map<String, dynamic> userData;

  const AppointmentScheduling(
      {super.key, required this.userData, required this.counselorId});

  @override
  _AppointmentSchedulingState createState() => _AppointmentSchedulingState();
}

class _AppointmentSchedulingState extends State<AppointmentScheduling> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _notesController = TextEditingController();
  bool dateSelected = false;
  bool timeSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      /*
      selectableDayPredicate: (DateTime date) {
        // Allow selection of weekdays (Monday to Friday)
        return date.weekday >= DateTime.monday &&
            date.weekday <= DateTime.friday;
      },
      */
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateSelected = true;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      // Validate time to be between 1 pm to 5 pm
      if (picked.hour >= 13 && picked.hour <= 17) {
        setState(() {
          selectedTime = picked;
          timeSelected = true; // Set timeSelected to true
        });
      } else {
        // Show an error message for invalid time selection
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time between 1 pm to 5 pm'),
          ),
        );
      }
    }
  }

  void _submitAppointment() {
    // Add logic to submit the appointment request with selectedDate, selectedTime, and _notesController.text
    // For example, you can send this information to the backend for further processing
    print('Appointment Confirmed');
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment with Counselor 1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecentAppointmentScreen(userData: widget.userData),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Select Date:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                      dateSelected
                          ? 'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}'
                          : 'Choose Date',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Select Time:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                      timeSelected
                          ? 'Selected Time: ${selectedTime.format(context)}'
                          : 'Choose Time',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Additional Details:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        'Enter any specific requirements or topics to discuss',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Confirm Appointment',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 212, 226, 212),
    );
  }
}
