import 'package:flutter/material.dart';
import 'login.dart';

class Consultation extends StatefulWidget{
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation>{
  final List<List<String>> _stringList =[
    ["診斷", "正視眼", "屈光不正", "共同性斜視", "倒睫", "結膜炎", "其他"],
    ["檢查情況", "疑有異常需覆診", "需進一步驗光"],
  ];

  final List<String> _choiceCheckList = [];
  final List<TextEditingController> _controllerList = [];
  int _checkListCreated;

  /// _checkingChoice
  ///  to return a row consists of 3 things: a checkbox, a text, and a text field if other information need to be input
  ///  and the returned widget don't need to assign size value to it ( i.e. use another SizedBox to wrap this expanded will be error)
  ///
  /// @param:
  /// - testCorner (String) : the name of the test station of this checkbox of this checkbox belongs to
  /// - content (String) : the text label of the checkbox
  /// - isLeft (bool) : to identify the checkbox is belongs to left eye or right eye
  ///
  /// Inner parameter:
  /// - onChanged inside checkbox: to denote the string checked by using global string array
  ///     e.g. when 眼臉/左眼/正常 is clicked, string array will have a new member with value "眼臉左正常"
  Expanded _checkingChoice( String testCorner, String content , bool isLeft){
    final List<Widget> _components = [];
    _controllerList.add(new TextEditingController());
    String a = testCorner + (isLeft ? "左" : "右") + content;

    _components
      ..add(Checkbox(
        activeColor: Colors.blue,
        value: _choiceCheckList.contains(a),
        onChanged: (newValue) {
          setState(() {
            (newValue) ? _choiceCheckList.add(a) : _choiceCheckList.remove(a);
          });
        },
      ))
      ..add(Text(content));
    if( content == "其他"){
      _components
        ..add(Text(" : "))
        ..add(Expanded( child: TextField(
          controller: _controllerList[_checkListCreated*2 + (isLeft? 0 : 1)],
        )
        ));
    }
    return Expanded(child: Row(children: _components,) );
  }

  /// _verticalCheckList
  /// to return a column of rows of _checkingChoice
  /// this function is responsible for making the entire checklist (horizontal)
  ///
  /// @param:
  /// - content (List<String>) : a list consist of the strings to build the checklist
  ///               content [0] is the station name, and the other is the checking choice
  /// - leftRight (bool) : to determine whether the station need to separate the result between both eyes
  /// - isLeft (bool) : to determine whether the list belongs to left eye or right eye
  Column _verticalCheckList( List<String> content, bool leftRight, bool isLeft){
    final List<Widget> _verticalCheckList = [];
    if(leftRight) {
      _verticalCheckList.add(Text((isLeft ? "左" : "右")));
    }
    for(int i = 1; i < content.length; ++i){
      _verticalCheckList.add(_checkingChoice(content[0], content[i], isLeft));
    }
    return Column( children: _verticalCheckList,);
  }

  /// _packageOneTestForm
  /// to package the components that a test form should have together
  /// return : a widget (column or row) contains all contents (title of the test, checking lists)
  ///
  /// @param : null
  Widget _packageOneTestForm(){
    return Column(
    children: <Widget>[
        SizedBox( height: MediaQuery.of(context).size.height * 0.05,),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1,
            child: Text(_stringList[_checkListCreated][0], style: TextStyle(fontSize: 20),)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1 * (_stringList[_checkListCreated].length - 1),
          child: _verticalCheckList(_stringList[_checkListCreated], false, false),
        )
      ]
    );
  }

  // return a list of children of the scaffold body
  List<Widget> _bodyWidgetList(){
    List<Widget> _testChildren = [];
    _checkListCreated = 0;
    for(; _checkListCreated < _stringList.length; ++_checkListCreated){
      _testChildren.add(_packageOneTestForm());
    }
    _testChildren.add( Column(
     children: <Widget>[
       SizedBox( height: MediaQuery.of(context).size.height * 0.05,),
       SizedBox(height: MediaQuery.of(context).size.height * 0.1,
           child: Text("處理", style: TextStyle(fontSize: 20),)),
       TextField(decoration: InputDecoration(
         labelText: '下方輸入文字',
         filled: true,
       )),
       SizedBox( height: MediaQuery.of(context).size.height * 0.05,),
     ],
    ));
    return _testChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Consultation"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                tooltip: 'Air it',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                }
            ),
          ],
          backgroundColor: Colors.purple
        // TODO: the button text
      ),
      body: ListView(
        children: _bodyWidgetList(),
      ),
    );
  }
}