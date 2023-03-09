import 'package:dilemma_game/admin_settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'create_view.dart';

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
          //   subtitle:Text("status: ${competition ['status']}",
          //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
          // ),
            onTap: (){
              //TODO enter to the competition
            },
            onLongPress: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return AdminPage(competitionId: competition['key']); // pass uuid to AdminSettings
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
                    return const CreateView();
                  }));
            },
          ),
        ),
    );
  }
}
