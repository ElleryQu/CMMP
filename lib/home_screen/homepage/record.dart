import 'package:flutter/material.dart';

class RecordRow extends StatelessWidget{
  RecordRow({this.date, this.text});
  final DateTime date;
  final String text;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4), //cornerRadius
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // for date
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  date.day.toString(),
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 40)
                ),
                // padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              Column(children: <Widget>[
                Flexible(child: Text(
                  "星期"+["一","二","三","四","五","六","七"][date.weekday],
                  style: TextStyle(fontSize: 15)
                )),
                Text(
                  date.year.toString()+"年"+date.month.toString()+"月",
                  style: TextStyle(fontSize: 15)
                ),
              ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              )
            ],
          ),
          // for record
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Text(text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
              )
            )
          )
        ]
      )
    );
  }
}

