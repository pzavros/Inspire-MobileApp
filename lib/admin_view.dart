import 'package:dilemma_game/admin_settings.dart';
import 'package:dilemma_game/class/question_obj.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'add_question_view.dart';
import 'add_competition_view.dart';

class AdminView extends StatefulWidget {
 // final String competitionId;
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Competitions');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Competitions');

  Widget listItem({required Map competition}) {
    //debugPrint("Competition OBJ----> $competition");
    return Container(
      margin: const EdgeInsets.fromLTRB(10,10,10,0),
      padding: const EdgeInsets.all(10),
      height: 90,
      color: Colors.grey[300],
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              competition ['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            subtitle:Text("key: ${competition ['key']}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.lightGreen),
          ),
            onTap: (){
              //add question to the selected competition
              // print(competition['questions']);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AddQuestion(competitionId: competition['key'], currentIndex:competition['index'],); // pass the selected competition key and the last array index of questions (can be null)
                  }));
            },
            onLongPress: (){
              //enter to the competition
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AdminPage(competitionId: competition['key'],listOfQuestions: competition['questions'],); // pass the selected competition key and a list of questions (cannot be null)
                  }));
            },
          )],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Admin", style: TextStyle(fontSize: 26,)),
        ),
        body: Container(
            height: double.infinity,
            child:FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                Map competition=snapshot.value as Map;
                competition['key']=snapshot.key;// will give the generated unique id a name "key"
                //debugPrint("snapshot key-------------------> ${snapshot.key}");
                return listItem(competition: competition);
              },
            ) ,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: TextButton(
            child: const Text("Create",style: TextStyle(color: Colors.white, fontSize: 26)),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const AddCompetition();
                  }));
            },
          ),
        ),
    );
  }
}
