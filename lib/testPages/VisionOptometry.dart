import 'package:flutter/material.dart';
import 'package:myapp/string.dart';

class VisionOptometry extends StatefulWidget{
  final String patientName;
  final String fileNumber;
  final bool isVision;

  VisionOptometry({Key key, @required this.patientName, @required this.fileNumber, @required this.isVision})
      : super(key: key);

  @override
  _VisionOptometryState createState() => _VisionOptometryState();
}

class _VisionOptometryState extends State<VisionOptometry>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double COLUMN_RATIO = 0.04;
  static const double PADDING_RATIO = 0.02;
  static const double HEADING_FONTSIZE = 40.0;
  List<String> textData;
  Map<String, TextEditingController> formFieldControllers;

  @override
  void initState(){
    super.initState();

    textData = widget.isVision?
        [Strings.vision_livingEyeSight, Strings.vision_bareEyeSight, Strings.vision_eyeGlasses, Strings.vision_bestEyeSight]
        :[Strings.opto_diopter, Strings.opto_astigmatism, Strings.opto_astigmatismaxis];

    formFieldControllers = Map();
  }

  Row textFieldRow(String testItem){
    String leftKey = testItem + Strings.left;
    String rightKey = testItem + Strings.right;

    if(formFieldControllers[leftKey] == null) formFieldControllers[leftKey] = new TextEditingController();
    if(formFieldControllers[rightKey] == null) formFieldControllers[rightKey] = new TextEditingController();

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          child: Text( testItem, textAlign: TextAlign.center,),
        ),
        Expanded(
          child: TextField(
            controller: formFieldControllers[rightKey],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        Expanded(
          child: TextField(
            controller: formFieldControllers[leftKey],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
  
  List<Widget> _bodyWidgetList(){
    List<Widget> _bodyList = [];
    
    // the title row
    _bodyList.add(
      Row(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * COLUMN_RATIO,
          ),
          Expanded(child: Text(Strings.right, textAlign: TextAlign.center,),),
          Expanded(child: Text(Strings.left, textAlign: TextAlign.center,),),
        ],
      )
    );
    
    for(String testItem in textData){
      _bodyList.add(textFieldRow(testItem));
    }
    return _bodyList;
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
            Center(child: Text(
              widget.isVision ? Strings.visionTest : Strings.optometry,
              style: TextStyle(fontSize: HEADING_FONTSIZE),
            ),),
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// page body here
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                color: Theme.of(context).disabledColor,
              ),
              child: Column(
                children: _bodyWidgetList(),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),
            /// confirm button
            Center(
              child: RaisedButton(
                onPressed: (){
                  // TODO: reuse as  profile checking, edit case to load saveData()
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