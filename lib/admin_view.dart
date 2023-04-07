import 'package:dilemma_game/admin_settings.dart';
import 'package:dilemma_game/class/question_obj.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final user = FirebaseAuth.instance.currentUser!;

  Query dbRef = FirebaseDatabase.instance.ref().child('Competitions');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Competitions');

  // List questionList=[];
  // getQuestionList(String key) {
  //   reference.child('$key/questions').onValue.listen((DatabaseEvent event) {
  //      questionList= event.snapshot.value as List;
  //   });
  // }
  
  @override
  void initState() {
    super.initState();
  }

  Widget listItem({required Map competition}) {
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
            subtitle:(competition ['questions']!=null)?Text("Total questions: ${competition ['index']+1}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.lightGreen),)
                :const Text("Total questions: 0",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.redAccent)),
            onTap: (){
              //add question to the selected competition
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AddQuestion(competitionId: competition['key'], currentIndex:competition['index'],); // pass the selected competition key and the last array index of questions (can be null)
                  }));
            },
            onLongPress: (){
              // enter to the competition if questions list it's not null
              if(competition['questions']!=null){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AdminPage(competitionId: competition['key'],listOfQuestions: competition['questions'],); // pass the selected competition key and a list of questions (cannot be null)
                  }));
              }
              else{
                // when null show error msg
                showDialog(context: context, builder: (context) => const AlertDialog(title: Center(child: Text('Cannot start the competition because question list is empty, touch unfocused area to dismiss.'))));
              }
            },
            trailing: IconButton(onPressed: (){
              reference.child(competition['key']).remove();
              },icon: const Icon(Icons.delete,color: Colors.red,)),
          )],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(user.email!, style: const TextStyle(fontSize: 20)),
          actions: [
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
        body: SizedBox(
            height: double.infinity,
            child:FirebaseAnimatedList(
              query: dbRef,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                Map competition=snapshot.value as Map;
                competition['key']=snapshot.key;
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
