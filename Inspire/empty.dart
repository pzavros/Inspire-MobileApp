import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  late final int score;
  EmptyPage({Key? key, required this.score}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Empty Page"),
      ),
      body: Center(
        child: Text("This is an empty page"),
      ),
    );
  }
}



