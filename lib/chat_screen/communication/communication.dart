import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';    // for ios
import './chat_message.dart';
// import 'package:image_picker/image_picker.dart'; // visit picture
import 'dart:math';
import 'dart:io';

// https://blog.csdn.net/hekaiyou/article/details/72870759

// class ChatScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context){
//     return Container(
//       child: ChatScreen()
//     );
//   }
// }

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();  // 文字处理控制器
  final List<ChatMessage> _messages = <ChatMessage>[];                        // 消息
  bool _isComposing=false;

  void _handleSubmitted(String text) {
    _textController.clear();
    setState((){
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 300),
        vsync: this
      )
    );
    setState((){
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.black),
      child:new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget> [
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.photo_camera),
                onPressed: (){}
              ),
            ),
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text){
                  setState((){
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(hintText: '发送消息'),
              )
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS ?
                new CupertinoButton(
                  child: new Text('发送'),
                  onPressed: _isComposing ?
                    () => _handleSubmitted(_textController.text) : null
                ) :
                new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing ?
                    () => _handleSubmitted(_textController.text) : null
              ),
            )
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              // reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )
          ),
          new Divider(height: 1.0),
          new Container(
            padding: new EdgeInsets.fromLTRB(0,0,0,60),
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ]
      ),
      decoration: Theme.of(context).platform == TargetPlatform.iOS ?
        new BoxDecoration(
          border: new Border(
            top: new BorderSide(color: Colors.grey[200]))
        ) :  null
    );
  }

  @override
  void dispose() {
    for(ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}

// https://blog.csdn.net/hekaiyou/article/details/72884897?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase


final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);