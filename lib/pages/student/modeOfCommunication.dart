import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/select_counselor.dart';

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0;
const double buttonPadding = 20.0;
BorderRadius buttonBorderRadius = BorderRadius.circular(10.0);

Widget buttonModeOfCommunication(String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap, // I want this to navigate to "MyHomePage"
    child: Container(
      width: buttonMinWidth,
      padding: const EdgeInsets.all(buttonPadding),
      decoration: BoxDecoration(
        color: Colors.green[500],
        borderRadius: buttonBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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

class ModeOfCommunication extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ModeOfCommunication({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mode of Communication',
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
                const SizedBox(height: 100),
                Text(
                  'In what way do you want to share your feelings?',
                  style: GoogleFonts.poppins(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CounselorSelectionWidget(
                              identifier: 'message',
                              userData: userData,
                            );
                          },
                        );
                      },
                      child: Container(
                        width: buttonMinWidth,
                        padding: const EdgeInsets.all(buttonPadding),
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          borderRadius: buttonBorderRadius,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Message',
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
                    buttonModeOfCommunication('Set an appointment', () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CounselorSelectionWidget(
                            identifier: 'appointment',
                            userData: userData,
                          );
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
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
