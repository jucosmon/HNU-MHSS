import 'package:flutter/material.dart';

void main() {
  runApp(const ModeOfCommunication());
}

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0; // Define minimum width for all buttons
const double buttonPadding = 20.0; // Define button padding
BorderRadius buttonBorderRadius =
    BorderRadius.circular(10.0); // Define border radius

Widget createGreenBox(String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      constraints:
          const BoxConstraints(minWidth: buttonMinWidth), // Set minimum width
      padding: const EdgeInsets.all(buttonPadding),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: buttonBorderRadius,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontFamily: 'Arial',
        ),
        textAlign: TextAlign.center, // Center text vertically
      ),
    ),
  );
}

class ModeOfCommunication extends StatelessWidget {
  const ModeOfCommunication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  '// In what way do you want to share your feelings?',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                Column(
                  // Use a Column to align buttons vertically
                  children: [
                    createGreenBox('Message', () {
                      // Handle button press
                    }),
                    const SizedBox(height: sizedBoxHeight),
                    createGreenBox('Call', () {
                      // Handle button press
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