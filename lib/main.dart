import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

String v1 = "";

Future <void> main () async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // check that a UUID exists. if not create one.
  // 1. read UUID from Prefs
  final prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey('uuid')) {
    v1 = prefs.getString('uuid')!;
  } else {
    var uuid = const Uuid();
    v1 = uuid.v1();
    prefs.setString('uuid', v1);
  }
  debugPrint("---> $v1 <-----");

  // 2. if it does not exist, create and write to Prefs
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