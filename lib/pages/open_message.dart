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
  String conversationId =
      'your_conversation_id'; // Replace with the actual conversation ID

  @override
  void initState() {
    super.initState();
    fetchCounselorData();
    fetchConversationId();
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

  void fetchConversationId() async {
    // Query Firestore to find the conversation ID based on the counselor ID and user ID
    QuerySnapshot conversationSnapshot = await FirebaseFirestore.instance
        .collection('conversations')
        .where('participants', arrayContains: widget.counselorId)
        .get();

    if (conversationSnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot conversation in conversationSnapshot.docs) {
        List<dynamic> participants = conversation['participants'];
        if (participants.contains(widget.userData['uid'])) {
          setState(() {
            conversationId = conversation.id;
          });
          break; // Exit the loop once the conversation is found
        }
      }
    } else {
      // Handle the case when conversation is not found
      print('Conversation not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name =
        '${counselorData?['first name'] ?? 'Loading'} ${counselorData?['last name'] ?? '...'}';
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.green[400],
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .collection('messages')
            .orderBy('timestamp')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> messageData =
                          messages[index].data() as Map<String, dynamic>;
                      bool isSender =
                          messageData['senderId'] == widget.userData['uid'];
                      String message = messageData['message'];
                      return _buildMessage(
                          isSender: isSender, message: message);
                    },
                  ),
                ),
                _buildInputField(),
              ],
            );
          } else {
            return const Center(child: Text('No messages available'));
          }
        },
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
    TextEditingController messageController = TextEditingController();

    void sendMessage() async {
      String message = messageController.text.trim();
      if (message.isNotEmpty) {
        // Generate a unique message ID
        String messageId =
            FirebaseFirestore.instance.collection('conversations').doc().id;

        // Get the current user ID
        String userId =
            widget.userData['uid']; // Retrieve the userId from widget.userData

        // Update the last message and timestamp of the conversation collection
        await FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .update({
          'lastMessage': message,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Send the message to Firestore
        await FirebaseFirestore.instance
            .collection('conversations')
            .doc(conversationId)
            .collection('messages')
            .doc(messageId)
            .set({
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
          'senderId': userId,
        });

        // Clear the text field after sending the message
        messageController.clear();
      }
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(),
              ),
              // Implement logic to send messages to Firestore
              onSubmitted: (_) => sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
