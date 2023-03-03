import 'package:flutter/material.dart';
import 'Questions.dart';
import 'leaderboard.dart';



void main() {
  runApp(const AdminPage());
}
class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

      Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50), // Set the button size
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20), // Set the button shape
                  ),
                ),
              ),
              child: const Text('Begin competition',
                style: TextStyle(fontSize: 20),
              ),
            ),

            ElevatedButton(
              onPressed: () {

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
              child: const Text('Open competition',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {

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
              child: const Text('Close competition',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Question 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Answer 1',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(50, 50), // Set the button size
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20), // Set the button shape
                  ),
                ),
              ),
              child: const Text('Show answer',
                style: TextStyle(fontSize: 20),
              ),
            ),

            ElevatedButton(
              onPressed: () {

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
              child: const Text('Next question',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {

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
              child: const Text('End Question',
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