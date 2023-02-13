import 'package:flutter/material.dart';

void main() => runApp(const AppBarApp());

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LeaderBoard(),
    );
  }
}

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

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
            trailing: const Text(
              "pts",
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
