import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
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
        title: const Center(
          child: Text(
            "HNU MentalHelp / BerryHelpFul",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: _buildBody(),
      backgroundColor: Colors.deepPurple[100],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Check In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Appointments/Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log out',
          ),
        ],
        backgroundColor: Colors.deepPurple[200],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: (int index) {
          /* Handle navigation based on the tapped index
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmotionAnalysis()),
            );
          } else {
             // Handle navigation for other items if needed
          }*/
          if (index == 2) {
            signOut();
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
          ),
          const SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "How are you feeling today?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  'images/charess2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.00),
          const SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                "Check In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
          const SizedBox(height: 250.00),
        ],
      ),
    );
  }
}
