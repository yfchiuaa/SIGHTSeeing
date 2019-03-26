import 'package:flutter/material.dart';
import 'string.dart';

class UserSearch extends StatefulWidget{
  final String test;

  UserSearch({Key key, @required this.test}) : super(key:key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch>{

  @override
  Widget build(BuildContext context) {
      return Scaffold(
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

            /// confirm button
            Center(
              child: RaisedButton(
                onPressed: (){
                  // TODO: edit the button option
                  Navigator.pop(context);
                },
                child: Text(Strings.confirm),
              ),
            ),
          ],
        ),
      );
  }


}