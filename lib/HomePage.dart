import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'UserSearch.dart';

class HomePage extends StatefulWidget{
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0),
          children: <Widget>[
            // Top row, two buttons with homepage and logout
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  // log out
                  child: Text(Strings.logoutButton),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),),
            /// four buttons defines at bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// define a custom button
                /// GestureDetector -> Container (define decoration, size) -> Column ( contains a image, text )
                /// same for bottom, have four gesture detectors
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Vision.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Text(Strings.visionTest,
                            style: TextStyle(fontSize: 20.0, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /// define the tap action : push to the desired page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            UserSearch(test: Strings.visionTest)));
                  },
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Optometry.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Text(Strings.optometry,
                            style: TextStyle(fontSize: 20.0, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /// define the tap action : push to the desired page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            UserSearch(test: Strings.optometry)));
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/SlitLamp.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Text(Strings.slitLamp,
                            style: TextStyle(fontSize: 20.0, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /// define the tap action : push to the desired page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            UserSearch(test: Strings.slitLamp)));
                  },
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Review.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Text(Strings.reviewingProfile,
                            style: TextStyle(fontSize: 20.0, color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /// define the tap action : push to the desired page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            UserSearch(test: Strings.reviewingProfile)));
                  },
                ),
              ],
            ),
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
        title: Text(Strings.logoutAlertQuestion),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.confirm),
            onPressed: (){
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

}