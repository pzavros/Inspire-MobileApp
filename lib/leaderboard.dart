import 'package:flutter/material.dart';
import 'main.dart';
import 'home_view.dart';
import 'leaderboard.dart';
import 'Questions.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class LeaderBoard extends StatefulWidget {
  final int score;
  final String name;
  const LeaderBoard({super.key,required this.score,required this.name});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  //var something = "";

  late DatabaseReference _db;

  void initState() {
    super.initState();

    // DatabaseReference starCountRef =
    //
    // FirebaseDatabase.instance.ref('Players');

    _db = FirebaseDatabase.instance.ref("Players/");
    // _db.

    // _db.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   var something = data as Map;
    //   debugPrint(something.toString());
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              '${widget.name}',
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 5,
                color: Colors.white60,
              ),
            ),
            leading: Text('${index + 1}',
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: 5,
                color: Colors.yellowAccent,
              ),),
            trailing:  Text(
              "${widget.score} pts",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          );
        },
      ),
    );
  }
}

