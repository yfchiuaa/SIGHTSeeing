import 'package:flutter/material.dart';

class VisionTest extends StatefulWidget{
  @override
  _VisionTestState createState() => _VisionTestState();
}

class _VisionTestState extends State<VisionTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // divide the whole area by two half
          children: <Widget>[
//            Row(
//              // Text field part
//              children: <Widget>[
//                Column(
//                  // showing the text of items
//                  children: <Widget>[
//                    Text(""),
//                    Text("裸眼远视力"),
//                    Text("戴镜远视力"),
//                    Text("小孔视力"),
//                  ]
//                ),
//                Column(
//                  // left eye
//                  children: <Widget>[
//                    Text("左"),
//                    TextField(),
//                    TextField(),
//                    TextField(),
//                  ],
//                ),
//                Column(
//                  // right eye
//                  children: <Widget>[
//                    Text("右"),
//                    TextField(),
//                    TextField(),
//                    TextField(),
//                  ],
//                ),
//              ],
//            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /// number keyboard
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _keyboardButton("1", 30, 0.2),
                        _keyboardButton("2", 30, 0.2),
                        _keyboardButton("3", 30, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("4", 30, 0.2),
                        _keyboardButton("5", 30, 0.2),
                        _keyboardButton("6", 30, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("7", 30, 0.2),
                        _keyboardButton("8", 30, 0.2),
                        _keyboardButton("9", 30, 0.2),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _keyboardButton("", 30, 0.2),
                        _keyboardButton("0", 30, 0.2),
                        _keyboardButton("", 30, 0.2),
                      ],
                    ),
                  ],
                ),
                /// special keys
                Column(
                  children: <Widget>[
                    _specialButton(Icons.backspace, 30, 0.4),
                    _keyboardButton(".", 60, 0.4),
                    _specialButton(Icons.add, 30, 0.4),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _keyboardButton( String text, double keyHeight , double ratio){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      height: keyHeight,
      child: RaisedButton(
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
        onPressed: () => {},
        child: Icon(icon),
      ),
    );
  }
}