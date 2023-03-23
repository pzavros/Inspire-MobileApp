import 'package:flutter/material.dart';
import 'Questions.dart';
import 'leaderboard.dart';
import 'home_view.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

/*
void main() {
  runApp(const AdminPage());
}
*/
class AdminPage extends StatefulWidget {
  final String competitionId;
  final List listOfQuestions;
  const AdminPage(
      {Key? key, required this.competitionId, required this.listOfQuestions})
      : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //Query db = FirebaseDatabase.instance.ref().child('Competitions');

  late DatabaseReference dbRef;
  late String CompStatus = 'closed';
  var i = 0;
  var timer;
  bool isShown = false;
  String showAnswer = "show answer";
  //late String popupTitle = "Fail";
  //late String popupMsg = "The name cannot be empty or name already exist.";

  void CountDownTimer () {
    Countdown(seconds: timer,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(milliseconds: 100),
      onFinished: () {
        print('Timer is done!');
      },

    );
  }

  @override
  void initState() {
    print(widget.competitionId);
    super.initState();
    timer = widget.listOfQuestions[i]['timer'];
    //dbRef = FirebaseDatabase.instance.ref("Competitions");
    //dbRef = FirebaseDatabase.instance.ref().child("${widget.uuid}/Status");
    //dbRef = FirebaseDatabase.instance.ref("${widget.uuid}/Status");
    dbRef =
        FirebaseDatabase.instance.ref("Competitions/${widget.competitionId}");

//Competitions

    //TODO NOTE: de to paradigma Panagioty
    /// estila to array me ta questions p to proigoumeno view (admin_view)
    /// j ekama loop se olo to array p typoni sto terminal s
    for (int i = 0; i < widget.listOfQuestions.length; i++) {
      print('loop $i :${widget.listOfQuestions[i]}');
    }
    print("array: ${widget.listOfQuestions}");
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Page'),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (CompStatus == 'open') {
                    CompStatus = 'running';
                    /*Map<String, bool> status = {
                      'status': CompStatus,
                    };*/
                    // Only update the name, leave the age and address!
                    await dbRef.update({
                      "status": 'running',
                    });
                    //dbRef.push().set(status);
                    //dbRef.push().update(status);

                    //dbRef.update(status);
                    //after push, a unique id is generated by the firebase, does not have a identifier
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child: const Text(
                  'Begin competition',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (CompStatus == 'closed') {
                    CompStatus = 'open';
                    /*Map<String, bool> status = {
                      'status': CompStatus,
                    };*/
                    // Only update the name, leave the age and address!
                    await dbRef.update({
                      "status": 'open',
                    });
                    //dbRef.push().set(status);
                    //dbRef.push().update(status);

                    //dbRef.update(status);
                    //after push, a unique id is generated by the firebase, does not have a identifier
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child: const Text(
                  'Open competition',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (CompStatus == 'open' || CompStatus == 'running') {
                    CompStatus = 'closed';
                    /*Map<String, bool> status = {
                      'status': CompStatus,
                    };*/
                    // Only update the name, leave the age and address!
                    await dbRef.update({
                      "status": 'closed',
                    });
                    //dbRef.push().set(status);
                    //dbRef.push().update(status);

                    //dbRef.update(status);
                    //after push, a unique id is generated by the firebase, does not have a identifier
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child: const Text(
                  'Close competition',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text('Timer: ', style: TextStyle(
                  fontSize: 24
                ),),
              ),
              Container(
                alignment: Alignment.center,
                child: Countdown(
                  seconds: timer,
                  build: (BuildContext context, double time) => Text(time.toString()),
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    print('Timer is done!');
                  },
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text('Question:  '+
                  widget.listOfQuestions[i]['question'].toString(),
                  style: TextStyle(fontSize: 23),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: isShown,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Answer:  '+
                    widget.listOfQuestions[i]['answer'].toString(),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isShown = !isShown;
                    if (isShown == true){
                      showAnswer = "hide answer";
                    }
                    else showAnswer = "show answer";

                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child:  Text(
                  showAnswer,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    if (i < widget.listOfQuestions.length - 1) {
                      i++;
                    }
                    timer = widget.listOfQuestions[i+1]['timer'];
                    isShown = false;
                    showAnswer = "show answer";
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child: const Text(
                  'Next question',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     return HomeView(); // pass uuid to AdminSettings
                  //   }));


                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  fixedSize: const Size(50, 50), // Set the button size
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20), // Set the button shape
                    ),
                  ),
                ),
                child: const Text(
                  'End Question',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
