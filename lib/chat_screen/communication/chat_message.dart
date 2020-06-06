import 'package:flutter/material.dart';

const String _name = "ElleryQuin";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    // var fgColor = Color(0xfff2f2f2);

    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController, 
        curve: Curves.easeOut
      ),
      axisAlignment: 0.0,
      child: new Container(
        // margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), //cornerRadius
          color: Colors.white,
        ),
        padding: EdgeInsets.all(26),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_name, style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                )
              ]
            )
          ]
        )
      )
    );
  }
}