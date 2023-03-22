import 'package:dilemma_game/register.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'main.dart';

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
  final List listOfQuestions;
  //needed to keep track of competitions
  final String competitionId;

  const Questions(
      {Key? key, required this.competitionId, required this.listOfQuestions})
      : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {

  late DatabaseReference dbRef;
  var teamName = "teamname";
  var points = "points";

  // var questionCounter = 1;
  var correct = false;
  //var isMultiple = false;

  var index = 0;

  late int score = 0;

  late int playerScore;

  final myController = TextEditingController();

  @override void initState() {
    // TODO: implement initState

    dbRef = FirebaseDatabase.instance.ref("Competitions/${widget.competitionId}/Players/$v1");

    print(dbRef.path);


    getPlayerScore();

    super.initState();
  }

  getPlayerScore(){
    dbRef.child("score").onValue.listen((event) {
      playerScore = event.snapshot.value as int;
     print(playerScore);

     playerScore = playerScore+widget.listOfQuestions[index]['point'] as int;

    },);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Questions'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              //Nav to LeaderBoard
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LeaderBoard(
                    score: score,
                    name: "test",
                    competitionId: widget.competitionId,
                  ),
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
            const SizedBox(
              height: 50,
            ),
            // Expanded(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Container(
            //         padding: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           color: Colors.grey[300],
            //         ),
            //         child: Text(
            //           teamName,
            //           style: const TextStyle(
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //       Container(
            //           padding: const EdgeInsets.all(8.0),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10.0),
            //             color: Colors.grey[300],
            //           ),
            //           child: Text(
            //             "Score: $score",
            //             style: const TextStyle(fontSize: 22.0),
            //           )),
            //       Container(
            //         padding: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           color: Colors.grey[300],
            //         ),
            //         child: const Text(
            //           "Time: ",
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Question ${index+1} of ${widget.listOfQuestions.length}",
              style: const TextStyle(fontSize: 22.0)
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              widget.listOfQuestions[index]['question'].toString(),
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Enter Team Name',
                  labelStyle: TextStyle(fontSize: 18)),
            ),
            Container(
                child: MaterialButton(
                    minWidth: 240.0,
                    height: 30.0,
                    color: Colors.blue,
                    onPressed: () {
                      if(myController.text == widget.listOfQuestions[index]['answer'].toString()){
                        //debugPrint("snapshot key-------------------> ${widget.competitionId}");

                        if(index<widget.listOfQuestions.length - 1){
                          setState(() {
                            index++;
                          });
                        }
                        else
                          {

                            //placeholder

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage(
                                      competitionId:
                                      widget.competitionId,
                                      listOfQuestions: widget.listOfQuestions)),
                            );
                          }

                        dbRef.update({"score":playerScore});
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ))),
            const Padding(padding: EdgeInsets.all(15.0)),
          ]),
    );
  }

  void updateQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LeaderBoard(
                      score: score,
                      name: "test",
                      competitionId: widget.competitionId,
                    )));
      } else {
        questionNumber++;
        questionCounter++;
      }
    });
  }
}
