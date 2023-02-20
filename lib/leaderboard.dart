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
  final int score;
  final String name;
  const LeaderBoard({super.key, required this.score, required this.name});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  //var something = "";

  late DatabaseReference dbRef;

  void initState() {
    super.initState();

    // DatabaseReference starCountRef =
    //
    // FirebaseDatabase.instance.ref('Players');

    dbRef = FirebaseDatabase.instance.ref("Players/");

    // _db.

    // _db.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value;
    //   var something = data as Map;
    //   debugPrint(something.toString());
    // });
  }

  //int index = 1;

  Widget listItem({required Map players,required index}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      height: 90,
      color: Colors.grey[400],
      child: ListView(
        children: [
          ListTile(
            title: Text(
              players['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            //   subtitle:Text("status: ${competition ['status']}",
            //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
            // ),
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
              "${widget.score} pts",
              style: TextStyle(
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
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map players = snapshot.value as Map;
            players['key'] = snapshot.key;
            return listItem(players: players,index: index);
          },
        ),
      ),
    );
  }
//       body: ListView.builder(
//         itemCount: 25,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(
//               '${widget.name}',
//               style: TextStyle(
//                 fontSize: 25,
//                 letterSpacing: 5,
//                 color: Colors.white60,
//               ),
//             ),
//             leading: Text('${index + 1}',
//               style: const TextStyle(
//                 fontSize: 30,
//                 letterSpacing: 5,
//                 color: Colors.yellowAccent,
//               ),),
//             trailing:  Text(
//               "${widget.score} pts",
//               style: TextStyle(
//                 fontSize: 20,
//                 letterSpacing: 1,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
}
