/// 主界面文件。
/// home  
///   --- _child
///   --- FluidNavBar
/// 
/// _child == HomePage, route to AddRecordScreen;
/// _child == ChatPage, route to ChatScreen.

import 'package:flutter/material.dart';

// import '../content/home.dart';
// import '../content/account.dart';
// import '../content/grid.dart';
import '../chat_screen/communication/communication.dart';
import './homepage/homepage.dart';
import './fluid_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State {
  Widget _child;

  @override
  void initState() {
    _child = HomePage();
    // _child = AccountContent();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomePage();
          // _child = AccountContent();
          break;
        case 1:
          _child = ChatScreen();
          // _child = AccountContent();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,);
    });
  }
}
