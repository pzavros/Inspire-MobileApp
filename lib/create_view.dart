import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateView extends StatefulWidget {
  const CreateView({Key? key}) : super(key: key);

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  final nameController = TextEditingController();
  late String popupTitle = "Fail";
  late String popupMsg = "The name cannot be empty or name already exist.";
  late DatabaseReference dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref("Competitions");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
                title: const Text(
              "New Competition",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            )),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                    flex: 9,
                    child: Container(
                      color: Colors.white,
                      child: FractionallySizedBox(
                        alignment: FractionalOffset.center,
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
                                labelText: 'Name ...',
                              ),
                              validator: (String? value) {
                                return (value!.isEmpty)
                                    ? 'Name is Required!'
                                    : '';
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Question 1:',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                      // style: ButtonStyle(
                                      //     //backgroundColor:
                                      //     ),
                                    )
                                  ],
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Question ...',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Answer ...',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          labelText: 'Timespan ...',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    )),
                Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                      child: MaterialButton(
                    onPressed: () async {
                      if (nameController.text.isNotEmpty) {
                        popupTitle = "Success";
                        popupMsg = "New data has been added to the database.";
                        dbRef.push().set(nameController.text);
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
                )
              ],
            )));
  }
}
