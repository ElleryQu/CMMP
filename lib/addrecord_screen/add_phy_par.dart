import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common_lib/common_method.dart';
import '../database/cmmp_db.dart';

class AddPP extends StatefulWidget{
  State createState() => new AddPPState();
}

class AddPPState extends State<AddPP>{
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List tc = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController()
  ];  // 文字处理控制器

  DateTime date = DateTime.now();
  List<PpRecord> _pprecords = [];

  bool _isComposing = false;
  String _bslabel = 'nl';
  List<int> _bsCheckedButtonFlag = [0,0,0,0,0,0,0];
  Map _labelHelper = {
    'bb': '早餐前血糖',
    'ab': '早餐两小时后血糖',
    'bl': '午餐前血糖',
    'al': '午餐两小时后血糖',
    'bd': '晚餐前血糖',
    'ad': '晚餐两小时后血糖',
    'bs': '睡前血糖',
    'nl': '无标记',
  };

  void _forSubmitted() async{
    CmmpDB db =new CmmpDB();
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      var a = await db.getRecordCount(3);
      print("db create in addphypar, count: ${a.toString()}");
      for (var i in _pprecords) db.insertData(i, 3);
      for (var i in tc) i.clear();
      print("db shall close in addphypar");
    }
  }

  _setButtonState(int j){
    return (){
      if(_bsCheckedButtonFlag[j] == 1){ // 如果该按钮已被选中，则取消选中
        _bslabel = 'nl';
        _bsCheckedButtonFlag[j] = 0;
      } else{ // 反之
        _bslabel = _labelHelper.keys.toList()[j];
        for (var i in [0,1,2,3,4,5,6]) {
          _bsCheckedButtonFlag[i] = 0;
        }
        _bsCheckedButtonFlag[j] = 1;
      }
    };
  }

  Widget build(BuildContext context){
        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
                onPressed: _forSubmitted,
                child: Icon(Icons.data_usage),
              ),
            body: Column(children: <Widget>[
              Flexible(   // 体重
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    controller: tc[0],
                    decoration: new InputDecoration(
                      labelText: '体重(kg)',
                      // labelStyle: TextStyle(fontSize: 10)
                    ),
                    onSaved: (val) {
                      if(val != null && !val.isEmpty){
                        _pprecords.add(PpRecord(
                          value: int.parse(val),
                          type: 0,
                          label: 'nl'
                        ));
                      }
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
                    ],
                  ),
                )
              ),
              Flexible(   // 心率
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    controller: tc[1],
                    decoration: new InputDecoration(
                      labelText: '心率(bpm)',
                    ),
                    onSaved: (val) {
                      if(val != null && !val.isEmpty){
                        _pprecords.add(PpRecord(
                          value: int.parse(val),
                          type: 1,
                          label: 'nl'
                        ));
                      }
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
                    ],
                  ),
                )
              ),
              // 收缩压
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    controller: tc[2],
                    decoration: new InputDecoration(
                      labelText: '收缩压(mmHg)',
                    ),
                    onSaved: (val) {
                      if(val != null && !val.isEmpty){
                        _pprecords.add(PpRecord(
                          value: int.parse(val),
                          type: 3,
                          label: 'sp'
                        ));
                      }
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
                    ],
                  ),
                )
              ),
              // 舒张压
              Flexible(
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormField(
                    controller: tc[3],
                    decoration: new InputDecoration(
                      labelText: '舒张压(mmHg)',
                    ),
                    onSaved: (val) {
                      if(val != null && !val.isEmpty){
                        _pprecords.add(PpRecord(
                          value: int.parse(val),
                          type: 3,
                          label: 'dp'
                        ));
                      }
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
                    ],
                  ),
                )
              ),
              Flexible(   // 血糖
                child: Container(
                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[Flexible(
                      child: TextFormField(
                        controller: tc[4],
                        decoration: new InputDecoration(
                          labelText: '血糖(mmol/l)',
                          helperText: _labelHelper[_bslabel]
                        ),
                        onSaved: (val) {
                          if(val != null && !val.isEmpty){
                            _pprecords.add(PpRecord(
                              value: int.parse(val),
                              type: 2,
                              label: _bslabel
                            ));
                          }
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly, //限制只允许输入数字
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      buttonHeight: 10,
                      buttonPadding: EdgeInsets.all(0),
                      children: <Widget>[
                        // button1
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[0]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[0]*5.toDouble())
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.lightBlue, Colors.green]
                            ),// 渐变色
                          ),
                          child: RaisedButton(
                            elevation: 0, 
                            highlightElevation: 0, 
                            color: Colors.transparent,
                            onPressed: (){  
                              setState(_setButtonState(0));
                            }
                          )
                        ), 
                        // button 2
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[1]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[1]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.green, Colors.orange]),// 渐变色
                          ),
                          child: RaisedButton(
                            color: Colors.transparent,
                              elevation: 0, 
                              highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(1));;
                            }
                          )
                        ), 
                        // button3
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[2]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[2]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.orange, Colors.red]),// 渐变色
                          ),
                          child: RaisedButton(
                            color: Colors.transparent,
                            elevation: 0, 
                            highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(2));
                            }
                          )
                        ),
                        // button4
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[3]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[3]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.red, Colors.orange]),// 渐变色
                          ),
                          child: RaisedButton(
                            color: Colors.transparent,
                            elevation: 0, 
                            highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(3));
                            }
                          )
                        ),
                        // button 5
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                           top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[4]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[4]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.orange, Colors.purple]),// 渐变色
                          ),
                          child: RaisedButton(
                            color: Colors.transparent,
                            elevation: 0, 
                            highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(4));
                            }
                          )
                        ), 
                        // button6
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                            top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[5]*5.toDouble()),
                            bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[5]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.deepPurple, Colors.white]),// 渐变色
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            color: Colors.transparent,
                            elevation: 0, 
                            highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(5));
                            }
                          )
                        ),
                        // button7
                        Container(
                          width: 40,
                          height: 30,
                          margin: EdgeInsets.fromLTRB(0,10,1,0),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[6]*5.toDouble()),
                              bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[6]*5.toDouble())
                            ),
                            gradient: LinearGradient(colors: [Colors.white, Colors.lightBlue]),// 渐变色
                          ),
                          child: RaisedButton(
                            color: Colors.transparent,
                            elevation: 0, 
                            highlightElevation: 0, 
                            onPressed: (){  
                              setState(_setButtonState(6));
                            }
                          )
                        ),
                      ],
                    )
                    ]
                ))
              ),
            ],)
          ),
        );
  }
}

// test: 预想中的实现
// class BsButton extends StatefulWidget{

//   @override
//   State<StatefulWidget> createState() => new BsButtonState();

// }

// class BsButtonState() extends State<BsButton>{

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(color: Colors.black, width: _bsCheckedButtonFlag[0]*5.toDouble())
//         ),
//         gradient: LinearGradient(colors: [Colors.deepPurple, Colors.lightBlue]),// 渐变色
//         borderRadius: BorderRadius.circular(25)
//       ),
//       child: RaisedButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25)
//         ),
//         color: Colors.transparent,
//         onPressed: (){  
//           setState(() {
//             // 如果该按钮已经被按下，该flag位置已被标记为1，则重置为0，更新ui
//             if(bsCheckedButtonFlag[0] == 1){
//               bslabel = 'nl';
//               bsCheckedButtonFlag[0] = 0;
//             } else{ // 反之
//               bslabel = 'bb';
//               bsCheckedButtonFlag[0] = 1;
//             }
//             });
//         }
//       )
//     );
//   }
// }