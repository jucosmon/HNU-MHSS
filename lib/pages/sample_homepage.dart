import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class SampleHomePages extends StatefulWidget {
  const SampleHomePages({super.key});

  @override
  State<SampleHomePages> createState() => _SampleHomePagesState();
}

class _SampleHomePagesState extends State<SampleHomePages> {
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
        title: const Text("Student"),
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

  //
}
