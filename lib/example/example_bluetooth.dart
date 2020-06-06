import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '打开蓝牙'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  String _message='检查蓝牙状态中...';

  // 实现蓝牙功能；调用Native方法。
  // 参考:https://blog.csdn.net/qq_35905501/article/details/89080537
  static const MethodChannel methodChannel=
      MethodChannel('cmmp/bluetooth');

  Future<void> _openBlueTooth()async{
    String message;
    message=await methodChannel.invokeMethod('openBuleTooth');
    setState(() {
      _message=message;
    });
  }

  Future<void> _getBlueTooth()async{
    String message;
    message=await methodChannel.invokeMethod('getBuleTooth');
    setState(() {
      _message=message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('蓝牙状态:'),
                    Text(
                        _message,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:Column(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('打开蓝牙'),
                        onPressed: _openBlueTooth,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('检测蓝牙状态'),
                        onPressed: _getBlueTooth,
                      ),
                    ],
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
