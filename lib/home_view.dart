import 'register.dart';
import 'package:flutter/material.dart';
import 'admin_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Competitions');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Competitions');

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
            title: Text(
              competition['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
            subtitle:Text("status: ${competition ['key']}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.lightGreen),),
            trailing: const Icon(Icons.arrow_forward_ios),
            //enter to the competition
            onTap: () {
              //debugPrint("------------------------------${competition ['key']}");
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterPage(competitionId:competition ['key'])));
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
        title: const Text("Math Competition",
            style: TextStyle(
              fontSize: 26,
            )),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AdminView()),
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18),
              ))
        ],
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
