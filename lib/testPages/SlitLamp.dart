import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'dart:async';

class SlitLamp extends StatefulWidget{
  final String patientName;
  final String fileNumber;

  /// constructor, take the name and file number
  SlitLamp({Key key, @required this.patientName, @required this.fileNumber}) : super(key: key);

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  static const double HEADING_FONTSIZE = 40;
  static const double SUBTITLE_FONTSIZE = 25;
  static const double PADDING_RATIO = 0.02;
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

      /// add a gesture detector detects a tap action on the box with text
      buttons.add(
        Expanded(
            child: GestureDetector(
            onTap: () {
              /// if the choice is other, we have special
              if (choice == Strings.choice_others && radioValue[key] != choice) {
                /// show dialog to collect what other information
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
                            /// save the string to otherValue[]
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
                            /// clear the controller if the user say cancel
                            formOtherController[key].clear();
                            Navigator.of(context).pop();
                            },
                        ),
                      ],
                    )
                );
              }
              else {
                /// because the choice cannot be choosing other, or just cancel the choice, so clear controller
                formOtherController[key].clear();
                /// also clear the value stored
                otherValue[key] = "";

                /// rebuild the whole widget by changing radio value, to make a certain cell become blur or not blue
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
                /// defines the color of the box, by following the radio value
                color: (radioValue[key] == choice)?
                  Theme.of(context).hintColor: Theme.of(context).disabledColor,
              ),
            )
        ))
      );
    }

    /// after adding all buttons within the string list, return a row
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
      /// defining the box, with filled color and round edges
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child:Column(
          children: <Widget>[
            /// row of right eye, having a "右" and a row of radio buttons
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

                /// just padding
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              ],
            ),
            /// row of left eye, basically same with right eye
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

                /// just padding
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              ],
            ),
          ],
      ),
      )
    );
  }

  /// Return a column with rows of radio buttons
  /// each row contains 3 radio buttons
  /// @param:
  /// - test (String): the name of the testing things
  /// - choice (List of String): the text showing on the buttons
  Container threeChoiceRowList(String test, List<String> choices){
    List<Widget> columnList = [];
    List<String> choiceList = [];

    /// dividing the string list with 3 string one row, and send to radioButtons() to build buttons for it
    int counter = 0;
    for(String choice in choices){
      choiceList.add(choice);
      if(counter % 3 == 2 || counter == choices.length - 1){
        columnList.add(radioButtons(choiceList, test));
        choiceList = [];
      }
      ++ counter;
    }

    /// return a container storing all rows built above
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: columnList,
        ),
      ),
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
          padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0), //defines margin
          children: <Widget>[

            /// the top buttons, logout and mainpage
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
                    /// pop to login page... as login is the first page, so pop until cannot pop is ok
                    while(Navigator.canPop(context)){
                      Navigator.pop(context);
                    };
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// columns writing patient number and name
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// patient name
                  Row(
                    children: <Widget>[
                      /// just padding
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                        child: Text(Strings.patientNameTyping + widget.patientName, textAlign: TextAlign.left,), // name with parameter
                      ),
                    ]
                  ),
                  /// file number
                  Row(
                      children: <Widget>[
                        /// just padding
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                          child: Text(Strings.profileIDTyping + widget.fileNumber, textAlign: TextAlign.left,), // name with parameter
                        ),
                      ]
                  ),
                ],
              ),
            ),

            /// print title
            Center(child: Text( Strings.slitLamp, style: TextStyle(fontSize: HEADING_FONTSIZE),),),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// list of form with many buttons
            Center(child: Text( Strings.slit_eyelid, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_eyelid,
                [Strings.choice_normal, Strings.choice_upperLidDrooping, Strings.choice_others]),
            Center(child: Text( Strings.slit_conjunctiva, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_conjunctiva,
                [Strings.choice_normal, Strings.choice_bloodFilled, Strings.choice_others]),
            Center(child: Text( Strings.slit_cornea, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_cornea,
                [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_others]),
            Center(child: Text( Strings.slit_lens, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_lens,
                [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_absent, Strings.choice_others]),

            /// padding with printing test title
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            Center(child: Text( Strings.hirschberg, style: TextStyle(fontSize: HEADING_FONTSIZE),),),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// list of form with hirschberg
            Center(child: Text( Strings.slit_Hirschbergtest, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_Hirschbergtest,
                [Strings.choice_normal, Strings.choice_lookoutward,
                Strings.choice_lookinward, Strings.choice_lookupward, Strings.choice_notabletostare]),
            Center(child: Text( Strings.slit_exchange, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            threeChoiceRowList(Strings.slit_exchange,
                [Strings.choice_notmoving, Strings.choice_outsidetomiddle, Strings.choice_insidetomiddle,
                Strings.choice_uppertomiddle, Strings.choice_inneruppertomiddle, Strings.choice_outeruppertomiddle]),
            Center(child: Text( Strings.slit_eyeballshivering, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            threeChoiceRowList(Strings.slit_eyeballshivering,
              [Strings.choice_nothing, Strings.choice_shown, Strings.choice_notshown, Strings.choice_both]),

            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            /// confirm button
            Center(
              child: RaisedButton(
                  onPressed: (){
                    // TODO:  change!!!!
                    _saveData();
                    Navigator.pop(context);
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