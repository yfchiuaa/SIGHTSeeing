import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'package:myapp/model/VisionTest.dart';
import 'package:myapp/model/OptTest.dart';

class VisionOptometry extends StatefulWidget{
  final String patientID;
  final String fileNumber;
  final bool isVision;

  /*
    # Constructor for vision/optometry
    @parameter
    patientID: the patient name passed from UserSearch
    fileNumber: the file number passed from UserSearch
  */
  VisionOptometry({Key key, @required this.patientID, @required this.fileNumber, @required this.isVision})
      : super(key: key);

  @override
  _VisionOptometryState createState() => _VisionOptometryState();
}

class _VisionOptometryState extends State<VisionOptometry>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  static const double PADDING_RATIO = 0.02;
  // Size for '视力检查'
  static const double HEADING_FONTSIZE = 40.0;

  // testList: all checking items in this test
  List<String> testList;
  // Map of formField: Left/Right as Key, TextField as values
  Map<String, TextEditingController> rightFieldControllers;
  Map<String, TextEditingController> leftFieldControllers;
  // Map<String, TextEditingController> formFieldControllers;

  // Construct
  @override
  void initState(){
    super.initState();

    /// Construct the data types
    // State the corresponding checkings of each values represent inside the text Data list
    testList = widget.isVision?
        [Strings.vision_livingEyeSight, Strings.vision_bareEyeSight, Strings.vision_eyeGlasses, Strings.vision_bestEyeSight]
        :[Strings.opto_diopter, Strings.opto_astigmatism, Strings.opto_astigmatismaxis];

    rightFieldControllers = Map();
    leftFieldControllers = Map();
    // formFieldControllers = Map();
  }

  /*
    # Widget for create a row of the textfield used for recording input testItem
    # It will take a test items then put them into a form
    @ parameter
    testItem: take the test item from testList
  */
  Row textFieldRow(String testItem){
    if (leftFieldControllers[testItem] == null){
      leftFieldControllers[testItem] = new TextEditingController();
    }
    if (rightFieldControllers[testItem] == null){
      rightFieldControllers[testItem] = new TextEditingController();
    }

    // Main structure of the FormField
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // Name of the check info
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          child: Text( testItem, textAlign: TextAlign.center,),
        ),

        /// Textfield for right eye 
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            //controller: formFieldControllers[rightKey],
            controller: rightFieldControllers[testItem],
            // Set the keyboard
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        /// Textfield for left eye
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none
            ),
            //controller: formFieldControllers[leftKey],
            controller: leftFieldControllers[testItem],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  /*
    # Function for takeing all test item from itemlist and create the corresponding textFieldRow
    @return
    _bodyList: a list of all rows (include the title row and all textFieldRow) needed in textField of checking
  */
  List<Widget> _bodyWidgetList(){
    // list of all rows
    List<Widget> _bodyList = [];
    
    /// THE FIRST TITLE ROW which contains 左 and 右
    _bodyList.add(
      Row(
        children: <Widget>[
          // * Sizedbox as padding to fill the left empty spcae of the title row
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          ),
          // Right eye
          Expanded(child: Text(Strings.right, textAlign: TextAlign.center,),),
          // Left eye
          Expanded(child: Text(Strings.left, textAlign: TextAlign.center,),),
        ],
      )
    );

    /// ALL THE TEXTFIELDROW of test items
    for(String testItem in testList){
      _bodyList.add(textFieldRow(testItem));
    }
    return _bodyList;
  }

  /// MAIN STRUCTURE 
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

            // Sizedbox as padding
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

                          child: Text(Strings.patientIDTyping + widget.patientID, textAlign: TextAlign.left,), // name with parameter
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

            /// 3. PRINT THE TITLE OF THE TEST
            Center(child: Text(
              // Print vision test if it is vision test, optometry otherwise
              widget.isVision ? Strings.visionTest : Strings.optometry,
              style: TextStyle(fontSize: HEADING_FONTSIZE),
            ),),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 4. THE FORMFIELD BODY
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                children: _bodyWidgetList(),
              ),
            ),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 5. CONFIRM BUTTON
            Center(
              child: RaisedButton(
                onPressed: () async {
                  if (widget.isVision){
                    // Construct the visionTest object
                    VisionTest newVisionTest = new VisionTest(
                      //patient_id: widget.patientID,
                      left_vision_livingEyeSight: leftFieldControllers[Strings.vision_livingEyeSight].text,
                      left_vision_bareEyeSight: leftFieldControllers[Strings.vision_bareEyeSight].text,
                      left_vision_eyeGlasses: leftFieldControllers[Strings.vision_eyeGlasses].text,
                      left_vision_bestEyeSight: leftFieldControllers[Strings.vision_bestEyeSight].text,
                      right_vision_livingEyeSight: rightFieldControllers[Strings.vision_livingEyeSight].text,
                      right_vision_bareEyeSight: leftFieldControllers[Strings.vision_bareEyeSight].text,
                      right_vision_eyeGlasses: rightFieldControllers[Strings.vision_eyeGlasses].text,
                      right_vision_bestEyeSight: rightFieldControllers[Strings.vision_bestEyeSight].text
                    );
                    // Call the API
                    VisionTest newData = await createVisionTest(widget.patientID, newVisionTest.toMap());
                  }
                  else{
                    OptTest newOptTest = new OptTest
                    (
                      //patient_id: widget.patientID,
                      left_opto_diopter: leftFieldControllers[Strings.opto_diopter].text,
                      left_opto_astigmatism: leftFieldControllers[Strings.opto_astigmatism].text,
                      left_opto_astigmatismaxis: leftFieldControllers[Strings.opto_astigmatismaxis].text,
                      right_opto_diopter: rightFieldControllers[Strings.opto_diopter].text,
                      right_opto_astigmatism: rightFieldControllers[Strings.opto_astigmatism].text,
                      right_opto_astigmatismaxis: rightFieldControllers[Strings.opto_astigmatismaxis].text,
                    );
                    OptTest newData = await createOptTest(widget.patientID, newOptTest.toMap());
                  }

                  // TODO: add finish alert here
                  Navigator.pop(context);
                },
                child: Text(Strings.confirm),
              ),
            ),

            /// 6. PREVENT BUTTON CANNOT PRESS BY IOS DECIMAL KEYBOARD
            SizedBox(height: MediaQuery.of(context).size.height / 2,)
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

}