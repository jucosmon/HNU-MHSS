import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/home_page.dart';
import 'package:mentalhealth_support_system/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user is log in
          if (snapshot.hasData) {
            return const HomePage();
          }

          //if user is log out
          else {
            return const LoginRegister();
          }
        },
      ),
    );
  }
}
