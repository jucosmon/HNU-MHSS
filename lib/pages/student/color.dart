import 'package:flutter/material.dart';

void main() {
  runApp(const ColorPage());
}

class ColorPage extends StatefulWidget {
  const ColorPage({Key? key}) : super(key: key);

  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Tap the color that best describes your feeling",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Happy
                      // hover: Colors.transparent;
                      print("Happy button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child:
                        const CircleContainer(color: Colors.red, text: "Happy"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Calm
                      print("Calm button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child: const CircleContainer(
                        color: Colors.green, text: "Calm"),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Sad
                      print("Sad button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child:
                        const CircleContainer(color: Colors.blue, text: "Sad"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Excited
                      print("Excited button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child: const CircleContainer(
                        color: Colors.yellow, text: "Excited"),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Angry
                      print("Angry button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child: const CircleContainer(
                        color: Colors.purple, text: "Angry"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press for Surprised
                      print("Surprised button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Make background transparent
                      foregroundColor: Colors.black, // Set text color
                      shape: const CircleBorder(),
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Disable ripple effect
                    ),
                    child: const CircleContainer(
                        color: Colors.orange, text: "Surprised"),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  final Color color;
  final String text;

  const CircleContainer({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}
