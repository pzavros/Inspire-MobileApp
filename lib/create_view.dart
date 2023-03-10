import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateView extends StatefulWidget {
  const CreateView({Key? key}) : super(key: key);

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  Query db = FirebaseDatabase.instance.ref().child('Competitions');
  final nameController = TextEditingController();
  final qController = TextEditingController();
  final aController = TextEditingController();
  // String ques="";
  // String answ="";
   int time=0;

  int cntQ=0;
  List <Question> listOfQuestions=[];
  //late Questions qObj;


  late DatabaseReference dbRef;
  // default pop up message
  late String popupTitle = "Fail";
  late String popupMsg = "The name cannot be empty or name already exist.";

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref("Competitions");
    // Question q=Question(question: "question", answer: "answer", timer: 1);
    // String j=jsonEncode(q);
    // debugPrint(j);
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: const Text(
            "New Competition",
            style: TextStyle(
              fontSize: 26,
            ),
          )),
          body: Column(
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.topCenter,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Name',
                        ),
                        validator: (String? value) {
                          return (value!.isEmpty) ? 'Name is Required!' : '';
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                'Question ${cntQ + 1}:',
                                style: TextStyle(fontSize: 24),
                              ),
                              IconButton(
                                // add question
                                onPressed: () {

                                },
                                icon: const Icon(Icons.delete),

                              ),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: qController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Question',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: aController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Answer',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Timespan (min)',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: const CircularNotchedRectangle(),
            color: Colors.blue,
            child: Container(
                height: 50,
                margin:const EdgeInsets.fromLTRB(16, 0, 0, 0),
                alignment: AlignmentDirectional.centerStart,
                child: MaterialButton(
                  onPressed: () async {
                    // dbRef.onValue.listen((event) {
                    //   debugPrint("debugPrint---------->${event.snapshot.value}");// prints the obj
                    // });
                    // competition name
                    if (nameController.text.isNotEmpty) {
                      //TODO when name not empty, we also needs to check if name already exist in the database
                      //...
                      popupTitle = "Success";
                      popupMsg = "New data has been added to the database.";
                      Map<String, dynamic> competition = {
                        'name': nameController.text,
                        'totalQ':cntQ,
                        'questions':jsonEncode(listOfQuestions)
                      };
                      // ideally it should look like this
                      // Map<String, dynamic> competition = {
                      //   'name': nameController.text,
                      //   'totalQ':cntQ,
                      //   'questions': {
                      //     '1':{'question':"1+1", 'answer':"2", 'timer':1},
                      //     '2':{'question':"1+1", 'answer':"2", 'timer':1},
                      //     '3':{'question':"1+1", 'answer':"2", 'timer':1},
                      //   }
                      // };
                      dbRef.push().set(competition);
                    }
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(popupTitle),
                            content: Text(popupMsg),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  if (popupTitle == "Success") {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.pop(context);
                                  }
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                )),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
              onPressed: () {
                //TODO add new question form (Q&A plus timespan)
                setState(() {
                  cntQ++;
                  listOfQuestions.add(Question(question: qController.text,answer: aController.text,timer: time));
                  //listOfQuestions.add(Questions(id: cntQ,question: Question(question: 'q',answer: 'a',timer: 1)));
                  qController.clear();
                  aController.clear();
                });
                debugPrint("debugPrint----------> ${cntQ}");
                debugPrint("debugPrint----------> ${jsonEncode(listOfQuestions)}");
                //listOfQuestions.asMap();

              },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}


// class Questions {
//   int id;
//   Question question;
//
//   Questions({required this.question,required this.id });
//
//   void add(int id, Question q){
//
//   }
//
//
// }


class Question {
  String question,answer;
  int timer;

  Question({required this.question,required this.answer, required this.timer});

  Map toJson()=>{
    'question':question,
    'answer':answer,
    'timer':timer,
  };
//testing
// @override
// String toString() {
//   return '{question: $question, answer: $answer, time:$timer}';
// }
}