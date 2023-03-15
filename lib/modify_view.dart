import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'admin_view.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({required this.competitionId, Key? key}) : super(key: key);
  final String competitionId;

  @override
  State<QuestionView> createState() => _HomeViewState();
}

class _HomeViewState extends State<QuestionView> {
  Query dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref('Competitions/${widget.competitionId}/questions');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  Widget myWidget({required Map competition}){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      height: 90,
      color: Colors.grey[300],
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text('Question: ${competition['question']}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
            subtitle:Text("Answer: ${competition ['answer']}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
            onTap: () {

            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Modify", style: TextStyle(fontSize: 26,)),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) { // itemBuilder must return something
            Map competition = snapshot.value as Map;
            competition['key'] = snapshot.key;
            // return competitions that are ready
            //if(competition['status']=="ready") {
            return myWidget(competition:competition);
            //}
            // return Container();
          },
        ),
      ),
    );
  }
}