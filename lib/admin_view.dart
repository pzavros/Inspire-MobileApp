import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'create_view.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Competitions');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Competitions');


  //@override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.white,
  //       body: Column(
  //         children: <Widget>[
  //           Container(
  //               height: 90,
  //               child: Container(
  //                 color: Colors.blue,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       margin: const EdgeInsets.fromLTRB(16, 16, 0, 0),
  //                       child: const Text(
  //                         "Admin",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 26,
  //                             color: Colors.white),
  //                       ),
  //                     ),
  //                     Container(
  //                         margin: const EdgeInsets.fromLTRB(0, 16, 16, 0),
  //                         child: ElevatedButton(
  //                           style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.blueGrey[400]),
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text("Sign out"),
  //                         )
  //                     ),
  //                   ],
  //                 ),
  //               )),
  //           Expanded(
  //               flex: 9,
  //               child: Container(
  //                 color: Colors.white,
  //                 child: FractionallySizedBox(
  //                   alignment: FractionalOffset.center,
  //                   widthFactor: 0.9,
  //                   child: Column(
  //                     children: [
  //                       const SizedBox(
  //                         height: 30,
  //                       ),
  //                       const Text(
  //                         "All Competitions:",
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 32),
  //                       ),
  //                       Container(
  //                         color: Colors.blueAccent,
  //                           height: 500,
  //                           child: ListView(
  //                             padding:
  //                             const EdgeInsets.symmetric(vertical: 8.0),
  //                             children: [
  //                               Container(
  //                                 height: 50,
  //                                 color: Colors.green[400],
  //                                 child: const Center(
  //                                   child: Text(
  //                                     "Competition 1",
  //                                     style: TextStyle(fontSize: 18),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 height: 50,
  //                                 color: Colors.green[400],
  //                                 child: const Center(
  //                                   child: Text(
  //                                     "Competition 2",
  //                                     style: TextStyle(fontSize: 18),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 height: 50,
  //                                 color: Colors.green[400],
  //                                 child: const Center(
  //                                   child: Text(
  //                                     "Competition 3",
  //                                     style: TextStyle(fontSize: 18),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Container(
  //                                 height: 50,
  //                                 color: Colors.orange[400],
  //                                 child: const Center(
  //                                   child: Text(
  //                                     "Competition 4",
  //                                     style: TextStyle(fontSize: 18),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           )),
  //                     ],
  //                   ),
  //                 ),
  //               )),
  //           Container(
  //             height: 50,
  //             color: Colors.blue,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Flexible(
  //                     child: TextButton(
  //                       onPressed: () {
  //                         Navigator.push(context,
  //                             MaterialPageRoute(builder: (context) {
  //                               return const CreateView();
  //                             }));
  //                       },
  //                       style: TextButton.styleFrom(
  //                           padding: const EdgeInsets.symmetric(vertical: 1)),
  //                       child: const Text(
  //                         'Create',
  //                         style: TextStyle(color: Colors.white, fontSize: 26),
  //                       ),
  //                     )),
  //               ],
  //             ),
  //           )
  //         ],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Admin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              )),
        ),
        body: Text(""),
       bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: TextButton(
            child: const Text("Create",style: TextStyle(color: Colors.white, fontSize: 26)),
            onPressed: (){
              //TODO
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
