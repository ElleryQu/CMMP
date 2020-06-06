// /// 路由与导航文件，main.dart需要调用此文件以在
// ///   创建materialapp时附加命名路由信息。
// /// 参考：https://www.jianshu.com/p/b9d6ec92926f
// /// 此文件已弃用，参考 https://www.cnblogs.com/yuyujuan/p/11006780.html

// import 'package:flutter/material.dart';
// import '../home_screen/home.dart';
// import '../addrecord_screen/addrecord.dart';
// import '../chat_screen/communication/communication.dart';

// class CmmpNavigator{
//   static Map<String, WidgetBuilder> routes;

//   // static Widget initApp() {
//   //   return MaterialApp(
//   //     initialRoute: '/',
//   //     routes: NamedRouter.initRoutes(),
//   //   );
//   // }

//   //初始化路由
//   static initRoutes() {
//     routes = {
//       '/': (context) => HomeScreen(),
//       // '/chat': (context) => ChatScreen(),
//       '/addrecord': (context) => AddRecordScreen(),
//       // '/readrecord': (context) => ReadRecordScreen()
//     };
//     return routes;
//   }

// }