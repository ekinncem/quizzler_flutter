import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  Stopwatch stopwatch = Stopwatch();
  List<int> levelTimes = [];

  @override
  void initState() {
    super.initState();
    stopwatch.start();
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.questionNumber < quizBrain.getTotalQuestions() - 1) {
        quizBrain.nextQuestion();
      } else {
        // Seviye bittiğinde zaman kaydet ve uyarı göster
        stopwatch.stop();
        int levelTime = stopwatch.elapsedMilliseconds;
        levelTimes.add(levelTime);
        stopwatch.reset();

        String levelTimeString = (levelTime / 1000).toStringAsFixed(2); // Saniye cinsinden süre
        String totalTimeString = (levelTimes.reduce((a, b) => a + b) / 1000).toStringAsFixed(2); // Toplam süre

        Alert(
          context: context,
          type: AlertType.info,
          title: "Level ${quizBrain.level} Completed",
          desc: "Congratulations! You have completed level ${quizBrain.level}.\nTime taken: $levelTimeString seconds\nTotal time: $totalTimeString seconds",
          buttons: [
            DialogButton(
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  quizBrain.nextLevel();
                  scoreKeeper.clear();
                  if (quizBrain.level > 5) {
                    showSummary(context);
                  } else {
                    stopwatch.start();
                  }
                });
              },
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

  void showSummary(BuildContext context) {
    int totalTime = levelTimes.reduce((a, b) => a + b);
    String summary = '';
    for (int i = 0; i < levelTimes.length; i++) {
      summary += 'Level ${i + 1}: ${(levelTimes[i] / 1000).toStringAsFixed(2)} seconds\n';
    }
    summary += 'Total Time: ${(totalTime / 1000).toStringAsFixed(2)} seconds';

    Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Completed!",
      desc: "Congratulations on completing the quiz! Here are your times:\n$summary",
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              quizBrain.restartQuiz();
              scoreKeeper.clear();
              levelTimes.clear();
              stopwatch.start();
            });
          },
          width: 120,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
