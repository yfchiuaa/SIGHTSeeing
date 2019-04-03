import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

/*
  # Function that will take the body as a map and POST it to the server as json format
  @parameter
  body: the body of the content that is needed to be posted  as the format of map
  @return
  http.post
*/
Future<VisionTest> createVisionTest({Map body}) async {
  String url = 'http://localhost:3030/check-record';

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return VisionTest.fromJson(json.decode(response.body));
  });
}

class VisionTest{
  final String patient_id;
  final String left_vision_livingEyeSight;
  final String right_vision_livingEyeSight;
  final String left_vision_bareEyeSight;
  final String right_vision_bareEyeSight;
  final String left_vision_eyeGlasses;
  final String right_vision_eyeGlasses;
  final String left_vision_bestEyeSight;
  final String right_vision_bestEyeSight;

  VisionTest({this.left_vision_livingEyeSight, this.right_vision_livingEyeSight, this.left_vision_bareEyeSight, this.right_vision_bareEyeSight, this.left_vision_eyeGlasses, this.right_vision_eyeGlasses, this.left_vision_bestEyeSight, this.right_vision_bestEyeSight, this.patient_id});

  factory VisionTest.fromJson(Map<String, dynamic> json){
    return VisionTest(
      patient_id: json['patient_id'],

      left_vision_livingEyeSight: json['left_vision_livingEyeSight'],
      left_vision_bareEyeSight: json['left_vision_bareEyeSight'],
      left_vision_eyeGlasses: json['left_vision_eyeGlasses'],
      left_vision_bestEyeSight: json['left_vision_bestEyeSight'],

      right_vision_livingEyeSight: json['right_vision_livingEyeSight'],
      right_vision_bareEyeSight: json['right_vision_bareEyeSight'],
      right_vision_eyeGlasses: json['right_vision_eyeGlasses'],
      right_vision_bestEyeSight: json['right_vision_bestEyeSight']
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['patient_id'] = patient_id;

    map['left_vision_livingEyeSight'] = left_vision_livingEyeSight;
    map['left_vision_bareEyeSight'] = left_vision_bareEyeSight;
    map['left_vision_eyeGlasses'] = left_vision_eyeGlasses;
    map['left_vision_bestEyeSight'] = left_vision_bestEyeSight;

    map['right_vision_livingEyeSight'] = right_vision_livingEyeSight;
    map['right_vision_bareEyeSight'] = right_vision_bareEyeSight;
    map['right_vision_eyeGlasses'] = right_vision_eyeGlasses;
    map['right_vision_bestEyeSight'] = right_vision_bestEyeSight;

    return map;
  }
}

Future<OptTest> createOptTest({Map body}) async {
  String url = 'http://localhost:3030/check-record';

  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
 
    if (statusCode < 200 || statusCode > 400 || json == null){
      throw new Exception("Error while fetching data");
    }
    return OptTest.fromJson(json.decode(response.body));
  });
}

class OptTest{
  final String patient_id;
  final String opto_diopter; 
  final String opto_astigmatism;
  final String opto_astigmatismaxis;

  OptTest({this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis, this.patient_id});

  factory OptTest.fromJson(Map<String, dynamic> json){
    return OptTest(
      patient_id: json['patient_id'],
      opto_diopter: json['opto_diopter'],
      opto_astigmatism: json['opto_astigmatism'],
      opto_astigmatismaxis: json['opto_astigmatismaxis'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['patient_id'] = patient_id;
    map['opto_diopter'] = opto_diopter;
    map['opto_astigmatism'] = opto_astigmatism;
    map['opto_astigmatismaxis'] = opto_astigmatismaxis;

    return map;
  }
  

}

class VisionOptometry extends StatefulWidget{
  final String patientName;
  final String fileNumber;
  final bool isVision;

  /*
    # Constructor for vision/optometry
    @parameter
    patientName: the patient name passed from UserSearch
    fileNumber: the file number passed from UserSearch
  */
  VisionOptometry({Key key, @required this.patientName, @required this.fileNumber, @required this.isVision})
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
    /*
    // Set the format of the keys
    // For example, 生活远视力左
    String leftKey = testItem + Strings.left;
    String rightKey = testItem + Strings.right;
    

    // Initiate the TextEditingController for values of the map
    if(formFieldControllers[leftKey] == null) formFieldControllers[leftKey] = new TextEditingController();
    if(formFieldControllers[rightKey] == null) formFieldControllers[rightKey] = new TextEditingController();
    */
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
                      patient_id: widget.patientName,
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
                    VisionTest newData = await createVisionTest(body: newVisionTest.toMap());
                    Navigator.pop(context);
                  }
                  else{
                    OptTest newOptTest = new OptTest
                    (
                      patient_id: widget.patientName,
                      opto_diopter: leftFieldControllers[Strings.opto_diopter].text,
                      opto_astigmatism: leftFieldControllers[Strings.opto_astigmatism].text,
                      opto_astigmatismaxis: leftFieldControllers[Strings.opto_astigmatismaxis].text,
                    );
                    OptTest newData = await createOptTest(body: newOptTest.toMap());
                    Navigator.pop(context);
                  }
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