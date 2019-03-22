import 'package:flutter/material.dart';
import 'package:myapp/string.dart';

class VisionOptometry extends StatefulWidget{
  final String patientName;
  final String fileNumber;

  VisionOptometry({Key key, @required this.patientName, @required this.fileNumber})
      : super(key: key);

  @override
  _VisionOptometryState createState() => _VisionOptometryState();
}

class _VisionOptometryState extends State<VisionOptometry>{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            // Top row, two buttons with homepage and logout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  // main page
                  child: Text(""), // TODO: fill the text after srting.dart complete
                  onPressed: (){
                    // TODO: developer, link with home page, use popUntil
                  },
                ),
                RaisedButton(
                  // log out
                  child: Text(""), // TODO: fill the text after srting.dart complete
                  onPressed: (){
                    // TODO: developer, link with log in page, use popUntil
                  },
                ),
              ],
            ),
            // TODO: define page body here
          ],
        ),
      ),
    );
  }

  /// function defines the action after back button is pressed
  /// what is doing now: pop out a alert window with 2 buttons, save or back
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.leavingAlertQuestion),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.confirm),
            onPressed: (){
              _saveData();
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text(Strings.cancel),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    )??false;
  }

  void _saveData(){
    // TODO: by developers, use http to link the API and send the datas
  }
}