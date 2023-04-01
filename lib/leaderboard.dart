import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'home_view.dart';
import 'leaderboard.dart';
import 'Questions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class LeaderBoard extends StatefulWidget {
  final String competitionId;
  const LeaderBoard({super.key, required this.competitionId});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {

  late DatabaseReference dbRef;
  late String status = "";

  @override
  void initState() {
    super.initState();

    dbRef = FirebaseDatabase.instance.ref("Competitions/${widget.competitionId}/Players/");
  }


  Widget listItem({required Map players,required index}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      height: 90,
      color: Colors.grey[400],
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              players['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            onTap: () {},
            onLongPress: () {},
            leading: Text(
              '${index+1}',
              style: const TextStyle(
                fontSize: 30,
                letterSpacing: 5,
                color: Colors.yellowAccent,
              ),
            ),
            trailing: Text(
              "${players['score']} pts",
              style: const TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {

            print("-------------->${snapshot.value}<-------------");

            Map players = snapshot.value as Map;
            players['key'] = snapshot.key;
            return listItem(players: players,index: index);
          },
        ),
      ),
    );
  }
}
