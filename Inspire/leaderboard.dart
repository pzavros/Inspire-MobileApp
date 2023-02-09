import 'package:flutter/material.dart';
import 'package:inspire/main.dart';

class leaderBoard extends StatefulWidget {
  final int score;
  leaderBoard({Key? key, required this.score}) : super(key: key);

  @override
  State<leaderBoard> createState() => _leaderBoardState();
}

class _leaderBoardState extends State<leaderBoard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: Center(
        child: Text("This is the Leaderboard the score is : $score "),

      ),
    );
  }
}
