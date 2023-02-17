import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  final int score;
  const LeaderBoard({super.key,required this.score});

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
            title: const Text(
              "Team Name",
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
              "$score pts",
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
