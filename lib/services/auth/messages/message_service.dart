import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<DocumentSnapshot>> getRecentMessages() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('conversations')
          .where('participants', arrayContains: user.uid)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs;
    } else {
      // Handle the case where the user is not authenticated
      return [];
    }
  }
}
