import 'package:flutter/material.dart';
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
        color: Colors.deepPurple[200],
        borderRadius: buttonBorderRadius,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Arial',
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
          backgroundColor: Colors.deepPurple[400],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Do you want to talk with someone about your feelings?',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ModeOfCommunication(),
                          ),
                        );
                      },
                      child: Container(
                        width: buttonMinWidth,
                        padding: const EdgeInsets.all(buttonPadding),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[200],
                          borderRadius: buttonBorderRadius,
                        ),
                        child: const Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Arial',
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
                          builder: (context) => StudentHomePage(
                            userData: userData,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}
