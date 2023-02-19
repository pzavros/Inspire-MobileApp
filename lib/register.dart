import 'package:flutter/material.dart';
import 'main.dart';
import 'home_view.dart';
import 'leaderboard.dart';
import 'Questions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  // final FirebaseApp app;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myController = TextEditingController();

  // late List<Message> _messages = [];

  //final referenceDatabase = FirebaseDatabase.instance;

  // void initState() async {
  //   super.initState();
  //   await ref.set({
  //     "name": "John",
  //     "age": 18,
  //     "address": {
  //       "line1": "100 Mountain View"
  //     }
  //   });
  //
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   _textEditingController.dispose();
  //   super.dispose();
  // }

  late DatabaseReference dbRef;

  var teamName = "Team name";

  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Players');

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dilemma Game'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
                child: const Icon(Icons.developer_mode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaderBoard(score: score,name:teamName)),
                  );
                },
                child: const Icon(Icons.leaderboard_rounded),
              ),
            ),
          ],
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Text(
                'Enter team name',
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 10
                    ..color = Colors.indigo,
                ),
              ),
              // The text inside
              const Text(
                'Enter team name',
                style: TextStyle(
                  fontSize: 35,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, top: 100.0, left: 20.0, right: 20.0),
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Colors.white),
                onPressed: () {

                  Map<String, String> Player = {'name': myController.text ,'uuid': v1};
                  var name = myController.text;

                  // dbRef.set({
                  //   "name": name,
                  //   "score": 0,
                  // });

                  dbRef.push().set(Player);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const Questions()),
                  // );

                  //debugPrint(v1 + "  //////////////////");
                  //dbRef.push().set(Players);
                },
                child: const Icon(Icons.navigate_next),
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream: dbRef.child('Players').orderByKey().onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else{

                    //final snapshot = dbRef.child('Players/00bef620-b03a-11ed-8e8a-9fbb8a9b4cce').get();


                    //onValue
                    dbRef.onChildAdded.listen((DatabaseEvent event) {
                      final data = event.snapshot.value;
                      //  var something = data as Map;
                      // debugPrint(something.toString());
                      print(data);
                      teamName = data.toString();

                    });
                    return Text("");

                  }
                },
              ),
            ),
            Container(color: Colors.yellowAccent,
              child: Center(
                child: MaterialButton(onPressed: ()async{
                  if (myController.text.isNotEmpty) {
                    // popupTitle = "Success";
                    // popupMsg = "New data has been added to the database.";
                    Map<String,String> players = {
                      'name':myController.text,

                    };
                    dbRef.push().set(players);
                  }

                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*FloatingActionButton(
  // When the user presses the button, show an alert dialog containing
  // the text that the user has entered into the text field.
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text that the user has entered by using the
          // TextEditingController.
          content: Text(myController.text),
        );
      },
    );
  },
  tooltip: 'Show me the value!',
  child: const Icon(Icons.text_fields),
),*/
