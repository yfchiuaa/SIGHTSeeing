import 'package:flutter/material.dart';
import 'string.dart';
import 'PatientData.dart';
import 'testPages/SlitLamp.dart';
import 'testPages/VisionOptometry.dart';

class UserSearch extends StatefulWidget{
  final String test;

  UserSearch({Key key, @required this.test}) : super(key:key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double PADDING_RATIO = 0.02;
  static const double HEADING_FONTSIZE = 40.0;
  TextEditingController patientNameController;
  TextEditingController fileNumberController;

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

        body: ListView(
          /// set the margin of the area
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

            /// Top row: user search text with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text(Strings.searchUsers, style: TextStyle(fontSize: HEADING_FONTSIZE),),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

            /// container with text field
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              color: Theme.of(context).canvasColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  /// top text field
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 0.0),
                    width: MediaQuery.of(context).size.width *2 / 3,
                    /// set the area of white
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
                      color: Theme.of(context).disabledColor,
                    ),
                    /// define text field
                    child: TextField(
                      controller: patientNameController,
                      /// decorate text field, cancel the bottom border
                      decoration: InputDecoration(
                        hintText: Strings.patientName,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  /// basically the same with container above
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

                  /// confirm button
                  Center(
                    child: RaisedButton(
                      onPressed: (){
                        // TODO: edit the button option, navigate different pages according to widget.test
                        if(widget.test == Strings.visionTest)
                          Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) =>
                                VisionOptometry(patientName: patientNameController.text,
                                    fileNumber: fileNumberController.text,
                                    isVision: true)));
                        if(widget.test == Strings.optometry)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  VisionOptometry(patientName: patientNameController.text,
                                      fileNumber: fileNumberController.text,
                                      isVision: false)));
                        if(widget.test == Strings.slitLamp)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  SlitLamp(patientName: patientNameController.text,
                                      fileNumber: fileNumberController.text,)));
                        if(widget.test == Strings.reviewingProfile)
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  PatientData(patientName: patientNameController.text,
                                      fileNumber: fileNumberController.text,)));
                      },
                      child: Text(Strings.confirm),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      );
  }


}