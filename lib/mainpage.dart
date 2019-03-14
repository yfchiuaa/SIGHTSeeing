import 'package:flutter/material.dart';
import 'VisionOptometry.dart';
import 'Database.dart';
import 'package:my_app/SlitLampRewrite.dart';
import 'Consultation.dart';

//void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Scaffold',
      // theme: share color and font through the apps
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default Font Family
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState(){
    return _MyStatefulWidgetState();
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  List<Widget> pages = List();

  List<String> _visionTestList = ["视力检查", "裸眼远视力", "戴镜远视力", "小孔视力"];
  List<String> _optometryList = ["验光", "散瞳前屈光度", "散瞳前散光度", "散瞳前轴位度"];

  @override
  void initState() {
    pages
      ..add( VisionOptometry(checkingDetails: _visionTestList))
      ..add( VisionOptometry(checkingDetails: _optometryList))
      ..add( DatabasePage())
      ..add( SlitLamp())
      ..add( Consultation())
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        // Avoid the problem of bottom becoming white
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.panorama_fish_eye),
              title: Text('视力检查')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('验光')),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('Profile')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Slip lamp')),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text('Consultation')
          )

          // TODO: Bottom navifation bar can only have 3 or 5 items
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,

        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}