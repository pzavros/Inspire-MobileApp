import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'class/question_obj.dart';
import 'modify_view.dart';



class AddQuestion extends StatefulWidget {
  const AddQuestion({required this.competitionId, required this.currentIndex,Key? key}) : super(key: key);
  final String competitionId;
  final int? currentIndex;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  // variables for the question form
  final qController = TextEditingController();
  final aController = TextEditingController();
  final tController = TextEditingController();
  final pController = TextEditingController();
  // initialize a reference of the firebase
  late DatabaseReference dbRef;
  DatabaseReference db=FirebaseDatabase.instance.ref();

  int index=0;
  List listOfQuestion=[];
  late List <Question>? listOfObj;

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref('Competitions/${widget.competitionId}/');
    // check the index which tracks the position of each question is implemented(meaning has question) or not(meaning there is no question)
    if(widget.currentIndex!=null){
      index=(widget.currentIndex!+1);
    }
    // print(widget.currentIndex);
    //getData('Competitions/${widget.competitionId}/questions');
    //(widget.questionArray!=null)?print(widget.questionArray):print(null);
    // for (int i=0; i<widget.questionArray!.length; i++){
    //   print(widget.questionArray![i]);
    // }
    //print(widget.questionArray);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getFromController(TextEditingController controller) {
    return int.parse(controller.value.text);
  }

  Future<void> getData(String path) async {
    final snapshot =  await db.child(path).get();
    if (snapshot.exists) {
      // listOfObj=snapshot.value;
      //print(listOfObj);
      print(snapshot.value);
      // print(snapshot.value.runtimeType);
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add question"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Column(
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
                    controller: tController,
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
                  TextFormField(
                    controller: pController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Score',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          color: Colors.blue,
          child: Container(
            height: 55,
            alignment: AlignmentDirectional.centerStart,
            child: MaterialButton(
                onPressed: (){
                  // navigate to show all question view
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   QuestionView(competitionId: widget.competitionId,)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Modify",style: TextStyle(color: Colors.white, fontSize: 26),),
                    Container(width: 50,),
                  ],)
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          //add new question form (Q&A plus time in minutes)
          onPressed: () {
            setState(() {
              // keep a track of the index
              dbRef.update({
                'index':index,
              });
              // add question
              dbRef.child("questions/$index").update({
                'question':qController.text,
                'answer':aController.text,
                'timer':getFromController(tController),
                'point':getFromController(pController),
              });
              // move to next position
              index++;
              // clear the form
              qController.clear();
              aController.clear();
              tController.clear();
              pController.clear();
            }
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}
