import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/student/modeOfCommunication.dart';
import 'package:mentalhealth_support_system/pages/student/student_home_page.dart';

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0;
const double buttonPadding = 20.0;
BorderRadius buttonBorderRadius = BorderRadius.circular(10.0);

Widget buttonTalkFeelings(String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap, // I want this to navigate to "MyHomePage"
    child: Container(
      width: buttonMinWidth,
      padding: const EdgeInsets.all(buttonPadding),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: buttonBorderRadius,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

class TalkFeelings extends StatelessWidget {
  final Map<String, dynamic> userData;

  const TalkFeelings({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Talking Stage',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.green[400],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            // Three-dots icon
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showPopupMenu(context);
              },
            ),
          ],
        ),
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Do you want to talk with someone about your feelings?',
                    style: GoogleFonts.poppins(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 70),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ModeOfCommunication(userData: userData),
                          ),
                        );
                      },
                      child: Container(
                        width: buttonMinWidth,
                        padding: const EdgeInsets.all(buttonPadding),
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: buttonBorderRadius,
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: GoogleFonts.poppins(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: sizedBoxHeight),
                    buttonTalkFeelings('No', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentHomePage(userData: userData),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.green[100],
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    // Show the popup menu
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(400, 100, 100, 0),
      items: [
        const PopupMenuItem(
          child: Text('Home'),
          // Add your action for Option 1 here
        ),
        const PopupMenuItem(
          child: Text('Profile'),
          // Add your action for Option 1 here
        ),
        const PopupMenuItem(
          child: Text('Appointments'),
          // Add your action for Option 2 here
        ),
        // Add more options as needed
      ],
    );
  }
}
