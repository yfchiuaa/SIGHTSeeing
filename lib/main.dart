import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'string.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // TODO: set the main theme here, set the colors
        backgroundColor: const Color(0xFFdaecf7),
        indicatorColor: Colors.black87,
        hintColor: Colors.indigoAccent,
        disabledColor: Colors.white,
        canvasColor: const Color(0xFFc4e4f4),
      ),

      home: LoginPage(title: 'Flutter Demo Home Page'),

    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: build your login page here, change the body page
    return Scaffold(
      // below build by suki
        resizeToAvoidBottomPadding: false, // add this line because pixel overflow may occur while typing
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          child: Form(
            child: Theme(
              data:ThemeData(
                  brightness:Brightness.dark, //primarySwatch: Colors.black87,
                  inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                          color: Theme.of(context).indicatorColor, fontSize: 20.0
                      )
                  )),
              child: Container(
                padding: const EdgeInsets.only(left: 40.0, right:40.0, top:220.0, bottom:40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: Strings.loginname,
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                    TextFormField(
                      decoration:InputDecoration(
                        labelText: Strings.loginpassword,
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:25.0),
                    ),
                    MaterialButton(
                        color: Colors.grey,
                        textColor: Colors.black,
                        child: Text(Strings.loginbutton,),
                        onPressed:(){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
