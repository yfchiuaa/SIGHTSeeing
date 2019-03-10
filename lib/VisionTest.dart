import 'package:flutter/material.dart';
import 'NoKeyboardTextField.dart';

class VisionTest extends StatefulWidget{
  @override
  _VisionTestState createState() => _VisionTestState();
}

class _VisionTestState extends State<VisionTest> {
  final double KEY_HEIGHT = 60;
  final double TEXT_HEIGHT = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // divide the whole area by two half
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _showingText("", TEXT_HEIGHT, 0.4, TextAlign.center),
                    _showingText("左", TEXT_HEIGHT, 0.3, TextAlign.left),
                    _showingText("右", TEXT_HEIGHT, 0.3, TextAlign.left),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _showingText("裸眼远视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _showingText("戴镜远视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _showingText("小孔视力", TEXT_HEIGHT, 0.4, TextAlign.center),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                    _inputTextField(TEXT_HEIGHT, 0.3),
                  ],
                ),
              ]
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// number keyboard
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _keyboardButton("1", KEY_HEIGHT, 0.2),
                        _keyboardButton("2", KEY_HEIGHT, 0.2),
                        _keyboardButton("3", KEY_HEIGHT, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("4", KEY_HEIGHT, 0.2),
                        _keyboardButton("5", KEY_HEIGHT, 0.2),
                        _keyboardButton("6", KEY_HEIGHT, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("7", KEY_HEIGHT, 0.2),
                        _keyboardButton("8", KEY_HEIGHT, 0.2),
                        _keyboardButton("9", KEY_HEIGHT, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("", KEY_HEIGHT, 0.2),
                        _keyboardButton("0", KEY_HEIGHT, 0.2),
                        _keyboardButton("", KEY_HEIGHT, 0.2),
                      ],
                    ),
                  ],
                ),
                /// special keys
                Column(
                  children: <Widget>[
                    _specialButton(Icons.backspace, KEY_HEIGHT, 0.4),
                    _keyboardButton(".", KEY_HEIGHT * 2, 0.4),
                    _specialButton(Icons.add, KEY_HEIGHT, 0.4),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _showingText( String text, double boxHeight, double ratio, TextAlign alignment){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      height: boxHeight,
      child: Text(text,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  SizedBox _inputTextField( double boxHeight, double ratio){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      height: boxHeight,
      child: NoKeyboardEditableText(
          controller: TextEditingController(
            text: "number",
          ),
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          cursorColor: Color.fromRGBO(0, 0, 0, 0.9)),
    );
  }

  SizedBox _keyboardButton( String text, double keyHeight , double ratio){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      height: keyHeight,
      child: RaisedButton(
        padding: EdgeInsets.all(3),
        onPressed: (){},
        child: Text(text),
      ),
    );
  }

  SizedBox _specialButton( IconData icon, double keyHeight , double ratio){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      height: keyHeight,
      child: RaisedButton(
        padding: EdgeInsets.all(3),
        onPressed: () {},
        child: Icon(icon),
      ),
    );
  }
}