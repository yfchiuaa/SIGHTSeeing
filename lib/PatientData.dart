import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

/*
  # The function that will make use of the http.get method to do GET operation
*/
Future<BasicInfo> getBasicInfo() async{
  String url = 'http://localhost:3030/students';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
      return BasicInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
}

/*
  The class contains all the information needed in the basic information section
*/
class BasicInfo{
  final String name;
  final String number;
  final String sex;
  final String birth;

  BasicInfo({this.name, this.number,this.sex, this.birth});

  // Method that take a 
  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
        name: json['data'][0]['studentName'],
        number: json['data'][0]['studentNumber'],
        sex: json['data'][0]['studentSex'],
        birth: json['data'][0]['studentBirth'],
    );
  }
}

Future<CheckInfo> getCheckInfo(bool isLeft) async{
  String url = 'http://localhost:3030/check-record';
  final response = await http.get(url, headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
      return CheckInfo.fromJson(json.decode(response.body), isLeft);
    } else {
      throw Exception('Failed to load post');
    }
}

class CheckInfo{
  final String vision_livingEyeSight;
  final String vision_bareEyeSight;
  final String vision_eyeGlasses;
  final String vision_bestEyeSight;
  final String opto_diopter;
  final String opto_astigmatism;
  final String opto_astigmatismaxis;

  CheckInfo({this.vision_livingEyeSight, this.vision_bareEyeSight, this.vision_eyeGlasses, this.vision_bestEyeSight, this.opto_diopter, this.opto_astigmatism, this.opto_astigmatismaxis});

  factory CheckInfo.fromJson(Map<String, dynamic> json, bool isLeft) {
    if (isLeft){
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['left_vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['left_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['left_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['left_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['left_opto_diopter'],
        opto_astigmatism: json['data'][0]['left_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['left_opto_astigmatismaxis']
      );
    }
    else{
      return CheckInfo(
        vision_livingEyeSight: json['data'][0]['right_result']['vision_livingEyeSight'],
        vision_bareEyeSight: json['data'][0]['right_vision_bareEyeSight'],
        vision_eyeGlasses: json['data'][0]['right_vision_eyeGlasses'],
        vision_bestEyeSight: json['data'][0]['right_vision_bestEyeSight'],
        opto_diopter: json['data'][0]['right_opto_diopter'],
        opto_astigmatism: json['data'][0]['right_opto_astigmatism'],
        opto_astigmatismaxis: json['data'][0]['right_opto_astigmatismaxis']
      );
    }
  }
}

class PatientData extends StatefulWidget{
  final String patientName;
  final String fileNumber; 

  /*
    # Constructor for patientData
    @parameter
    patientName: the patient name passed from UserSearch
    fileNumber: the file number passed from UserSearch
  */
  PatientData({Key key, @required this.patientName, @required this.fileNumber}) : super(key:key);

  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData>{
  // Size for '检视档案'
  static const double HEADING_FONTSIZE = 40.0;
  static const double COLUMN_RATIO = 0.04;
  static const double PADDING_RATIO = 0.02;
  static const double BOX_BORDER_RADIUS = 15.0;
  final isLeft = false;

  // InfoList: all the information section will be shown in Form Field
  // BasicInfoList: basic information about students
  List<String> basicInfoList;
  // CheckInfoList: the checking information 
  List<String> checkInfoList;
  // Map of formField: info section as Key, values as values

  @override
  void initState(){
    super.initState();

    /// Construct the data types
    basicInfoList = [Strings.studentName, Strings.studentNumber, Strings.studentSex, Strings.studentBirth];
    checkInfoList = [Strings.vision_bareEyeSight, Strings.vision_bestEyeSight, Strings.vision_eyeGlasses, Strings.vision_livingEyeSight, Strings.opto_diopter, Strings.opto_astigmatism, Strings.opto_astigmatismaxis];

  }

  /*
    # Widget for create a row of the textfield used for showing the information 
    # It will take a info section then put them into a row
    @ parameter
    infoItem: take the infoItem from infoList
  */
  Row checkFieldRow(String checkInfo){

    // Main structure of the FormField
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // Name of the info section
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          child: Text( checkInfo, textAlign: TextAlign.center,),
        ),

        /// Information sizedbox of the data of this section in right eyes
        Expanded(
          child: FutureBuilder<CheckInfo>(
            future: getCheckInfo(false),
            builder: (context, rep){
              if (rep.hasData){
                if (checkInfo == Strings.vision_livingEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_livingEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_bareEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_bareEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_eyeGlasses){
                  return SizedBox(
                  child: Text(rep.data.vision_eyeGlasses, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_bestEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_bestEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_diopter){
                  return SizedBox(
                  child: Text(rep.data.opto_diopter, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_astigmatism){
                  return SizedBox(
                  child: Text(rep.data.opto_astigmatism, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_astigmatismaxis){
                  return SizedBox(
                  child: Text(rep.data.opto_astigmatismaxis, textAlign: TextAlign.center,),
                  );
                }
              }
              else if (rep.hasError){
                return Text("${rep.error}");
              }
              return CircularProgressIndicator();
            },
          )
        ),
        /// Textfield for left eye
        Expanded(
          child: FutureBuilder<CheckInfo>(
            future: getCheckInfo(true),
            builder: (context, rep){
              if (rep.hasData){
                if (checkInfo == Strings.vision_livingEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_livingEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_bareEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_bareEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_eyeGlasses){
                  return SizedBox(
                  child: Text(rep.data.vision_eyeGlasses, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.vision_bestEyeSight){
                  return SizedBox(
                  child: Text(rep.data.vision_bestEyeSight, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_diopter){
                  return SizedBox(
                  child: Text(rep.data.opto_diopter, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_astigmatism){
                  return SizedBox(
                  child: Text(rep.data.opto_astigmatism, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.opto_astigmatismaxis){
                  return SizedBox(
                  child: Text(rep.data.opto_astigmatismaxis, textAlign: TextAlign.center,),
                  );
                }
              }
              else if (rep.hasError){
                return Text("${rep.error}");
              }
              return CircularProgressIndicator();
            },
          )
          
        )
      ],
    );
  }

  /*
    # Function for takeing all check info sections from checkInfo and create the corresponding textFieldRow
    @return
    _bodyList: a list of all rows (include the title row and all textFieldRow) needed in textField of checking
  */
  List<Widget> _checkWidgetList(){
    // list of all rows
    List<Widget> _checkList = [];
    
    /// THE FIRST TITLE ROW which contains 右 and 左
    _checkList.add(
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

    /// ALL THE TEXTFIELDROW of check infolist
    for (String checkInfo in checkInfoList){
      _checkList.add(checkFieldRow(checkInfo));
    }

    return _checkList;
  }

  Row basicFieldRow(String basicInfo){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // Name of the basic info 
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          child: Text( basicInfo, textAlign: TextAlign.center,),
        ),

        // TextField for the basic info
        Expanded(
          child: FutureBuilder<BasicInfo>(
            future: getBasicInfo(),
            builder: (context, rep){
              if (rep.hasData){
                if (basicInfo == Strings.studentName){
                  return SizedBox(
                  child: Text(rep.data.name, textAlign: TextAlign.center,),
                  );
                }
                else if (basicInfo == Strings.studentNumber){
                  return SizedBox(
                  child: Text(rep.data.number, textAlign: TextAlign.center,),
                  );
                }
                else if (basicInfo == Strings.studentSex){
                  return SizedBox(
                  child: Text(rep.data.sex, textAlign: TextAlign.center,),
                  );
                }
                else if (basicInfo == Strings.studentBirth){
                  return SizedBox(
                  child: Text(rep.data.birth, textAlign: TextAlign.center,),
                  );
                }
              }
              else if (rep.hasError){
                return Text("${rep.error}");
              }
              return CircularProgressIndicator();
            },
          )
        )
      ],
    );
  }

  /*

  */
  List<Widget> _basciWidgetList(){
    // list of all rows
    List<Widget> _basicList = [];

    for (String basicInfo in basicInfoList){
      _basicList.add(basicFieldRow(basicInfo));
    }

    return _basicList;
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
            Center(child: Text(Strings.reviewingProfile,
            style: TextStyle(fontSize: HEADING_FONTSIZE),
            ),),  

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            /// TODO: Problem is at BASICINFO
            /// 4. THE FORMFIELD FOR BASICINFO
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                children: _basciWidgetList(),
              ),
            ),
            
            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            
            /// 5. THE FORMFIELD FOR CHECKINFO
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                children: _checkWidgetList(),
              ),
            )
            
          ],
        ),
      ),
    );
  }
}


/// function defines the action after back button is pressed
  /// what is doing now: pop out a alert window with 2 buttons, save or back
  Future<bool> _onBackPressed() {
    /*
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
    */
  }
  
  void _saveData(){
    // TODO
  }