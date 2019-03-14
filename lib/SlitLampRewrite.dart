import 'package:flutter/material.dart';
import 'login.dart';

class SlitLamp extends StatefulWidget{
  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  final List<List<String>> _stringList = [
    ["眼臉", "正常", "上臉下垂", "其他"],
    ["結膜", "正常", "充血", "其他"],
    ["角膜", "正常", "混濁", "其他"],
    ["晶狀體", "正常", "混濁", "缺如", "其他"],
    ["角膜映光檢查", "正常", "偏斜", "不能因視"],
    ["交替遮蓋檢查", "不動", "外->中", "內->中", "上->中", "內上->中", "外上->中"],
    ["眼球震顫", "無", "隱性", "顯性", "顯性+隱性"]
  ];
  final List<bool> _isRow = [true, true, true, true, false, false, false];
  final List<bool> _isLeftRight = [true, true, true, true, true, false, false];

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
  /// this function is responsible for making the entire checklist
  ///
  /// 
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

  Widget _horizontalThreeChoiceList(List<String> content, bool leftRight, bool isLeft){
    final List<Widget> _horizontalCheckList = [];

    if(leftRight) {
      _horizontalCheckList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.025,));
      _horizontalCheckList.add(Text((isLeft ? "左" : "右")));
      _horizontalCheckList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.025,));
      for(int i = 1; i < content.length; ++i){
        _horizontalCheckList.add(_checkingChoice(content[0], content[i], isLeft));
      }
      _horizontalCheckList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.025,));
      return Row( children: _horizontalCheckList,);
    }
    else{
      List<Widget> _oneRow = [];
      for(int i = 1; i < content.length; ++i){
        if( i % 3 == 1){
          _oneRow = [];
          _oneRow.add(SizedBox(width: MediaQuery.of(context).size.width * 0.025,));
        }
        _oneRow.add(_checkingChoice(content[0], content[i], isLeft));
        if( i % 3 == 0){
          _oneRow.add(SizedBox( width: MediaQuery.of(context).size.width * 0.025,));
          _horizontalCheckList.add( Row(children: _oneRow,));
        }
        else if(i == content.length - 1) _horizontalCheckList.add( Row(children: _oneRow,));
      }
      return Column(children: _horizontalCheckList, mainAxisAlignment: MainAxisAlignment.start,);
    }
  }

  Widget _packageOneTestForm(){
    final List<Widget> _PackingList = [];
    if(_isRow[_checkListCreated]){
      _PackingList
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,))
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Text(_stringList[_checkListCreated][0], style: TextStyle(fontSize: 20),),
        ))
        ..add(Expanded(
          child: _verticalCheckList(_stringList[_checkListCreated], _isLeftRight[_checkListCreated], _isLeftRight[_checkListCreated]),
        ));
      if(_isLeftRight[_checkListCreated]){
        _PackingList.add(Expanded(child: _verticalCheckList(_stringList[_checkListCreated], _isLeftRight[_checkListCreated], false)));
      }
      _PackingList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
      return Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          SizedBox(child: Row(children: _PackingList), height: MediaQuery.of(context).size.height * 0.4,),
        ],
      );
    }
    else{
      _PackingList
        ..add(SizedBox(height: MediaQuery.of(context).size.height * 0.05,))
        ..add(Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,
              child: Text(_stringList[_checkListCreated][0], style: TextStyle(fontSize: 20),))
        ]))
        ..add(_horizontalThreeChoiceList(_stringList[_checkListCreated], _isLeftRight[_checkListCreated], _isLeftRight[_checkListCreated]),
        );
      if(_isLeftRight[_checkListCreated]){
        _PackingList.add( _horizontalThreeChoiceList(_stringList[_checkListCreated], _isLeftRight[_checkListCreated], false) );
      }
      return Column(children: _PackingList,);
    }
  }

  List<Widget> _bodyWidgetList(){
    List<Widget> _testChildren = [];
    _checkListCreated = 0;
    for(; _checkListCreated < _stringList.length; ++_checkListCreated){
      _testChildren.add(_packageOneTestForm());
    }
    return _testChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Slit Lamp"),
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