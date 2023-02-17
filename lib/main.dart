import 'package:flutter/material.dart';
import 'home_view.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget {

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