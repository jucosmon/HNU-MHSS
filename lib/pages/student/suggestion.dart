import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/student/detailedSuggestion.dart';

const double sizedBoxHeight = 50;
const double buttonMinWidth = 300.0; // Define minimum width for all buttons
const double buttonPadding = 20.0; // Define button padding
BorderRadius buttonBorderRadius =
    BorderRadius.circular(10.0); // Define border radius

Widget createTheBox(BuildContext context, String text, String description,
    VoidCallback onTap, String emotion, Map<String, dynamic> userData) {
  return Column(
    // Wrap the button in a Column
    children: [
      Container(
        width: buttonMinWidth,
        padding: const EdgeInsets.all(buttonPadding),
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: buttonBorderRadius,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedSuggestionPage(
                  description: description,
                  emotion: emotion, userData: userData, // this errors
                ),
              ),
            );
          },
          child: Column(
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

class Suggestion {
  final String title;
  final String description;

  Suggestion({required this.title, required this.description});
}

class SuggestionPage extends StatefulWidget {
  final String emotion;
  final Map<String, dynamic> userData;

  const SuggestionPage(
      {super.key, required this.emotion, required this.userData});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) {
    List<Suggestion> suggestions = getSuggestions(widget.emotion);

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(
          'Suggestions',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[400],
        actions: [
          // Three-dots icon
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add three-dots icon here
              showPopupMenu(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 400,
              child: Center(
                child: Text(
                  'If you are feeling ${widget.emotion}:',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: suggestions
                  .map(
                    (suggestion) => createTheBox(
                        context, suggestion.title, suggestion.description, () {
                      print('Button pressed: ${suggestion.title}');
                    }, widget.emotion, widget.userData),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void showPopupMenu(BuildContext context) {
    // Show a popup menu
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 80.0, 0.0, 0.0),
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

List<Suggestion> getSuggestions(String emotion) {
  Map<String, List<Suggestion>> allSuggestions = {
    'Happy': [
      Suggestion(
        title: 'Meet friends',
        description:
            'It is important to meet friends when you\'re happy to celebrate victories together.',
      ),
      Suggestion(
        title: 'Recreational activities',
        description:
            'Engaging in recreational activities can enhance your happiness and well-being.',
      ),
      Suggestion(
        title: 'Practice gratitude',
        description:
            'Take a moment to reflect on the positive aspects of your life and express gratitude.',
      ),
      Suggestion(
        title: 'Reward yourself',
        description:
            'Celebrate your achievements, big or small, to boost your overall happiness.',
      ),
    ],
    'Afraid': [
      Suggestion(
        title: 'Take deep breaths',
        description:
            'Practice deep breathing to calm your nerves and reduce fear.',
      ),
      Suggestion(
        title: 'Talk to someone you trust',
        description:
            'Share your fears with someone you trust to gain support and perspective.',
      ),
      Suggestion(
        title: 'Face your fear',
        description:
            'Confronting your fears gradually can help you overcome them.',
      ),
      Suggestion(
        title: 'Visualize a happy place',
        description:
            'Imagining a peaceful and happy place can help alleviate fear and anxiety.',
      ),
    ],
    'Angry': [
      Suggestion(
        title: 'Avoid making decisions',
        description:
            'Take a step back and avoid making decisions impulsively when angry.',
      ),
      Suggestion(
        title: 'Cool down quickly',
        description:
            'Find healthy ways to cool down and manage your anger, such as deep breathing or a short walk.',
      ),
      Suggestion(
        title: 'Take yourself out of the situation',
        description:
            'Remove yourself from the source of anger to prevent escalation.',
      ),
      Suggestion(
        title: 'Think to yourself "I\'m feeling really angry right now"',
        description:
            'Acknowledging your emotions can help you better understand and manage your anger.',
      ),
    ],
    'Stressed': [
      Suggestion(
        title: 'Take a break',
        description:
            'Give yourself some time off to relax and recharge when feeling stressed.',
      ),
      Suggestion(
        title: 'Write it down',
        description:
            'Journaling can help you process your thoughts and identify sources of stress.',
      ),
      Suggestion(
        title: 'Meditation and exercise',
        description:
            'Incorporate meditation and physical activity into your routine to reduce stress levels.',
      ),
      Suggestion(
        title: 'Getting enough sleep',
        description:
            'Prioritize quality sleep to improve your overall well-being and resilience to stress.',
      ),
    ],
    'Confused': [
      Suggestion(
        title: 'Accept where you are/focus on the present',
        description:
            'Accept the current situation and focus on the present moment to reduce confusion.',
      ),
      Suggestion(
        title: 'Be patient',
        description:
            'Give yourself time to process information and make decisions, and be patient with the process.',
      ),
      Suggestion(
        title: 'Contemplate objectively',
        description:
            'Step back and analyze the situation objectively to gain clarity and reduce confusion.',
      ),
      Suggestion(
        title: 'Give 100% to your choice',
        description:
            'Once you make a decision, commit fully and give your best effort to avoid second-guessing.',
      ),
    ],
    'Disappointed': [
      Suggestion(
        title: 'Be kind to yourself',
        description:
            'Practice self-compassion and treat yourself with kindness during times of disappointment.',
      ),
      Suggestion(
        title: 'Surround yourself with good people',
        description:
            'Seek support from positive influences in your life to navigate through disappointment.',
      ),
      Suggestion(
        title: 'Take it as a learning experience',
        description:
            'View disappointment as an opportunity for growth and learning rather than a setback.',
      ),
      Suggestion(
        title: 'Get back in the game/plan your next move',
        description:
            'Develop a plan of action to move forward and overcome challenges after experiencing disappointment.',
      ),
    ],
  };

  return allSuggestions[emotion] ?? [];
}
