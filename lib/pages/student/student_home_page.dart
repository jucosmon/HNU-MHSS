import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/display_appointments.dart';
import 'package:mentalhealth_support_system/pages/display_messages.dart';
import 'package:mentalhealth_support_system/pages/profile_page.dart';
import 'package:mentalhealth_support_system/pages/student/emotionAnalysis.dart';

class StudentHomePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  const StudentHomePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    String firstName = userData['first name'] ?? 'Default First Name';
    String lastName = userData['last name'] ?? 'Default Last Name';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HNU-MHSS",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
      ),
      body: _buildBody(context, firstName),
      backgroundColor: const Color.fromARGB(255, 233, 232, 236),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Check In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 38, 130, 70),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 149, 192, 150),
        currentIndex: 0,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecentMessagesScreen(userData: userData),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RecentAppointmentScreen(userData: userData),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(userData: userData),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, String firstName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmotionAnalysis(userData: userData),
                  ),
                );
              },
              icon: const Icon(
                Icons.check,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Check In',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            "How are you feeling today, $firstName?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
