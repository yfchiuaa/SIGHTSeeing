import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login.dart';

class VisionOptometry extends StatefulWidget{
  final List<String> checkingDetails;

  VisionOptometry({Key key, @required this.checkingDetails}) : super(key : key);

  @override
  _VisionOptometryState createState() => _VisionOptometryState();
}

class _VisionOptometryState extends State<VisionOptometry> {
  final double TEXT_HEIGHT = 60; // To use this, delete the comment on height: boxHeight in _inputTextField
  final List<TextEditingController> _controller = [];
  final List<FocusNode> _FocusNode = [];

  int _nodeInstantiated = 0;

  @override
  void initState(){
    for(int i = 1; i < widget.checkingDetails.length; ++i) {
      for(int j = 0; j < 2; ++j) {
        _controller.add(new TextEditingController());
        _FocusNode.add(new FocusNode());
      }
    }
    super.initState();
  }

  /// Defines the action when back button pressed
  /// it pops out an alert window to prevent people in mis-pressing back button
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("确定要保存及退出吗?"),
        actions: <Widget>[
          FlatButton(
            child: Text('保存'),
            onPressed: (){
              _saveData();
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text('不要'),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    )??false;
  }

  /// Return a sized box contains the text showing in the scaffold
  ///
  /// @param:
  /// - text (String) : the text showing
  /// - boxHeight (double) : defines the sized box height
  /// - ratio (double) : defines the width of the sized box
  /// - alignment: defines the alignment of the text
  SizedBox _showingText( String text, double boxHeight, double ratio, TextAlign alignment){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      child: Text(text,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Return a sized box contains the text field for user to input numbers
  ///
  /// @param:
  /// - boxHeight (double) : defines the sized box height
  /// - ratio (double) : defines the width of the sized box
  /// - _controller (TextEditingController) : the controller assigned to the text field (need to instantiate before this function is called)
  /// - firstNode (FocusNode) : the focus node assigned to the text field
  /// - nextNode (FocusNode) : the next focus node of the text field that should be focused after next button of keyboard is clicked
  SizedBox _inputTextField( double boxHeight, double ratio, TextEditingController _controller,
      FocusNode firstNode, FocusNode nextNode){
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: ratio * screenWidth,
      // height: boxHeight,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: (nextNode != null ) ? TextInputAction.next : TextInputAction.done,
        focusNode: firstNode,
        onSubmitted: (term){
          firstNode.unfocus();
          if(nextNode != null) {
            FocusScope.of(context).requestFocus(nextNode);
          }
        },

      ),
    );
  }

  /// _inputRow
  /// to pack text and text field together to make a row of inputting
  ///
  /// @param
  /// - row (int) : to denote the index of the row building
  /// - lastRow (bool) : to denote whether this row is the last row
  Row _inputRow ( int row , bool lastRow ){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _showingText(widget.checkingDetails[row], TEXT_HEIGHT, 0.4, TextAlign.center),
        _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
            _FocusNode[_nodeInstantiated], _FocusNode[++_nodeInstantiated]),
        SizedBox(width: MediaQuery.of(context).size.width*0.05),
        _inputTextField(TEXT_HEIGHT, 0.2, _controller[_nodeInstantiated],
            _FocusNode[_nodeInstantiated], (lastRow) ? null : _FocusNode[++_nodeInstantiated]),
        SizedBox(width: MediaQuery.of(context).size.width * 0.1),
      ],
    );
  }

  List<Widget> _constructBodyList(){
    List<Widget> _bodyWidgetList = [];
    _bodyWidgetList
      ..add(
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      )
      ..add( Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _showingText("", TEXT_HEIGHT, 0.4, TextAlign.center),
          _showingText("左", TEXT_HEIGHT, 0.2, TextAlign.center),
          SizedBox(width: MediaQuery.of(context).size.width*0.05),
          _showingText("右", TEXT_HEIGHT, 0.2, TextAlign.center),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1),
        ],
      )
      );

    for(int i = 1; i < widget.checkingDetails.length; ++i) {
      if(i != widget.checkingDetails.length - 1)
        _bodyWidgetList.add(_inputRow(i, false));
      else _bodyWidgetList.add(_inputRow(i, true));
    }

    _bodyWidgetList
      ..add(SizedBox(height: MediaQuery.of(context).size.height * 0.05))
      ..add(
          Row(
            children: <Widget>[
              SizedBox(width: MediaQuery.of(context).size.width * 0.4),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: RaisedButton(
                  onPressed: (){
                    _saveData();
                    Navigator.pop(context);
                  },
                  child: Text("完成"),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: RaisedButton(
                  onPressed: (){
                    for(int i = 0; i < _controller.length; i++)
                      _controller[i].clear();
                  },
                  child: Text("清除所有"),
                ),
              ),
            ],
          )
      );

    return _bodyWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    _nodeInstantiated = 0;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text(widget.checkingDetails[0]),
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
          children: _constructBodyList(),
        ),
      ),
    );
  }
  void _saveData(){

  }
}