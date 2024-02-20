import 'package:flutter/material.dart';

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0; // Define minimum width for all buttons
const double buttonPadding = 20.0; // Define button padding
BorderRadius buttonBorderRadius =
    BorderRadius.circular(10.0); // Define border radius

Widget createTheBox(String text, VoidCallback onTap) {
  return Container(
    width: buttonMinWidth, // Set fixed width
    padding: const EdgeInsets.all(buttonPadding),
    decoration: BoxDecoration(
      color: Colors.deepPurple[200],
      borderRadius: buttonBorderRadius,
    ),
    child: InkWell(
      onTap: onTap,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontFamily: 'Arial',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

class DetailedSuggestionPage extends StatefulWidget {
  final String emotion;

  const DetailedSuggestionPage({Key? key, required this.emotion})
      : super(key: key);

  @override
  State<DetailedSuggestionPage> createState() => _DSuggestionPageState();
}

class _DSuggestionPageState extends State<DetailedSuggestionPage> {
  @override
  Widget build(BuildContext context) {
    // Use 'emotion' to determine which suggestions to display
    List<String> suggestions = getSuggestions(widget.emotion);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Suggestions',
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Column(
              children: suggestions
                  .expand((suggestion) => [
                        createTheBox(
                          suggestion,
                          () {
                            // Handle button press
                            print('Button pressed: $suggestion');
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.035,
                        ), // Add a fixed distance between buttons
                      ])
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSuggestions(String emotion) {
    // Implement logic to get suggestions based on the emotion
    // For now, using sample suggestions
    Map<String, List<String>> allSuggestions = {
      'Happy': [
        'Meet friends',
        'Recreational activities',
        'Practice gratitude',
        'Reward yourself',
      ],
      'Afraid': [
        'Take deep breaths',
        'Talk to someone you trust',
        'Face your fear',
        'Visualize a happy place',
      ],
      'Angry': [
        'Avoid making decisions',
        'Cool down quickly',
        'Take yourself out of the situation',
        'Think to yourself "I\'m feeling really angry right now"',
      ],
      'Stressed': [
        'take a break',
        'write it down',
        'meditation and exercise',
        'getting enough sleep',
      ],
      'Confused': [
        'accept where you are/focus on the present',
        'be patient',
        'contemplate objectively',
        'give 100% to your choice',
      ],
      'Disappointed': [
        'be kind to your self',
        'Cool surround yourself with good people',
        'take it as a learning experience',
        'get back in the game/plan your next move',
      ],
      // Add suggestions for other emotions
    };

    return allSuggestions[emotion] ?? [];
  }
}
