import 'package:flutter/material.dart';
import 'leaderboard.dart';
import 'Questions.dart';

import 'home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final myController = TextEditingController();

  int score = 4;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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
                    MaterialPageRoute(
                        builder: (context) => HomeView()),
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
                        builder: (context) =>  LeaderBoard(score:score)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Questions()),
                  );
                },
                child: const Icon(Icons.navigate_next),
              ),
            ),
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
