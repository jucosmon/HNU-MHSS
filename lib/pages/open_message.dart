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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counselor 1'),
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon:
              const Icon(CupertinoIcons.back), // You can use a custom icon here
          onPressed: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Pop all routes until the main page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecentMessagesScreen(userData: widget.userData),
              ),
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
