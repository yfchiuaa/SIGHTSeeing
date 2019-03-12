import 'package:flutter/material.dart';
import 'login.dart';

class SlitLamp extends StatefulWidget{

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  final List<TextEditingController> _otherList = [];
  final List<List<Checkbox>> _checkBoxList = [];
  final List<List<bool>> _checkListState = [];
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

  int _checkListCreated;

  @override
  void initState(){
    super.initState();
    _checkListCreated = 0;
    for(int j = 0; j < _stringList.length; ++j){
      _otherList.add(new TextEditingController());
      _checkBoxList.add(new List<Checkbox>());
      _checkListState.add(new List<bool>());
      for(int i = 1; i < _stringList[j].length; ++i){
        _checkListState[j].add(false);
      }
      for(int i = 1; i < _stringList[j].length; ++i){
        _checkBoxList[j].add(Checkbox(
          activeColor: Colors.blue,
          value: _checkListState[j][i - 1],
          onChanged: (newValue){
            setState(() {
              _checkListState[j][i - 1] = newValue;
            });
            print(_checkListState[j][i-1]);
          },
        ));
      }
      ++_checkListCreated;
    }
    _checkListCreated = 0;
  }

  Widget _checkBoxLabel (int leftRightI, bool cutThree, int cutThreeIndex){
    final List<Widget> _checkBoxLabelList = [];
    if( _isLeftRight[_checkListCreated]){
      _checkBoxLabelList
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,))
        ..add(Text((leftRightI == 0) ? "左" : "右"))
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    }
    for ( int i = cutThreeIndex;
    i < _stringList[_checkListCreated].length && ((cutThree) ? (i < cutThreeIndex + 3) : true);
    ++i) {
      final List<Widget> _innerCheckBox = [];
      _innerCheckBox
        ..add(_checkBoxList[_checkListCreated][i - 1])
        ..add(Text(_stringList[_checkListCreated][i]));

      if (_stringList[_checkListCreated][i] == "其他") {
        _innerCheckBox.add(Text(": "));
        _innerCheckBox.add(Expanded( child: TextField(
          controller: _otherList[_checkListCreated],
        )
        ));
      }
      _checkBoxLabelList.add(Row(children: _innerCheckBox,));
    }

    if(!_isRow[_checkListCreated]) return Expanded(child: Row(children: _checkBoxLabelList,));
    else return Expanded(child: Column(children: _checkBoxLabelList,));
  }


  /// To construct the whole bunch of Checkbox and Text together with padding in this function
  /// @param: isRow: the checkBox is row listed or column listed
  /// @param: content: list of text showing in this testing form area
  /// @param: leftRight: control of 左/右 showing or not
  Widget _testOneRowChoice() {
    final List<Widget> _oneTestWidgetList = [];

    if ( _isRow[_checkListCreated])
      _oneTestWidgetList.add( SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    else _oneTestWidgetList.add( SizedBox(height: MediaQuery.of(context).size.height * 0.05,));

    _oneTestWidgetList.add( SizedBox(
        width: (_isRow[_checkListCreated]) ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.9,
        child: Text(_stringList[_checkListCreated][0], textAlign: TextAlign.left,),
    ));

    if (_isLeftRight[_checkListCreated]){
      for (int i = 0; i < 2; ++i) {
        _oneTestWidgetList.add(_checkBoxLabel(i, false, 1));
      }
    } else{
      List<String> temp = [];
      for( int i = 1; i < _stringList[_checkListCreated].length; ++i){
        temp.add( _stringList[_checkListCreated][i] );
        if( i % 3 == 0) {
          _oneTestWidgetList.add(_checkBoxLabel(0, true, i - 2));
          temp.clear();
        }
      }
    }

    if(_isRow[_checkListCreated]) _oneTestWidgetList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    else _oneTestWidgetList.add(SizedBox(height: MediaQuery.of(context).size.height * 0.05,));

    if(_isRow[_checkListCreated])
      return Column(
          children: <Widget>[
            Row(children: _oneTestWidgetList,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,)
          ]);
    else return SizedBox( child: Column(children: _oneTestWidgetList, ), height: MediaQuery.of(context).size.height * 0.4,);
  }

  List<Widget> _bodyWidgetList(){
    final List<Widget> _list = [];
    for(int i = 0; i < _stringList.length; ++i) {
      _list.add(_testOneRowChoice());
      ++_checkListCreated;
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    _checkListCreated = 0;
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