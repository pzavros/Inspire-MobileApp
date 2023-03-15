import 'package:dilemma_game/question_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AddQuestion extends StatefulWidget {
  const AddQuestion({required this.competitionId,Key? key}) : super(key: key);
  final String competitionId;

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final qController = TextEditingController();
  final aController = TextEditingController();
  final tController = TextEditingController();

  late DatabaseReference dbRef;
  late String s;
  DatabaseReference db=FirebaseDatabase.instance.ref();
  int cntQ=0;

  int getFromController(TextEditingController controller) {
    return int.parse(controller.value.text);
  }


  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref('Competitions/${widget.competitionId}/questions');
  }

  Future<void> getData(String path) async {
    final snapshot =  await db.child(path).get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                //Navigator.push(context, MaterialPageRoute(builder: (context) =>  const QuestionView()));
              },
              child: const Text("show all questions",style: TextStyle(color: Colors.white, fontSize: 26),),
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //add new question form (Q&A plus time in minutes)
          //if(dbRef.child("$competitionKey/questions").onChildAdded)
          setState(() {
            // cntQ++;
            // dbRef.child("$cntQ").update({
            //   'question':qController.text,
            //   'answer':aController.text,
            //   'timer':getFromController(tController),
            // });
            // Map<String, dynamic> question = {
            //   'question':qController.text,
            //   'answer':aController.text,
            //   'timer':getFromController(tController),
            // };
            // dbRef.push().set(question);
            //
            // qController.clear();
            // aController.clear();
            // tController.clear();
          });
          //debugPrint("----------> question ${cntQ}");
          getData("Competitions/${widget.competitionId}");

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
