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
      /// SET UP THEME DATA
      theme: ThemeData(
        backgroundColor: const Color(0xFFdaecf7),
        indicatorColor: Colors.black87,
        hintColor: Colors.indigoAccent,
        disabledColor: Colors.white,
        canvasColor: const Color(0xFFc4e4f4),
      ),

      home: LoginPage(),

      routes: {
        '/Login' : (context) => LoginPage(),
        '/HomePage' : (context) => HomePage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// INITIATE STATE for login username and password
  TextEditingController userNameController;
  TextEditingController passwordController;
  @override
  void initState(){
    super.initState();
    userNameController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Solving the pixel overflow when typing
        resizeToAvoidBottomPadding: false, 
        // Setting backgraound color of whole page
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
                  )
              ),
              
              /// MAIN CONTAINER FOR FORM
              child: Container(
                padding: const EdgeInsets.only(left: 40.0, right:40.0, top:220.0, bottom:40.0),

                //// MAIN structure 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //// Textfield for USER NAME
                    TextFormField(
                      // State the controller for userName
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: Strings.loginname,
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Theme.of(context).indicatorColor),
                    ),

                    //// Textfield for PASSWORD
                    TextFormField(
                      // State the controller for password
                      controller: passwordController,
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

                    //// LOGIN BUTTON 
                    MaterialButton(
                        color: Colors.grey,
                        textColor: Colors.black,
                        child: Text(Strings.loginbutton,),
                        onPressed:(){
                          // For ‘登陸' button
                          Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => HomePage())).then( (value){
                            setState(() {
                              userNameController.clear();
                              passwordController.clear();
                            });
                          } );

                          // clear the contents inside text fields
                          //userNameController.clear();
                          //passwordController.clear();
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
