import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin_view.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({required this.competitionId, Key? key}) : super(key: key);
  final String competitionId;

  @override
  State<QuestionView> createState() => _HomeViewState();
}

class _HomeViewState extends State<QuestionView> {
  // variables for the question form
  final qController = TextEditingController();
  final aController = TextEditingController();
  final tController = TextEditingController();
  final pController = TextEditingController();
  Query dbRef = FirebaseDatabase.instance.ref();
  DatabaseReference db=FirebaseDatabase.instance.ref();

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref('Competitions/${widget.competitionId}/questions');
    db = FirebaseDatabase.instance.ref('Competitions/${widget.competitionId}/questions');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  int getFromController(TextEditingController controller) {
    return int.parse(controller.value.text);
  }

  Widget myWidget({required Map competition}){
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      height: 120,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question: ${competition['question']}'),
            const SizedBox(height: 20,),
            Text("Answer: ${competition ['answer']}"),
            const SizedBox(height: 20,),
            Row(
              children: [
                Text('Timer: ${competition['timer']}'),
                const SizedBox(width: 50,),
                Text('Point: ${competition['point']}'),
              ],),
          ],),
        Container(height: double.infinity,width: 60,color: Colors.blue.shade200,
          child: IconButton(onPressed: (){
              showDialog(context: context,
                builder: (context)=> AlertDialog(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ const Text('Edit'),IconButton(onPressed: (){
                      // db.child('/${competition['key']}').remove();
                      showDialog(context: context, builder: (context) =>  AlertDialog(title:const Text('Function not implemented yet.')
                        ,content: TextButton(child: const Text('OK'),onPressed: () => Navigator.pop(context),),
                      ),);
                      }, icon: const Icon(Icons.delete,color: Colors.red,))],),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
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
                          labelText: 'Point',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      TextButton(onPressed: () {
                        qController.clear();
                        aController.clear();
                        tController.clear();
                        pController.clear();
                        Navigator.pop(context);
                        }, child: const Text('CANCEL')),
                      TextButton(
                          onPressed: () {
                            // this allow us to update a specific object
                            if(qController.text.isEmpty){qController.text=competition['question'];}
                            if(aController.text.isEmpty){aController.text=competition['answer'];}
                            if(tController.text.isEmpty){tController.text=competition['timer'];}
                            if(pController.text.isEmpty){pController.text=competition['point'];}
                        db.child(competition['key']).update({
                          'question':qController.text,
                          'answer':aController.text,
                          'timer':getFromController(tController),
                          'point':getFromController(pController),
                        });
                        qController.clear();
                        aController.clear();
                        tController.clear();
                        pController.clear();
                        Navigator.pop(context);
                        }, child: const Text('APPLY')),
                    ],)],
                  ),
                )
              );
            },icon: const Icon(Icons.mode),),),
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Modify", style: TextStyle(fontSize: 26,)),
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