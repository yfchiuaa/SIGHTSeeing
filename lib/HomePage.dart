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
    // WillPopScope for andirod back pressed button
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          
          padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0),
          children: <Widget>[

            // TOP ROW for LOGOUT 
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
            
            // Padding for empty space
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),),

            /// FOUR BUTTONS FOR CHECKING OPTIONS
            // Each gesture detector represents an option button 
             
            /// ROW FOR vision test and Optometry 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                /// VISION TEST BUTTON
                GestureDetector(
                  // Container example with boxdecoration
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),

                    // Property for vision test button
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,

                    /// A COLUMN FOR IMAGES AND TEXT
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // CONTAINER FOR ICONS
                        Container(
                          // Property for images
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,

                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Vision.png'),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),

                        /// CONTAINERS FOR TEXT
                        Text(Strings.visionTest,
                            style: TextStyle(fontSize: 20.0, color: Colors.black)
                        ),
                      ],
                    ),
                  ),

                  // ONTAP NAVIGATE TO VISION TEST
                  onTap: () {
                    /// define the tap action : push to the desired page
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) =>
                            UserSearch(test: Strings.visionTest)));
                  },
                ),

                /// OPTOMETRY BUTTON
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),

                    // Property of optemetry button
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

            // Padding for empty space
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),),
            
            /// ROW FOR SLIT LAMP AND CONSULTATION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                /// SLIT LAMP BUTTON 
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),

                    // Property of slip lamp button
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

                /// CONSULTATION BUTTON
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(9.0),
                    ),

                    // Property of consultation button
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
    // showDialog: pop up a scope 
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.logoutAlertQuestion),
        actions: <Widget>[
          // Confirm button
          FlatButton(
            child: Text(Strings.confirm),
            onPressed: (){
              // pop = true: pop back to login page
              Navigator.of(context).pop(true);
            },
          ),
          // Cancel button
          FlatButton(
            child: Text(Strings.cancel),
            onPressed: (){
              // pop = false: not pop back to login page
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    )??false;  // TODO: What is this false used for 
  }

}