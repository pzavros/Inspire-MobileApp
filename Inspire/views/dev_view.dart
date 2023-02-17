import 'package:flutter/material.dart';

class DevView extends StatelessWidget {
  const DevView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
                height: 100,
                child: Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: const Text(
                          "Instructor",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey[400]),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Back"),
                          )),
                    ],
                  ),
                )),
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
                        const Text(
                          "Name of the competition:",
                          style: TextStyle(fontSize: 26),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Name...',
                          ),
                        ),
                        SizedBox(height: 30,)
                        ,
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Question 1:', style: TextStyle(fontSize: 24),),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Remove",),
                                  style: ButtonStyle(
                                    //backgroundColor:
                                  ),
                                )
                              ],
                            ),

                            Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Question...',
                                    ),
                                  ),
                                  SizedBox(height: 10,)
                                  ,
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Answer...',
                                    ),
                                  ),
                                  SizedBox(height: 10,)
                                  ,
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Timespan...',
                                    ),
                                  ),
                                  SizedBox(height: 5,)
                                  ,
                                ],
                              ),
                            ),
                            ElevatedButton(onPressed: (){}, child: Text('Add')),
                            //SizedBox(height: 30,)
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              height: 80,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 1)),
                  )),
                  Flexible(
                      child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  )),
                ],
              ),
            )
          ],
        ));
  }
}
