import 'package:flutter/material.dart';
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
          title: const Text('Emotion Tracker',
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
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text(
                        "Swipe the color for each emotion",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
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
                    Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              '$emotion:',
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.black,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                          Container(
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
              Container(
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
                child: Text('See Results'),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.deepPurple[100],
      ),
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

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: SfCircularChart(
        series: <DoughnutSeries<ChartData, String>>[
          DoughnutSeries<ChartData, String>(
            dataSource: chartData,
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.emotion,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelMapper: (ChartData data, _) => '${data.value.round()}%',
            dataLabelSettings: DataLabelSettings(isVisible: true),
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
