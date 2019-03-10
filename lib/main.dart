import 'package:flutter/material.dart';
import 'login.dart';
import 'VisionTest.dart';
import 'Database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  @override
  void initState() {
    pages
      ..add(VisionTest())
      ..add(VisionTest())
      ..add(DatabasePage())
      ..add(VisionTest())
      ..add(VisionTest())
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('验光'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                tooltip: 'Air it',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                }
            ),
          ],
          backgroundColor: Colors.purple
        // TODO: the button text
      ),

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