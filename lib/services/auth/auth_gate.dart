import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/counselor/counselor_home_page.dart';
import 'package:mentalhealth_support_system/pages/student/student_home_page.dart';
import 'package:mentalhealth_support_system/services/auth/login_or_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while checking authentication state
          } else {
            if (snapshot.hasData) {
              // User is logged in
              User? user = snapshot.data;
              if (user != null) {
                // Retrieve the user's role from the Firestore user collection
                CollectionReference users =
                    FirebaseFirestore.instance.collection('users');
                return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(user.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        if (userData.containsKey('role')) {
                          String userRole = userData[
                              'role']; // Retrieve the user's role from Firestore

                          if (userRole == 'student') {
                            return StudentHomePage(
                                userData:
                                    userData); // Pass the user data to StudentHomePage
                          } else if (userRole == 'counselor') {
                            return CounselorHomePage(
                                userData:
                                    userData); // Navigate to the counselor homepage
                          }
                        }
                      }
                      return LoginRegister(); // Navigate to the default login/register page if the user's role is undefined or data is not available
                    }

                    return CircularProgressIndicator(); // Show a loading indicator while retrieving user data
                  },
                );
              } else {
                return LoginRegister(); // Navigate to the default login/register page if user data is not available
              }
            } else {
              return LoginRegister(); // Navigate to the default login/register page if the user is not logged in
            }
          }
        },
      ),
    );
  }
}
