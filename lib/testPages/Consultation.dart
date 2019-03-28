import 'package:flutter/material.dart';
import 'package:myapp/string.dart';

class Consultation extends StatefulWidget{
  final String patientName;
  final String fileNumber;

  Consultation({Key key, @required this.patientName, @required this.fileNumber})
      : super(key: key);

  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  static const double HEADING_FONTSIZE = 40;
  static const double SUBTITLE_FONTSIZE = 25;
  static const double PADDING_RATIO = 0.02;
  Map<String, String> radioValue;
  Map<String, TextEditingController> formOtherController;
  Map<String, String> otherValue;
  TextEditingController handleController;

  @override
  void initState(){
    super.initState();
    radioValue = Map();
    formOtherController = Map();
    otherValue = Map();
    handleController = new TextEditingController();
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

  /// Return a column with rows of radio buttons
  /// each row contains 2 radio buttons
  /// @param:
  /// - test (String): the name of the testing things
  /// - choice (List of String): the text showing on the buttons
  Container twoChoiceRowList(String test, List<String> choices){
    List<Widget> columnList = [];
    List<String> choiceList = [];

    int counter = 0;
    for(String choice in choices){
      choiceList.add(choice);
      if(counter % 2 == 1 || counter == choices.length - 1){
        columnList.add(radioButtons(choiceList, test));
        choiceList = [];
      }
      ++ counter;
    }

    return Container(
      padding: EdgeInsets.all(5.0),
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor,

        body: ListView(
          padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0),

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
                  Row(
                      children: <Widget>[
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                          child: Text(Strings.patientNameTyping + widget.patientName, textAlign: TextAlign.left,), // name with parameter
                        ),
                      ]
                  ),
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
            Center(child: Text( Strings.consultation, style: TextStyle(fontSize: HEADING_FONTSIZE),
            ),),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// the first container with radio buttons
            twoChoiceRowList(Strings.consultation,
                [Strings.con_normaleyesight, Strings.con_abonormaldiopter, Strings.con_strabismus,
                Strings.con_trichiasis, Strings.con_conjunctivitis, Strings.choice_others]),
            Center(child: Text( Strings.con_handle, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),

            /// the textfield for user typing the treatments
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              padding: EdgeInsets.all(5.0),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * COLUMN_RATIO * 5,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: new TextField(
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                    ),
                  ),
                ),
              ),
            ),

            /// checking condition part
            Center(child: Text( Strings.con_furthercheckingup, style: TextStyle(fontSize: SUBTITLE_FONTSIZE),),),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                children: <Widget>[
                  radioButtons([Strings.con_furtherreview], Strings.con_furtherreview),
                  radioButtons([Strings.con_furtheroptomery], Strings.con_furtheroptomery),
                ]
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            
            /// confirm button
            Center(
              child: RaisedButton(
                onPressed: (){
                  // TODO: pop out from the page with save, please search popUntil to pop to the usersearch part
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
    // TODO: by developers, use http to link the API and send the datas
  }

}