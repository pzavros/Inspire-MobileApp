import 'package:dilemma_game/leaderboard.dart';
import 'package:dilemma_game/register.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Questions.dart';
import 'main.dart';

class Waiting extends StatefulWidget {
  final List listOfQuestions;
  //needed to keep track of competitions
  final String competitionId;

  const Waiting(
      {Key? key, required this.competitionId, required this.listOfQuestions})
      : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  late DatabaseReference dbRefStatusPosition;

  String status = '';

  late DatabaseReference dbRef;
  var teamName = "teamname";
  var points = "points";

  // var questionCounter = 1;
  var correct = false;
  //var isMultiple = false;

  var index = 0;

  late int score = 0;

  bool submit = false;

  late int playerScore;

  final myController = TextEditingController();


  @override
  void initState() {

    dbRef = FirebaseDatabase.instance.ref("Competitions/${widget.competitionId}/Players/$v1");

    print(dbRef.path);


    getPlayerScore();

    dbRefStatusPosition = FirebaseDatabase.instance
        .ref("Competitions/${widget.competitionId}");

    print(dbRefStatusPosition.onValue.toString());

    dbRefStatusPosition.child("/status").onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      setState(() {
        status = data.toString();
      });

    });

    dbRefStatusPosition.child("/position").onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      setState(() {
        index = data as int;

        submit = true;

        print(submit);

      });

    });

    print(dbRefStatusPosition.child("/position").onValue);

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
      appBar: AppBar(),
      body: status == "holding"
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Waiting for administrator",
                      style: TextStyle(fontSize: 22)),
                  SizedBox(height: 15),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Column(
              //A column that contains The First row
              children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                      "Question ${index + 1} of ${widget.listOfQuestions.length}",
                      style: const TextStyle(fontSize: 22.0)),
                  const SizedBox(
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
                  Visibility(
                    visible: submit,
                    child: Container(
                        child: MaterialButton(
                            minWidth: 240.0,
                            height: 30.0,
                            color: Colors.blue,
                            onPressed: () {
                              if (myController.text ==
                                  widget.listOfQuestions[index]['answer']
                                      .toString()) {
                                //debugPrint("snapshot key-------------------> ${widget.competitionId}");

                                if (index < widget.listOfQuestions.length - 1) {
                                  // setState(() {
                                  //   index = dbRefStatusPosition.child("/position").onValue as int;
                                  // });
                                } else {
                                  //placeholder

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LeaderBoard(
                                            competitionId: widget.competitionId,
                                        ),
                                  ));
                                }

                                dbRef.update({"score": playerScore});
                              }
                              else {
                                //debugPrint("snapshot key-------------------> ${widget.competitionId}");

                                if (index < widget.listOfQuestions.length - 1) {
                                  // setState(() {
                                  //   index = dbRefStatusPosition.child("/position").onValue as int;
                                  //
                                  // });
                                } else {
                                  //placeholder

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LeaderBoard(
                                            competitionId: widget.competitionId,
                                  )),
                                  );
                                }
                              }

                             setState(() {
                               submit = false;
                             });
                            },
                            child: const Text(
                              "Submit",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.white),
                            ))),
                  ),
                  const Padding(padding: EdgeInsets.all(15.0)),
                ]),
    );
  }
}
