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
  State<DetailedSuggestionPage> createState() => _DetailedSuggestionPageState();
}

class _DetailedSuggestionPageState extends State<DetailedSuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detailed Suggestions',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                child: Text('Home'),
              ),
              const PopupMenuItem(
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                child: Text('Appointments'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
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
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
              Container(
                width: MediaQuery.of(context).size.height / 2.1,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
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
                  backgroundColor: Colors.green[500], // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5, // Add elevation for a more tactile feel
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
