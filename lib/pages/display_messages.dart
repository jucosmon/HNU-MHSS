import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/open_message.dart';
import 'package:mentalhealth_support_system/pages/select_counselor.dart';

class RecentMessagesScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const RecentMessagesScreen({super.key, required this.userData});

  @override
  _RecentMessagesScreenState createState() => _RecentMessagesScreenState();
}

class _RecentMessagesScreenState extends State<RecentMessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Messages'),
        backgroundColor: Colors.green[400],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('conversations')
            .where('participants', arrayContains: widget.userData['uid'])
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
                  const Text('No messages yet'),
                  if (widget.userData['role'] == 'student')
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CounselorSelectionWidget(
                              identifier: "message",
                              userData: widget.userData,
                            ); // Display the counselor selection widget
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
                      child: const Text('Message a counselor now!'),
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
                if (data['participants'].contains(widget.userData['uid'])) {
                  String otherParticipantId = data['participants']
                      .firstWhere((p) => p != widget.userData['uid']);
                  String firstName =
                      ""; // Retrieve the first name of the other participant
                  String lastName =
                      ""; // Retrieve the last name of the other participant
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(otherParticipantId)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (userSnapshot.hasData && userSnapshot.data!.exists) {
                          Map<String, dynamic> userData =
                              userSnapshot.data!.data() as Map<String, dynamic>;
                          firstName = userData[
                              'first name']; // Assign the first name from the user data
                          lastName = userData[
                              'last name']; // Assign the last name from the user data
                        }
                        return ListTile(
                          title: Text(data['lastMessage']),
                          subtitle: Text('$firstName $lastName'),
                          onTap: () {
                            // Navigate to the open messages screen for the selected conversation
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpenMessagePage(
                                  userData: widget.userData,
                                  counselorId: otherParticipantId,
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Hide the message if the current user is not a participant
                      }
                    },
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
      floatingActionButton: widget.userData['role'] == 'student'
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CounselorSelectionWidget(
                      identifier: "message",
                      userData: widget.userData,
                    );
                  },
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.message),
            )
          : null,
    );
  }
}
