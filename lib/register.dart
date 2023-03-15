import 'package:flutter/material.dart';
import 'main.dart';
import 'home_view.dart';
import 'leaderboard.dart';
import 'Questions.dart';

import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.competitionId, Key? key}) : super(key: key);
  final String competitionId;
  // final FirebaseApp app;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myController = TextEditingController();

  late DatabaseReference dbRef;

  late String popupTitle = "Fail";
  late String popupMsg = "The name cannot be empty or name already exist.";

  var teamName = "Team name";

  var state = true;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance
        .ref()
        .child("Competitions/${widget.competitionId}/Players");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dilemma Game'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },
                child: const Icon(Icons.developer_mode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaderBoard(
                              score: score,
                              name: teamName,
                              competitionId: widget.competitionId,
                            )),
                  );
                },
                child: const Icon(Icons.leaderboard_rounded),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: state,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, top: 100.0, left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Enter Team Name',
                      labelStyle: TextStyle(fontSize: 18)),
                ),
              ),
            ),

            Visibility(
              visible: state,
              child: Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: Colors.white),
                  onPressed: () async {
                    if (myController.text.isNotEmpty) {
                      popupTitle = "Registration Successful!";
                      popupMsg = "";
                      Map<String, dynamic> players = {
                        'name': myController.text,
                        'uuid': v1,
                        'score': 0,
                      };
                      //debugPrint("snapshot key-------------------> ${widget.competitionId}");
                      dbRef.push().set(players);
                    }
                    setState(() {
                      if (popupTitle == "Registration Successful!") {
                        state = !state;
                      }
                    });
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(popupTitle),
                            content: Text(popupMsg),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  if (popupTitle ==
                                      "Registration Successful!") {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Questions(
                                                competitionId:
                                                    widget.competitionId,
                                              )),
                                    );
                                  } else {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.pop(context);
                                  }
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Text("Submit"),
                ),
              ),
            ),
            Visibility(
              visible: !state,
              child: Center(
                  child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Questions(
                              competitionId: widget.competitionId,
                            )),
                  );
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Colors.white),
                child: const Text("Continue",style: TextStyle(color: Colors.black),),
              )),
            ),
            Visibility(
              visible: !state,
              child: Center(
                  child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    state = !state;
                  });
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    minimumSize: const Size(50, 50),
                    backgroundColor: Colors.redAccent),
                child: const Icon(Icons.restart_alt),
              )),
            )
          ],
        ),
      ),
    );
  }
}