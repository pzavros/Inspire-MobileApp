import 'package:flutter/material.dart';
import 'leaderboard.dart';

var score = 0;
var questionNumber = 0;
var quiz = Quiz();
var questionCounter = 0;

class Quiz {
  var questions = [
    "This is the question 1",
    "This is the question 2",
    "This is the question 3",
    "This is the question 4",
  ];

  var choices = [
    ["Answer 1", "Answer 2", "Answer 3", "Answer 4"],
    ["Answer 1", "Answer 2", "Answer 3", "Answer 4"],
    ["Answer 1", "Answer 2", "Answer 3", "Answer 4"],
    ["Answer 1", "Answer 2", "Answer 3", "Answer 4"]
  ];

  var correctAnswers = ["Answer 1", "Answer 3", "Answer 2", "Answer 4"];
}

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var teamName = "teamname";
  var points = "points";
  var question = "This is the question 1";
  // var questionCounter = 1;
  var correct = false;
  //var isMultiple = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Questions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              //Nav to LeaderBoard
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaderBoard(score: score,name:"test"),
                ),
              );
            },
          ),
        ],
      ),
      //All page
      //extendBody: isMultiple,
      body: Column(
        //A column that contains The First row
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                  child: Text(
                    teamName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[300],
                    ),
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(fontSize: 22.0),
                    )),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                  child: const Text(
                    "Time: ",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              "Question ${questionNumber + 1} of ${quiz.questions.length}",
              style: const TextStyle(fontSize: 22.0),
            ),
          ),
          Text(
            quiz.questions[questionNumber],
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(10.0)),
          Expanded(
            flex: 12,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (quiz.choices[questionNumber][0] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            score++;
                          } else {
                            debugPrint("Wrong");
                          }

                          updateQuestion();
                        },
                        child: Text(quiz.choices[questionNumber][0]),
                      )),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (quiz.choices[questionNumber][1] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            score++;
                          } else {
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child: Text(quiz.choices[questionNumber][1]),
                      )),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (quiz.choices[questionNumber][2] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            score++;
                          } else {
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child: Text(quiz.choices[questionNumber][2]),
                      )),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (quiz.choices[questionNumber][3] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            score++;
                          } else {
                            debugPrint("Wrong");
                          }
                          updateQuestion();
                        },
                        child: Text(quiz.choices[questionNumber][3]),
                      )),
                ]),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Container(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                  minWidth: 240.0,
                  height: 30.0,
                  color: Colors.red,
                  onPressed: resetQuiz,
                  child: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ))),
        ],
      ),
    );
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LeaderBoard(score: score,name:"test")));
      } else {
        questionNumber++;
        questionCounter++;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Questions()));
      score = 0;
      questionNumber = 0;
    });
  }
}
