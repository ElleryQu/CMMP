import 'package:flutter/material.dart';
import '../common_lib/common_method.dart';
import '../database/cmmp_db.dart';

class AddJournal extends StatefulWidget{

  State createState() => new AddJournalState();
}

class AddJournalState extends State<AddJournal>{
  DateTime date = DateTime.now();
  bool _onPopRefresh = true;
  final TextEditingController tc = new TextEditingController();  // 文字处理控制器
  
  bool _isComposing = false;

  void _handleSubmitted(String text) async{
    CmmpDB db = new CmmpDB(); // 数据库
    var a = await db.getRecordCount(0);
    print("db create in addjournal, count: ${a.toString()}");
    JournalRecord jr = new JournalRecord(
      content: text,
      recordDate: date
    );
    await db.insertData(jr, 0);
    _isComposing = false;
    print("db shall close in addjournal");
    Navigator.of(context).pop(_onPopRefresh);
  }

  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Text(
                      date.day.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 50)
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  ),
                  Column(children: <Widget>[
                    Flexible(child: Text(
                      "星期"+["一","二","三","四","五","六","七"][date.weekday],
                      style: TextStyle(fontSize: 18)
                    )),
                    Text(
                      date.year.toString()+"年"+date.month.toString()+"月",
                      style: TextStyle(fontSize: 18)
                    ),
                  ],
                    crossAxisAlignment: CrossAxisAlignment.start,

                  )
                ],
              )
            )
          ),
          Expanded( // 输入框
            flex: 1,
            child: IconTheme(
              data: IconThemeData(color: Colors.black),
              child: Column(children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: TextField(
                      controller: tc,
                      onChanged: (String text){
                        setState((){
                        _isComposing = text.length > 0;
                        });
                      },
                      maxLines: 100,  // test: 缺少溢出处理
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration.collapsed(hintText: '日记会呈现在首页')
                    )
                  )
                ),
                Row(
                  children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                      icon: Icon(Icons.photo_camera),
                      onPressed: (){}
                    ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(270, 0, 0, 0)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing ?() => _handleSubmitted(tc.text) : null
                    ),
                  )
                ],)
              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            )
          )
        ],
      )
    );
  }
}