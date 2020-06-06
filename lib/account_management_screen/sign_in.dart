/*
  注册界面。
  参考： https://blog.csdn.net/hekaiyou/article/details/73819668
*/

import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() => new SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final TextEditingController _utc = new TextEditingController();
  final TextEditingController _ptc = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("加入",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text("CMMP",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30),),
            Column(
              children: <Widget>[
                TextField(
                  controller: _utc,
                  decoration: InputDecoration(
                    hintText: '用户名',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5)
                    )
                  ),
                ),
                TextField(
                  controller: _utc,
                  decoration: InputDecoration(
                    hintText: '密 码',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 5)
                    )
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        )
      )
    );
  }
}
