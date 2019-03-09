import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'SignUp.dart';
import 'Database.dart';
import 'Examine.dart';
import 'login.dart';

import 'VisionTest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Apps demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return VisionTest();
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              title: Text('建立档案'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              title: Text('检查'),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.collections_solid),
              title: Text('资料库'),
            ),
          ],
        ),

        tabBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Icon(CupertinoIcons.home),
                  Text("主頁"),
                ],
              ),

              RaisedButton(
                textColor: Colors.white,
                color: Colors.black,
                child: Text("登出"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),

              RaisedButton(
                child: Text('注册用户'),
                onPressed: (){},
              ),

              RaisedButton(
                child: Text('检查'),
                onPressed: (){},

              ),

              RaisedButton(
                child: Text('资料库'),
                onPressed: (){},

              ),

            ],
          );
        }
      )
    );

  }
}

