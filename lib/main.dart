import 'package:cmmp/account_management_screen/sign_in.dart';
import 'package:flutter/material.dart';

import './home_screen/home.dart';
import './addrecord_screen/addrecord.dart';
import './chat_screen/communication/communication.dart';
import './account_management_screen/sign_in.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => SignInScreen(),
        '/addrecord' : (context) => AddRecordScreen(),
      },
    );
  }
}
