import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentalhealth_support_system/pages/student/suggestion.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EmotionAnalysis extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EmotionAnalysis({super.key, required this.userData});

  @override
  _EmotionAnalysisState createState() => _EmotionAnalysisState();
}

class _EmotionAnalysisState extends State<EmotionAnalysis> {
  Map<String, double> emotions = {
    'Happy': 10,
    'Afraid': 20,
    'Angry': 30,
    'Stressed': 40,
    'Confused': 50,
    'Disappointed': 60,
  };

  Map<String, Color> emotionColors = {
    'Happy': Colors.yellow,
    'Afraid': Colors.blue,
    'Angry': Colors.red,
    'Stressed': Colors.green,
    'Confused': Colors.brown,
    'Disappointed': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emotion Tracker',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.green[400],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        "Swipe the color for each emotion",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              for (var emotion in emotions.keys)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              '$emotion:',
                              style: GoogleFonts.poppins(
                                fontSize: 13.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 275,
                            child: Slider(
                              value: emotions[emotion]!,
                              min: 0,
                              max: 100,
                              onChanged: (newValue) {
                                setState(() {
                                  emotions[emotion] = newValue;
                                });
                              },
                              activeColor: emotionColors[emotion],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: _buildCircularChart(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () {
                  _showResults();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[300], // Background color
                ),
                child: const Text(
                  'See Results',
                  style: TextStyle(
                    color: Colors.black, // Set font color to black
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green[100],
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

  void _showResults() {
    // Find the emotion with the highest value
    String highestEmotion =
        emotions.keys.reduce((a, b) => emotions[a]! > emotions[b]! ? a : b);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuggestionPage(
          emotion: highestEmotion,
          userData: widget.userData,
        ),
      ),
    );
  }

  Widget _buildCircularChart() {
    List<ChartData> chartData = emotions.entries
        .map((entry) =>
            ChartData(entry.key, entry.value, emotionColors[entry.key]!))
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCircularChart(
        series: <DoughnutSeries<ChartData, String>>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.emotion,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelMapper: (ChartData data, _) => '${data.value.round()}%',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String emotion;
  final double value;
  final Color color;

  ChartData(this.emotion, this.value, this.color);
}
