import 'package:flutter/material.dart';

void main() {
  runApp(const DetailedSuggestionPage());
}

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0; // Define minimum width for all buttons
const double buttonPadding = 20.0; // Define button padding
BorderRadius buttonBorderRadius =
    BorderRadius.circular(10.0); // Define border radius

Widget createGreenBox(String mainText, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: buttonMinWidth,
      constraints: const BoxConstraints(minWidth: buttonMinWidth),
      padding: const EdgeInsets.all(buttonPadding),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: buttonBorderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mainText,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Arial',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 200),
        ],
      ),
    ),
  );
}

class DetailedSuggestionPage extends StatelessWidget {
  const DetailedSuggestionPage({super.key});

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
                  '// Suggestion depends on the emotion',
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
                    createGreenBox('Take a break', () {
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
