import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var safeArea = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // butang ag image and other containers sa ubos
        crossAxisAlignment: CrossAxisAlignment.center,
        // start kay right, end kay left, center ang center obv
        children: [
          TextButton(
            onPressed: () {
              // Handle button press
              print("Button pressed");
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ), // Or any other content
            ),
          ),
          // const SizedBox(height: 180),
          // Container(
          //   color: Colors.blue,
          //   width: double.infinity,
          //   child: const Center(
          //       child: Text(
          //     "How are you feeling today??",
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       fontStyle: FontStyle.italic,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //     ),
          //   )),
          // ),
          // const SizedBox(height: 30),
          // Container(
          //   width: double.infinity,
          //   color: Colors.blue,
          //   child: const Image(
          //     image: AssetImage('images/raidenshogun.png'),
          //     height: 110,
          //     width: 200.0,
          //   ),
          // ),
          // const SizedBox(height: 290.00),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Container(
              //   color: Colors.pink,
              //   height: double.infinity,
              //   width: 200,
              // ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 216, 52),
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                height: 75.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                child: const Text("Check in"),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 172, 216, 52),
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                height: 75.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                child: const Text("Appointments/Messages"),
              ),
            ],
          ),
        ],
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("HNU MentalHelp / BerryHelpFul"),
          ),
          backgroundColor: const Color.fromARGB(255, 139, 139, 139),
        ),
        body: safeArea,
        backgroundColor: Colors.deepPurple[100],
      ),
    );
  }
}


//     body: const Center(
//             child: Image(image: AssetImage('images/raidenshogun.png'))),
//         backgroundColor: Colors.deepPurple[200],