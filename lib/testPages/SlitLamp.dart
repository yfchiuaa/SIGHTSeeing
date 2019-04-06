import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'dart:async';
import 'package:myapp/PatientData.dart';

class SlitLamp extends StatefulWidget{
  final String patientName;
  final String fileNumber;

  /// constructor, take the name and file number
  SlitLamp({Key key, @required this.patientName, @required this.fileNumber}) : super(key: key);

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  /// constant variable for unique sizing in form fields
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  static const double HEADING_FONTSIZE = 40;
  static const double SUBTITLE_FONTSIZE = 25;
  static const double PADDING_RATIO = 0.02;

  // map storing the choice that user made in each multiple choice box
  Map<String, String> radioValue;

  // map storing the text controller of '其他'
  // e.g. formOtherController['眼臉左'] will return the text field controller inside the alert window
  //       the alert window only shows up when '其他' is pressed
  Map<String, TextEditingController> formOtherController;

  // map storing the value of '其他'
  // e.g. in alert window, user typed '盲了' in text field and confirm
  //       then, otherValue['眼臉左'] = '盲了'
  Map<String, String> otherValue;

  // construct
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
    List<Widget> buttons = []; // temp. store the widgets need to create inside the row
    if(formOtherController[key] == null) formOtherController[key] = new TextEditingController();

    for(String choice in choices){
      // add gesture detectors with loop
      buttons.add(
        Expanded(
          // here we customize the button by gesture detector
            child: GestureDetector(

            /// 1. onTap:  define the action that user tapping the rectangular box
            onTap: () {
              // if the choice is other and other is not turned blue yet
              if (choice == Strings.choice_others && radioValue[key] != choice) {
                // show an alert window here to collect information
                showDialog(context: context, builder: (context) =>
                    AlertDialog(
                      title: Text(key + Strings.slit_AlertQuestion),
                      content: TextField(
                        controller: formOtherController[key],
                      ),
                      actions: <Widget>[
                        // confirm button
                        FlatButton(
                          child: Text(Strings.confirm),
                          onPressed: (){
                            // save the string to otherValue[]
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
                        // cancel button
                        FlatButton(
                          child: Text(Strings.cancel),
                          onPressed: () {
                            // clear the controller if the user say cancel
                            formOtherController[key].clear();
                            Navigator.of(context).pop();
                            },
                        ),
                      ],
                    )
                );
              }
              else {
                // because the choice cannot be choosing other, or just cancel the choice, so clear controller
                formOtherController[key].clear();
                // also clear the value stored
                otherValue[key] = "";

                // rebuild the whole widget by changing radio value, to make a certain cell become blur or not blue
                setState(() {
                  if (radioValue[key] != choice)
                    radioValue[key] = choice;
                  else
                    radioValue[key] = "";
                });
              }
            },

            /// 2. Container, define the color and text inside the button box
            child: Container(
              child: Text(choice,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                // defines the color of the box, by following the radio value
                color: (radioValue[key] == choice)?
                  Theme.of(context).hintColor: Theme.of(context).disabledColor,
              ),
            )
        ))
      );
    }

    // after adding all buttons within the string list, return a row
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
      // defining the box, with filled color and round edges
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
        color: Theme.of(context).disabledColor,
      ),
      child: SizedBox(
        width: double.infinity,
        child:Column(
          children: <Widget>[
            /// 1. row of right eye, having a "右" and a row of radio buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(Strings.right, textAlign: TextAlign.center,),
                ),
                // buttons of a single row is called to construct here
                Expanded(child: radioButtons(choices, test + Strings.right)),
                // padding
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
              ],
            ),
            /// 2. row of left eye, basically same with right eye
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(Strings.left, textAlign: TextAlign.center,),
                ),
                // buttons of a single row is called to construct here
                Expanded(child: radioButtons(choices, test + Strings.left)),
                // padding
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

    // dividing the string list with 3 string one row, and send to radioButtons() to build buttons for it
    int counter = 0;
    for(String choice in choices){
      choiceList.add(choice);
      if(counter % 3 == 2 || counter == choices.length - 1){
        columnList.add(radioButtons(choiceList, test));
        choiceList = [];
      }
      ++ counter;
    }

    // return a container storing all rows built above
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

            /// 1. TOP TWO BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  // main page
                  child: Text(Strings.mainpageButton),
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', ModalRoute.withName('/Login'));
                  },
                ),
                RaisedButton(
                  // log out
                  child: Text(Strings.logoutButton),
                  onPressed: (){
                    while(Navigator.canPop(context)){
                      Navigator.pop(context);
                    };
                  },
                ),
              ],
            ),

            // padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 2. COLUMNS WITH PATIENT NAME AND PAPER NUMBER
            //  BOX DECORATION CONTAINER AS MAIN
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              /// COULMN OF TWO ROWS
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// ROW FRO PATIENT NAME
                  Row(
                      children: <Widget>[
                        /// USE SIZEDBOX AS CONTAINER
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * COLUMN_RATIO,

                          child: Text(Strings.patientNameTyping + widget.patientName, textAlign: TextAlign.left,), // name with parameter
                        ),
                      ]
                  ),
                  /// ROW FOR PAPER NUMBER
                  Row(
                      children: <Widget>[
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

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 3. TITLE OF SLITLAMP
            Center(child: Text( Strings.slitLamp, style: TextStyle(fontSize: HEADING_FONTSIZE),),),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 4. BUTTON ROWS, TEST ITEMS WITH LEFT EYE AND RIGHT EYE
            Center(child: Text( Strings.slit_eyelid, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_eyelid, [Strings.choice_normal, Strings.choice_upperLidDrooping, Strings.choice_others]),

            Center(child: Text( Strings.slit_conjunctiva, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_conjunctiva, [Strings.choice_normal, Strings.choice_bloodFilled, Strings.choice_others]),

            Center(child: Text( Strings.slit_cornea, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_cornea, [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_others]),

            Center(child: Text( Strings.slit_lens, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_lens, [Strings.choice_normal, Strings.choice_cloudy, Strings.choice_absent, Strings.choice_others]),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 5. TITLE OF HIRSCHBERG
            Center(child: Text( Strings.hirschberg, style: TextStyle(fontSize: HEADING_FONTSIZE),),),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 6. LIST OF TEST ITEMS IN HIRSCHBERG
            Center(child: Text( Strings.slit_Hirschbergtest, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            leftRightChoiceButtonList(Strings.slit_Hirschbergtest, [Strings.choice_normal, Strings.choice_lookoutward, Strings.choice_lookinward, Strings.choice_lookupward, Strings.choice_notabletostare]),

            Center(child: Text( Strings.slit_exchange, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            threeChoiceRowList(Strings.slit_exchange, [Strings.choice_notmoving, Strings.choice_outsidetomiddle, Strings.choice_insidetomiddle, Strings.choice_uppertomiddle, Strings.choice_inneruppertomiddle, Strings.choice_outeruppertomiddle]),

            Center(child: Text( Strings.slit_eyeballshivering, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),), threeChoiceRowList(Strings.slit_eyeballshivering, [Strings.choice_nothing, Strings.choice_shown, Strings.choice_notshown, Strings.choice_both]),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 7. CONFIRM BUTTON
            Center(
              child: RaisedButton(
                  onPressed: (){
                    /// TODO: change the _szveData to connect API
                    _saveData();

                    /// TODO: add finish alert here

                    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientData(patientName: widget.patientName, fileNumber: widget.fileNumber,)));
                  },
                child: Text(Strings.confirm),
              ),
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