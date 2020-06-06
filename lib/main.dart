import 'package:flutter/material.dart';

import './home_screen/home.dart';
import './addrecord_screen/addrecord.dart';
import './chat_screen/communication/communication.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => HomeScreen(),
        '/addrecord' : (context) => AddRecordScreen(),
      },
    );
  }
}
