import 'package:cmmp/addrecord_screen/add_journal.dart';
import 'package:cmmp/addrecord_screen/add_phy_par.dart';
/// 添加记录页面文件。
/// 此页面由tabbar构成。

import 'package:flutter/material.dart';
import '../database/cmmp_db.dart';

class AddRecordScreen extends StatefulWidget{
  State createState() => new AddRecordScreenState();
}

class AddRecordScreenState extends State<AddRecordScreen>{
  String _test = "no value.";

  Future<String> testMethod() async{
    CmmpDB db = new CmmpDB();
    // test
    var a = await db.getRecordCount(0);
    print("db create in addrecord, count: ${a.toString()}");
    int s = await db.getRecordCount(0);
    print("db shall close in addrecord");
    // db.close();
    return s.toString();
  }

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("录入生活")
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TabBar(
                  onTap: (int index){},
                  unselectedLabelColor: Colors.black87,
                  unselectedLabelStyle: TextStyle(fontSize: 20),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 20.0),
                  isScrollable: true,
                  indicatorColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 6.0,
                  tabs: <Widget>[ 
                    Text('参数'),
                    Text('日记'),
                    Text('习惯'),
                    Text('用药')
                  ],
                ),
              )
            ),
            Expanded(
              flex: 8,
              child: TabBarView(
                children: <Widget>[
                    AddPP(),
                    AddJournal(),
                    Text('习惯'),
                    Text('用药信息')
                  ],
              )
            )
          ]
        )
      )
    );
  }
}