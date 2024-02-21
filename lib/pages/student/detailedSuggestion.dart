import 'package:flutter/material.dart';
import 'package:mentalhealth_support_system/pages/student/talkFeelings.dart';

class DetailedSuggestionPage extends StatefulWidget {
  final String description;
  final String emotion;

  final Map<String, dynamic> userData;

  DetailedSuggestionPage(
      {required this.description,
      required this.emotion,
      required this.userData});

  @override
  State<DetailedSuggestionPage> createState() => _DSuggestionPageState();
}

class _DSuggestionPageState extends State<DetailedSuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detailed Suggestions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Text(
              'Suggestions for ${widget.emotion}:',
              style: const TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            Container(
              width: MediaQuery.of(context).size.height / 2.2,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: 'Arial',
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
              child: const Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
