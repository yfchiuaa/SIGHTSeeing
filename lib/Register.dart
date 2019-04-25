import 'package:flutter/material.dart';
import 'string.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Register extends StatefulWidget{
  Register({Key key}) : super(key:key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>{
  static const double BOX_BORDER_RADIUS = 15.0;
  static const double PADDING_RATIO = 0.02;
  static const double HEADING_FONTSIZE = 40.0;
  static const double COLUMN_RATIO = 0.08;
  static const double WORDSIZE = 20.0;

  // textfield controllers
  TextEditingController studentNameController;
  TextEditingController studentIDController;

  String studentSex;
  DateTime studentDateOfBirth;

  // Construct
  @override
  void initState(){
    super.initState();
    studentNameController = new TextEditingController();
    studentIDController = new TextEditingController();
    studentSex = "";
    studentDateOfBirth = new DateTime.now();
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
                    Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),

          // Sizedbox as padding
          SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

          /// 2. THE SECOND PART FOR 'REGISTER' ICON AND TEXT
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.account_circle,
                size: HEADING_FONTSIZE,
              ),
              Text(Strings.register, style: TextStyle(fontSize: HEADING_FONTSIZE),),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

          /// 3. TEXTFIELDS FOR USER TYPE IN DATA
          Container(
            height: MediaQuery.of(context).size.height * COLUMN_RATIO * 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(BOX_BORDER_RADIUS)),
              color: Theme.of(context).disabledColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Name of the info
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                      child: Center(child: Text( Strings.studentName,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),),
                    ),
                    /// Textfield for that info
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: studentNameController,
                        // Set the keyboard
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),
                    ),
                  ],
                ),

                // for grid line
                Container(height: MediaQuery.of(context).size.height * 0.005,
                  decoration: BoxDecoration(color: Colors.black12,),
                ),

                Row(
                  children: <Widget>[
                    // Name of the info
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                      child: Center(child: Text( Strings.studentNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),),
                    ),
                    /// Textfield for that info
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                        controller: studentIDController,
                        // Set the keyboard
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),
                    ),
                  ],
                ),

                // for grid line
                Container(height: MediaQuery.of(context).size.height * 0.005,
                  decoration: BoxDecoration(color: Colors.black12,),
                ),

                Row(
                  children: <Widget>[
                    // Name of the info
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                      child: Center(child: Text( Strings.studentSex,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),),
                    ),
                    Expanded(
                      child: Text(studentSex,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),
                    ),
                    /// choose list for that info
                    PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          new PopupMenuItem(value: Strings.male, child: new Text(Strings.male, textAlign: TextAlign.center,)),
                          new PopupMenuDivider(height: 1.0,),
                          new PopupMenuItem(value: Strings.female, child: new Text(Strings.female, textAlign: TextAlign.center,))
                        ],
                        onSelected: (String value) {
                          setState(() {
                            studentSex = value;
                          });
                        },
                    ),
                  ],
                ),

                // for grid line
                Container(height: MediaQuery.of(context).size.height * 0.005,
                  decoration: BoxDecoration(color: Colors.black12,),
                ),

                Row(
                  children: <Widget>[
                    // birth of the info
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * COLUMN_RATIO,
                      child: Center(child: Text( Strings.studentBirth,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: WORDSIZE),
                      ),),
                    ),
                    /// Textfield for that info
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(studentDateOfBirth),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: WORDSIZE),
                        ),
                        onTap: () => _selectDate(context),
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * PADDING_RATIO,),

          /// 4.THE LAST PART FOR CONFIRM BUTTON AND NAVIGATE TO DIFFERENT STATIONS
          Center(child: SizedBox(
            height: MediaQuery.of(context).size.height * COLUMN_RATIO,
            child: RaisedButton(
              onPressed: (){

              },
              child: Text(Strings.confirm,
                style: TextStyle(fontSize: WORDSIZE),
              ),
            ),
          ),),
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async{
    final DateTime _picked = await showDatePicker(
        context: context,
        initialDate: studentDateOfBirth,
        firstDate: new DateTime(1900),
        lastDate: DateTime.now()
    );

    if(_picked != null) {
      setState(() {
        studentDateOfBirth = _picked;
      });
    }
  }
}