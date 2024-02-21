import 'package:flutter/material.dart';

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

class ModeOfCommunication extends StatelessWidget {
  const ModeOfCommunication({Key? key}) : super(key: key);

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
                  'In what way do you want to share your feelings?',
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MESSAGE NGA PAGE(),
                        //   ),
                        // );
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
                            'Message',
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
                    buttonModeOfCommunication('Call', () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => APPOINTMENT PAGE(),
                      //   ),
                      // );
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
