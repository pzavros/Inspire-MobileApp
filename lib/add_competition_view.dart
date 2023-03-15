import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddCompetition extends StatefulWidget {
  const AddCompetition({Key? key}) : super(key: key);

  @override
  State<AddCompetition> createState() => _AddCompetitionState();
}

class _AddCompetitionState extends State<AddCompetition> {
  // get instance from firebase
  Query db = FirebaseDatabase.instance.ref().child('Competitions');
  late DatabaseReference dbRef;
  // default pop up message
  late String popupTitle = "Fail";
  late String popupMsg = "The name cannot be empty or name already exist.";
  // variable for competition name
  final nameController = TextEditingController();

  @override
  void initState() {
    dbRef = FirebaseDatabase.instance.ref("Competitions");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      ),
                      const SizedBox(
                        height: 30,
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
                    // competition name
                    if (nameController.text.isNotEmpty) {
                      //TODO when name not empty, we also needs to check if name already exist in the database
                      popupTitle = "Success";
                      popupMsg = "New data has been added to the database.";
                      Map<String, dynamic> competition = {
                        'name': nameController.text,
                      };
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
                        },);
                  },
                  child: const Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                )),
          ),
        ),);
  }
}