import 'package:flutter/material.dart';
import 'package:myapp/string.dart';
import 'package:myapp/model/DataSummary.dart';
import 'package:myapp/testPages/Consultation.dart';


class PatientData extends StatefulWidget{
  final String patientID;
  final String fileNumber; 

  /*
    # Constructor for patientData
    @parameter
    patientID: the patient ID passed from UserSearch
    fileNumber: the file number passed from UserSearch
  */
  PatientData({Key key, @required this.patientID, @required this.fileNumber}) : super(key:key);

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
    checkInfoList = [Strings.vision_bareEyeSight, Strings.vision_bestEyeSight, Strings.vision_eyeGlasses, Strings.vision_livingEyeSight, Strings.opto_diopter, Strings.opto_astigmatism, Strings.opto_astigmatismaxis]; //Strings.slit_conjunctiva, Strings.slit_cornea,Strings.slit_eyelid, Strings.slit_Hirschbergtest, Strings.slit_lens];

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
            future: getCheckInfo(false, widget.patientID),
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
                else if (checkInfo == Strings.slit_conjunctiva) {
                  return SizedBox(
                    child: Text(rep.data.slit_conjunctiva, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_cornea) {
                  return SizedBox(
                    child: Text(rep.data.slit_cornea, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_eyelid) {
                  return SizedBox(
                    child: Text(rep.data.slit_eyelid, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_lens) {
                  return SizedBox(
                    child: Text(rep.data.slit_lens, textAlign: TextAlign.center,)
                  );
                }
                else if (checkInfo == Strings.slit_Hirschbergtest) {
                  return SizedBox(
                    child: Text(rep.data.slit_Hirschbergtest, textAlign: TextAlign.center,),
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
            future: getCheckInfo(true, widget.patientID),
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
                else if (checkInfo == Strings.slit_conjunctiva) {
                  return SizedBox(
                    child: Text(rep.data.slit_conjunctiva, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_cornea) {
                  return SizedBox(
                    child: Text(rep.data.slit_cornea, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_eyelid) {
                  return SizedBox(
                    child: Text(rep.data.slit_eyelid, textAlign: TextAlign.center,),
                  );
                }
                else if (checkInfo == Strings.slit_lens) {
                  return SizedBox(
                    child: Text(rep.data.slit_lens, textAlign: TextAlign.center,)
                  );
                }
                else if (checkInfo == Strings.slit_Hirschbergtest) {
                  return SizedBox(
                    child: Text(rep.data.slit_Hirschbergtest, textAlign: TextAlign.center,),
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
            future: getBasicInfo(widget.patientID),
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
            Center(child: Text(Strings.reviewingProfile,
            style: TextStyle(fontSize: HEADING_FONTSIZE),
            ),),  

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

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
            ),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            Center(
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Consultation(fileNumber: widget.fileNumber, patientID: widget.patientID, )));
                },
                child: Text(Strings.consultation),
              ),
            )
            
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
}

  
  void _saveData(){
    // TODO
  }

// Updated