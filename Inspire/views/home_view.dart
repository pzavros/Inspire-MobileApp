import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey[400]),
                          onPressed: () {},
                          child: const Text("Instructor"),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey[400]),
                            onPressed: () {},
                            child: const Text("Refresh"),
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Math                  ",
                          style: TextStyle(
                              fontSize: 42, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "       Competition",
                          style: TextStyle(
                              fontSize: 42, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Please select the available competition:",
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                            height: 400,
                            //color: Colors.yellow,
                            child: ListView(
                              children: [
                                Container(
                                  height: 50,
                                  color: Colors.grey[400],
                                  child: const Center(
                                    child: Text(
                                      "Competition 1",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.grey[400],
                                  child: const Center(
                                    child: Text(
                                      "Competition 2",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.grey[400],
                                  child: const Center(
                                    child: Text(
                                      "Competition 3",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                        ElevatedButton(
                            onPressed: (){},
                            child: Text("Enter",style: TextStyle(fontSize: 18),))
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
