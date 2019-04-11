import 'package:flutter/material.dart';
import 'string.dart';
import 'PatientData.dart';
import 'testPages/SlitLamp.dart';
import 'testPages/VisionOptometry.dart';

class UserSearch extends StatefulWidget{
  final String test;

  /*
  @parameter
  test: the test type passed from HomePage
  */
  UserSearch({Key key, @required this.test}) : super(key:key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double PADDING_RATIO = 0.02;
  // Size for the '用户搜寻‘
  static const double HEADING_FONTSIZE = 40.0;
  static const double COLUMN_RATIO = 0.08;
  static const double WORDSIZE = 20.0;

  /// INITIATE patient name and filenumber TextEditingController 
  TextEditingController patientNameController;
  TextEditingController fileNumberController;

  // Construct
  @override
  void initState(){
    super.initState();
    patientNameController = new TextEditingController();
    fileNumberController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).backgroundColor,

        /// THE MAIN STRUCTURE 
        body: ListView(
          /// set the margin of the area
          padding: const EdgeInsets.only(left: 20.0, right:20.0, top:40.0, bottom:40.0),

          children: <Widget>[
            /// 1. TOP TWO BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  child: RaisedButton(
                    // main page
                    child: Text(Strings.mainpageButton,
                      style: TextStyle(fontSize: WORDSIZE),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamedAndRemoveUntil('/HomePage', ModalRoute.withName('/Login'));
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                  child: RaisedButton(
                    // log out
                    child: Text(Strings.logoutButton,
                      style: TextStyle(fontSize: WORDSIZE),
                    ),
                    onPressed: (){
                      while(Navigator.canPop(context)){
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),

            // Sizedbox as padding
            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 2. THE SECOND PART FOR 'USER SEARCH' ICON AND TEXT
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search,
                  size: HEADING_FONTSIZE,
                ),
                Text(Strings.searchUsers, style: TextStyle(fontSize: HEADING_FONTSIZE),),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// 3. THE THIRD PART WITH TWO TEXTFIELD
            Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              color: Theme.of(context).canvasColor,

              /// MAIN STRUCTURE
              child: Column(

                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  /// THE PATIENT NAME INPUT FIELD
                  Container(

                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
                    width: MediaQuery.of(context).size.width *2 / 3,
                    /// Set the text area to white 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                      color: Theme.of(context).disabledColor,
                    ),

                    child: TextField(
                      // State the text data controller
                      controller: patientNameController,
                      /// decorate text field, cancel the bottom border
                      decoration: InputDecoration(
                        // hint text
                        hintText: Strings.patientName,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                        ),
                        // Cancel the border line under the textfield 
                        border: InputBorder.none
                      ),
                    ),
                  ),

                  /// THE PROFILE ID TEXT FIELD
                  Container(

                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
                    width: MediaQuery.of(context).size.width *2 / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                      color: Theme.of(context).disabledColor,
                    ),

                    child: TextField(
                      controller: fileNumberController,
                      decoration: InputDecoration(
                          hintText: Strings.profileID,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),

                  /// 4.THE LAST PART FOR CONFIRM BUTTON AND NAVIGATE TO DIFFERENT STATIONS
                  /// TODO: SHow dialog when we cannot find such patientID when we press the search button
                  Center(child: SizedBox(
                    height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                    child: RaisedButton(
                      onPressed: (){
                        // MaterialPageRoute to vision test by seting isVision to true
                        if(widget.test == Strings.visionTest)
                          Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) =>
                                VisionOptometry(patientID: patientNameController.text,
                                    fileNumber: fileNumberController.text,
                                    isVision: true))).then( (value){
                                      setState(() {
                                        fileNumberController.clear();
                                        patientNameController.clear();
                                      });
                                    });
                        // MaterialPageRoute to optometry by seting isVision to false
                        if(widget.test == Strings.optometry)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  /// CONSTRUCT by passing patient name and filenumber as parameter
                                  VisionOptometry(patientID: patientNameController.text,
                                      fileNumber: fileNumberController.text,
                                      isVision: false))).then( (value){
                                      setState(() {
                                        fileNumberController.clear();
                                        patientNameController.clear();
                                      });
                                    });
                        // M~ to slit lamp 
                        if(widget.test == Strings.slitLamp)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  SlitLamp(patientID: patientNameController.text,
                                      fileNumber: fileNumberController.text,))).then( (value){
                                      setState(() {
                                        fileNumberController.clear();
                                        patientNameController.clear();
                                      });
                                    });
                        // M~ to patientData
                        if(widget.test == Strings.reviewingProfile)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  PatientData(patientID: patientNameController.text,
                                      fileNumber: fileNumberController.text,))).then( (value){
                                      setState(() {
                                        fileNumberController.clear();
                                        patientNameController.clear();
                                      });
                                    });

                        // clear the controller after pushing the page
                        //patientNameController.clear();
                        //fileNumberController.clear();
                      },
                      child: Text(Strings.confirm,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),
                    ),
                  ),),
                ],
              ),
            ),


          ],
        ),
      );
  }


}