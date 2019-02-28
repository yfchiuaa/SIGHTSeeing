import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExaminePage extends StatefulWidget{

  @override
  _ExaminePageState createState() => _ExaminePageState();
}

class _ExaminePageState extends State<ExaminePage> {

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Examine"),
      ],
    );
  }
}