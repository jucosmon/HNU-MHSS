import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/display_messages.dart';

class OpenMessagePage extends StatefulWidget {
  final String counselorId;
  final Map<String, dynamic> userData;

  const OpenMessagePage({
    super.key,
    required this.userData,
    required this.counselorId,
  });

  @override
  State<OpenMessagePage> createState() => _OpenMessagePageState();
}

class _OpenMessagePageState extends State<OpenMessagePage> {
  Map<String, dynamic>? counselorData;

  @override
  void initState() {
    super.initState();
    fetchCounselorData();
  }

  void fetchCounselorData() async {
    DocumentSnapshot<Map<String, dynamic>> counselorSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.counselorId)
            .get();

    if (counselorSnapshot.exists) {
      setState(() {
        counselorData = counselorSnapshot.data();
      });
    } else {
      // Handle the case when counselor data is not found
      print('Counselor not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name =
        '${counselorData?['first name'] ?? 'Loading'} ${counselorData?['last name'] ?? ''}';
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon:
              const Icon(CupertinoIcons.back), // You can use a custom icon here
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecentMessagesScreen(userData: widget.userData),
              ),
              ModalRoute.withName('/'),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildMessage(
                    isSender: false,
                    message: 'Hello, how can I help you today?'),
                _buildMessage(
                    isSender: true,
                    message: 'Hi, I need some advice on managing stress.'),
                // Add more messages here
              ],
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage({required bool isSender, required String message}) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSender ? Colors.green[600] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSender ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              // Implement logic to send messages to Firestore
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Implement logic to send the message to Firestore
            },
          ),
        ],
      ),
    );
  }
}
