import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/student/talkFeelings.dart';

class DetailedSuggestionPage extends StatefulWidget {
  final String description;
  final String emotion;

  final Map<String, dynamic> userData;

  const DetailedSuggestionPage(
      {super.key,
      required this.description,
      required this.emotion,
      required this.userData});

  @override
  State<DetailedSuggestionPage> createState() => _DSuggestionPageState();
}

class _DSuggestionPageState extends State<DetailedSuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(
          'Detailed Suggestions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          // Add three-dots icon here
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
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
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            SizedBox(
              width: 300,
              child: Center(
                child: Text(
                  'We recommend:',
                  // 'If you are ${widget.emotion}:', if you want to display the emotion
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            Container(
              width: MediaQuery.of(context).size.height / 2.1,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TalkFeelings(
                      userData: widget.userData,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300], // Background color
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.black, // Set font color to black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
