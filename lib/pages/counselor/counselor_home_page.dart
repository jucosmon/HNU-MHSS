import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/display_messages.dart';
import 'package:mentalhealth_support_system/pages/profile_page.dart';
import 'package:mentalhealth_support_system/pages/student/apppointment.dart';
import 'package:mentalhealth_support_system/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class CounselorHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const CounselorHomePage({super.key, required this.userData});

  @override
  State<CounselorHomePage> createState() => _CounselorHomePageState();
}

class _CounselorHomePageState extends State<CounselorHomePage> {
  final int _selectedIndex = 0; // Set the initial selected index to 2 (Profile)

  //sign out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = widget.userData['first name'] ?? 'Default First Name';
    String lastName = widget.userData['last name'] ?? 'Default Last Name';
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "HNU-MHSS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 225, 198)),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 94, 50),
      ),
      body: _buildBody(context, firstName, lastName),
      backgroundColor: const Color.fromARGB(255, 233, 232, 236),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Set the type to fixed
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
            icon: Icon(Icons.calendar_month),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 47, 114, 71),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 149, 192, 150),
        currentIndex:
            _selectedIndex, // Set the current selected index Set the current selected index
        onTap: (int index) {
          // Handle navigation based on the tapped index
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RecentMessagesScreen(userData: widget.userData)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyAppointment(userData: widget.userData)),
            );
            // Handle navigation for other items if needed
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(userData: widget.userData)),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, String firstName, String lastName) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            width: double.infinity,
            child: Center(
              child: Text(
                "How are you feeling today $firstName?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04), // Adjust the spacing as needed

          const SizedBox(height: 20),

          const SizedBox(height: 20),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
