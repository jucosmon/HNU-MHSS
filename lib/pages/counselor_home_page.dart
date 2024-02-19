import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class CounselorHomePage extends StatefulWidget {
  const CounselorHomePage({super.key});

  @override
  State<CounselorHomePage> createState() => _CounselorHomePageState();
}

class _CounselorHomePageState extends State<CounselorHomePage> {
  //sign out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counselor"),
        backgroundColor: Colors.green,
        actions: [
          //sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
