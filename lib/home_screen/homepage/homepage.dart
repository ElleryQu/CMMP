/// ???????????UI?

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import './record.dart';
import '../../database/cmmp_db.dart';


// import 'package:shared/ui/placeholder/placeholder_card_tall.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController sc = new ScrollController();
  int _index = 0;
  int _recordsCountOnceLoad = 1;
  int _recordsCountFirstLoad = 5;

  final List<RecordRow> _records = 
    <RecordRow>[
      new RecordRow(  // test text
        date: DateTime(1970,01,01),
        text: 'CMMP will stop in 2038-01-19.'
      )
    ];

  @override
  Void initState() {
    super.initState();
    _getCountRecord(_recordsCountFirstLoad); // test: 把这个脑瘫写法想法换掉
    sc.addListener(() {
      if (sc.position.pixels == sc.position.maxScrollExtent) {
        print("maxScrollExtent active; ");
        _getRecord();
      }
    });
  }
  
  _getCountRecord(int count)async{
    var i = 0;
    for (i;i<count;i++) await _getRecord();
  }

  _getRecord() async {
    CmmpDB db = new CmmpDB();
    var a = await db.getRecordCount(0);
    print("db create in homepage, count: ${a.toString()}");
    if(a-_index-_recordsCountOnceLoad>=0){
      List<dynamic> newRecord = await db.selectData(
        limit: _recordsCountOnceLoad,
        offset: a-_index-_recordsCountOnceLoad, 
        type: 0
      );
      print("a:$a ,_index: $_index");
      _index += _recordsCountOnceLoad;
      newRecord.forEach((item) => _records.add(
        RecordRow(
          date: item.recordDate,
          text:item.content)));
      setState(() {
        print("homepage setState(), the length of _records: ${_records.length}");
        print("db shall close in homepage");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // dynamic obj = ModalRoute.of(context).settings.arguments;
    // if (obj != null ) {
    //     _records.clear();
    //     _records.add(
    //       new RecordRow(  // test text
    //         date: DateTime(1970,01,01),
    //         text: 'CMMP will stop in 2038-01-19.'
    //       )
    //     );
    //     _index = 0;
    //   }
    return Column(
      children: <Widget> [
        Container(
          padding: EdgeInsets.fromLTRB(30,60,0,0),
          child: Row(
            children: <Widget>[
              Text("Diary&Habit...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36.0,
                )
              ),
              // function: add a new record
              IconButton(
                padding: EdgeInsets.fromLTRB(65, 8, 8, 8),
                icon: Icon(Icons.add),
                iconSize: 42, 
                color: Colors.black,
                alignment: Alignment.centerRight,
                onPressed: (){
                  Navigator.pushNamed(context, '/addrecord')
                    .then((_doRefreshFlag){
                      if(_doRefreshFlag){
                        _records.clear();
                        _records.add(
                          new RecordRow(  // test text
                            date: DateTime(1970,01,01),
                            text: 'CMMP will stop in 2038-01-19.'
                          )
                        );
                        _index = 0;
                        _getCountRecord(_recordsCountFirstLoad);
                      }
                    });
                }
              )
            ]
          )
        ),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(20,20,20,0),
            itemCount: _records.length,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: _records[index],
              );
            },
            controller: sc,
          ),
          flex: 90
        )
      ]);
  }
}
