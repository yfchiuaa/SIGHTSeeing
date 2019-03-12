import 'package:flutter/material.dart';
import 'login.dart';

class SlitLamp extends StatefulWidget{

  @override
  _SlitLampState createState() => _SlitLampState();
}

class _SlitLampState extends State<SlitLamp>{
  final List<TextEditingController> _otherList = [];

  Widget _checkBoxLabel (bool isRow, List<String> content, int i, bool leftRight){
    final List<Widget> _checkBoxLabelList = [];
    final List<bool> _checkListState = [];
    int _lastState = 0;

    if(leftRight){
      _checkBoxLabelList
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,))
        ..add(Text((i == 0) ? "左" : "右"))
        ..add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    }

    for(int i = 0; i < content.length; ++i) {
      final List<Widget> _innerCheckBox = [];
      _checkListState.add(false);
      _innerCheckBox
          ..add( Checkbox(
            activeColor: Colors.red,
            value: _checkListState[i],
            onChanged: (newValue){
              setState(() {
                // _checkListState[_lastState] = false;
                // _lastState = i;
                _checkListState[i] = newValue;
              });
            },
          ))
          ..add(
            Text(content[i])
          );
      if(content[i] == "其他"){
        _innerCheckBox.add(Text(": "));
        _otherList.add(new TextEditingController());
        _innerCheckBox.add(Expanded(
            child: TextField(
              controller: _otherList[_otherList.length - 1],
            )
        ));
      }
      _checkBoxLabelList.add(Row(children: _innerCheckBox,));
    }


    if(isRow) return Expanded(child: Row(children: _checkBoxLabelList,));
    else return Expanded(child: Column(children: _checkBoxLabelList,));
  }


  /// To construct the whole bunch of Checkbox and Text together with padding in this function
  /// @param: isRow: the checkBox is row listed or column listed
  /// @param: content: list of text showing in this testing form area
  /// @param: leftRight: control of 左/右 showing or not
  Widget _testOneRowChoice( bool isRow, List<String> content , bool leftRight) {
    final List<Widget> _oneTestWidgetList = [];

    if (isRow)
      _oneTestWidgetList.add(
          SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    else _oneTestWidgetList.add(
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,));

    _oneTestWidgetList.add(
        SizedBox(
        width: (isRow) ? MediaQuery.of(context).size.width * 0.2 : MediaQuery.of(context).size.width * 0.9,
        child: Text(content[0], textAlign: TextAlign.left,),
    ));
    content.removeAt(0);

    if (leftRight){
      for (int i = 0; i < 2; ++i) {
        _oneTestWidgetList.add(_checkBoxLabel(!isRow, content, i, true));
      }
    } else{
      List<String> temp = [];
      for( int i = 0; i < content.length; ++i){
        temp.add(content[i]);
        if( i % 3 == 2) {
          _oneTestWidgetList.add(_checkBoxLabel(!isRow, temp, i, false));
          temp.clear();
        }
      }
    }


    if(isRow) _oneTestWidgetList.add(SizedBox(width: MediaQuery.of(context).size.width * 0.05,));
    else _oneTestWidgetList.add(SizedBox(height: MediaQuery.of(context).size.height * 0.05,));

    if(isRow)
      return Column(
          children: <Widget>[
            Row(children: _oneTestWidgetList,),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,)
          ]);
    else return SizedBox( child: Column(children: _oneTestWidgetList, ), height: MediaQuery.of(context).size.height * 0.4,);
  }

  List<Widget> _bodyWidgetList(){
    final List<Widget> _list = [];

    _list
      ..add(Row(
        children: <Widget>[

        ],
      ))
      ..add(_testOneRowChoice(true, ["眼臉", "正常", "上臉下垂", "其他"], true))
      ..add(_testOneRowChoice(true, ["結膜", "正常", "充血", "其他"], true))
      ..add(_testOneRowChoice(true, ["角膜", "正常", "混濁", "其他"], true))
      ..add(_testOneRowChoice(true, ["晶狀體", "正常", "混濁", "缺如", "其他"],true))
      ..add(_testOneRowChoice(false, ["角膜映光檢查", "正常", "偏斜", "不能因視"], true))
      ..add(_testOneRowChoice(false, ["交替遮蓋檢查", "不動", "外->中", "內->中", "上->中", "內上->中", "外上->中"], false))
      ..add(_testOneRowChoice(false, ["眼球震顫", "無", "隱性", "顯性", "顯性+隱性"], false));

    return _list;
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