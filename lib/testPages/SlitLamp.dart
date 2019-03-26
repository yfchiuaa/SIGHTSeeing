import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'dart:async';

class SlitLamp extends StatefulWidget{

  /// constructor, take the name and file number
  SlitLamp({Key key}) : super(key: key);

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  Map<String, String> radioValue;
  Map<String, TextEditingController> formOtherController;
  Map<String, String> otherValue;

  @override
  void initState(){
    super.initState();
    radioValue = Map();
    formOtherController = Map();
    otherValue = Map();
  }

  /// Return a row of radio button
  /// @param:
  /// - choices (List of String): the text showing on the buttons
  /// - key (String): to search in radioValues
  Widget radioButtons(List<String> choices, String key){
    List<Widget> buttons = [];

    for(String choice in choices){
      if(formOtherController[key] == null) formOtherController[key] = new TextEditingController();

      buttons.add(
        Expanded(
            child: GestureDetector(
            onTap: () {
              if (choice == Strings.choice_others && radioValue[key] != choice) {
                showDialog(context: context,
                    builder: (context) => AlertDialog(
                      title: Text(key + Strings.slit_AlertQuestion),
                      content: TextField(
                        controller: formOtherController[key],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(Strings.confirm),
                          onPressed: (){
                            otherValue[key] = formOtherController[key].toString();
                            setState(() {
                              if (radioValue[key] != choice)
                                radioValue[key] = choice;
                              else
                                radioValue[key] = "";
                            });
                            Navigator.of(context).pop();
                            },
                        ),
                        FlatButton(
                          child: Text(Strings.cancel),
                          onPressed: () {
                            formOtherController[key].clear();
                            Navigator.of(context).pop();
                            },
                        ),
                      ],
                    )
                );
              }
              else {
                formOtherController[key].clear();
                otherValue[key] = "";
                setState(() {
                  if (radioValue[key] != choice)
                    radioValue[key] = choice;
                  else
                    radioValue[key] = "";
                });
              }
            },
            child: Container(
              child: Text(choice,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: (radioValue[key] == choice)?
                  Theme.of(context).hintColor: Theme.of(context).disabledColor,
                /*
                border: Border(
                    left: BorderSide(width: 1.0, color: Theme.of(context).indicatorColor),
                  right: BorderSide(width: 1.0, color: Theme.of(context).indicatorColor)
                )
                */
              ),
            )
        ))
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  /// Return a single test form with left and right eye
  /// @param:
  /// - test (String): the name of the testing things
  /// - choice (List of String): the text showing on the buttons
  Container leftRightChoiceButtonList(String test, List<String> choices){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child:Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(Strings.right, textAlign: TextAlign.center,),
                ),
                Expanded(child: radioButtons(choices, test + Strings.right)),

                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(Strings.left, textAlign: TextAlign.center,),
                ),
                Expanded(child: radioButtons(choices, test + Strings.left)),

                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              ],
            ),
          ],
      ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Main body of the page
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomPadding: false,
        body: ListView(
          padding: EdgeInsets.all(20), // defines margin
          children: <Widget>[

            /// the top buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  // main page
                  child: Text(Strings.mainpageButton),
                  onPressed: (){
                    // TODO: developer
                  },
                ),
                RaisedButton(
                  // log out
                  child: Text(Strings.logoutButton),
                  onPressed: (){
                    // TODO: developer
                  },
                ),
              ],
            ),

            /// columns writing patient number and name
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                        child: Text(Strings.patientNameTyping, textAlign: TextAlign.left,), // name with parameter
                      ),
                    ]
                  ),
                  Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                          child: Text(Strings.profileIDTyping, textAlign: TextAlign.left,), // name with parameter
                        ),
                      ]
                  ),
                ],
              ),
            ),
            Center(child: Text( Strings.slitLamp, style: TextStyle(fontSize: 40),),),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

            /// list of form with many buttons
            Center(child: Text( Strings.slit_eyelid, style: TextStyle(fontSize: 30),),),
            leftRightChoiceButtonList(Strings.slit_eyelid,
                [Strings.choice_normal, Strings.choice_upperLidDrooping, Strings.choice_others]),
            Center(child: Text( Strings.slit_conjunctiva, style: TextStyle(fontSize: 30),),),
            leftRightChoiceButtonList(Strings.slit_conjunctiva,
                [Strings.choice_normal, Strings.choice_bloodFilled, Strings.choice_others]),
            Center(child: Text( Strings.slit_cornea, style: TextStyle(fontSize: 30),),),
            leftRightChoiceButtonList(Strings.slit_cornea,
                [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_others]),
            Center(child: Text( Strings.slit_lens, style: TextStyle(fontSize: 30),),),
            leftRightChoiceButtonList(Strings.slit_lens,
                [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_absent, Strings.choice_others]),

            /// confirm button
            Center(
              child: RaisedButton(
                  onPressed: (){
                    // TODO: pop out from the page with save
                    _saveData();
                  },
                child: Text(Strings.confirm),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.leavingAlertQuestion),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.confirm),
            onPressed: (){
              _saveData();
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

  void _saveData(){
    // TODO: by developers, use http to link the API and send the data
  }
}