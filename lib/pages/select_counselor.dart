import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/open_message.dart';
import 'package:mentalhealth_support_system/pages/student/apppointment.dart';

class CounselorSelectionWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String identifier;

  const CounselorSelectionWidget(
      {super.key, required this.identifier, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a Counselor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'counselor')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> counselors =
                      snapshot.data!.docs.toList();
                  return ListView.builder(
                    itemCount: counselors.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot counselor = counselors[index];
                      return GestureDetector(
                        onTap: () {
                          _showConfirmationDialog(context,
                              counselorId: counselor['uid']);
                        },
                        child: CounselorCard(
                          name:
                              '${counselor['first name']} ${counselor['last name']}',
                          profession: counselor['profession'],
                          overview: counselor['overview'],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context,
      {required String counselorId}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Selection'),
          content: const Text('Are you sure you choose this counselor?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Return the selected counselor's ID or data
                Navigator.of(context).pop(counselorId);
                if (identifier == 'appointment') {
                  // Navigate to the appointment scheduling page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScheduling(
                        userData: userData,
                        counselorId: 'counselorId',
                      ),
                    ),
                  );
                } else {
                  // Navigate to open a message page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpenMessagePage(
                              userData: userData,
                              counselorId: 'counselorId',
                            )),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class CounselorCard extends StatelessWidget {
  final String name;
  final String profession;
  final String overview;

  const CounselorCard({
    super.key,
    required this.name,
    required this.profession,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              profession,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 100, // Set a fixed height for the overview
              child: Text(
                overview,
                maxLines: 3, // Limit the number of lines
                overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
