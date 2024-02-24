import 'package:flutter/material.dart';

class CounselorSelectionWidget extends StatelessWidget {
  const CounselorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose a Counselor to Message',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, counselorId: 'counselor1Id');
            },
            child: const CounselorCard(
              name: 'John Doe',
              profession: 'Licensed Therapist',
              overview:
                  'Experienced in individual and group counseling for various mental health issues.',
            ),
          ),
          // Add more GestureDetector widgets for additional counselors
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
          content:
              const Text('Are you sure you want to message this counselor?'),
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
            Text(overview),
          ],
        ),
      ),
    );
  }
}
