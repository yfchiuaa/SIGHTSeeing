import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() => runApp(FirstPage());

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      home: LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget{
  @override
  LoginPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState(){
    return _LoginPageState();
  }
}


class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Text('JISEC Login'),
              ],
            ),

            /// Username
            SizedBox(height: 120.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
              ),
            ),

            /// Password
            SizedBox(height: 12.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'password',
                filled: true,
              ),
              obscureText: true,
            ),

            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('Back'),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                    child: Text('Next'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyApp())
                      );
                    }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}