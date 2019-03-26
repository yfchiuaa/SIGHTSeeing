import 'package:flutter/material.dart';
import 'string.dart';

class PatientData extends StatefulWidget{
  final String patientName;
  final String fileNumber;

  PatientData({Key key, @required this.patientName, @required this.fileNumber}) : super(key:key);

  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0),
        children: <Widget>[

        ],
      ),
    );
  }
}