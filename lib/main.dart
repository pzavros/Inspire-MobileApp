import 'package:flutter/material.dart';
import 'home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';


var uuid = Uuid();

var v1 = uuid.v1();

Future <void> main () async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  debugPrint(v1 + "  //////////////////");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        primaryColor: Colors.white,
      ),
      home: const HomeView(),
    );
  }
}