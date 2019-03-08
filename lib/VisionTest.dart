import 'package:flutter/material.dart';

class VisionTest extends StatefulWidget{
  @override
  _VisionTestState createState() => _VisionTestState();
}

class _VisionTestState extends State<VisionTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // divide the whole area by two half
          children: <Widget>[
            Row(
              // Text field part
              children: <Widget>[
                Column(
                  // showing the text of items
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    null,
                    Text("裸眼远视力"),
                    Text("戴镜远视力"),
                    Text("小孔视力"),
                  ]
                ),
                Column(
                  // left eye
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("左"),
                    TextField(),
                    TextField(),
                    TextField(),
                  ],
                ),
                Column(
                  // right eye
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("右"),
                    TextField(),
                    TextField(),
                    TextField(),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  // number keys
                ),

                Column(
                  // special keys
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}