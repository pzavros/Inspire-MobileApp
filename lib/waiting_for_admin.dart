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
  late DatabaseReference dbRef;

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance
        .ref("Competitions/${widget.competitionId}/state");
    dbRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      goToQuestions(data);
    });

    super.initState();
  }

  void goToQuestions(Object? data) async {
    if (data == 'started') {
      MaterialPageRoute(
          builder: (context) =>
              Questions(
                  competitionId: widget.competitionId,
                  listOfQuestions: widget.listOfQuestions));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Waiting for administrator", style: TextStyle(fontSize: 22)),
            SizedBox(height: 15),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
