import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/select_counselor.dart';

class RecentAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const RecentAppointmentScreen({super.key, required this.userData});

  @override
  _RecentAppointmentScreenState createState() =>
      _RecentAppointmentScreenState();
}

class _RecentAppointmentScreenState extends State<RecentAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Appointments'),
        backgroundColor: Colors.green[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .where('participants', arrayContains: widget.userData['userID'])
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No appointment yet'),
                  if (widget.userData['role'] == 'student')
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CounselorSelectionWidget(
                              identifier: 'appointment',
                              userData: widget.userData,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 236, 247, 236), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        foregroundColor: const Color.fromARGB(255, 5, 82, 23),
                      ),
                      child: const Text('Schedule an appoinment now!'),
                    ),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                // Include a check to ensure the current user is a participant in the conversation
                if (data['participants'].contains(widget.userData['userID'])) {
                  return ListTile(
                    title: Text(data['lastMessage']),
                    subtitle: Text(data['participants']
                        .where((p) => p != widget.userData['userID'])
                        .toString()),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Hide the message if the current user is not a participant
                }
              }).toList(),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
