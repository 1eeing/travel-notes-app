import 'package:flutter/material.dart';
import './pages/list/index.dart';
import './pages/articleDetail/index.dart';
import './pages/userInfo/index.dart';
import './pages/addArticle/index.dart';
import './pages/home/index.dart';
import './pages/home/login.dart';
import './pages/home/logon.dart';
// import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent
  // );
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '旅行游记',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: { // 静态路由，不支持传参
        '/': (BuildContext context) => Home(),
        '/login': (BuildContext context) => Login(),
        '/logon': (BuildContext context) => Logon(),
        '/list': (BuildContext context) => ListContainer(),
        '/userInfo': (BuildContext context) => UserInfoPage(),
        '/addArticle': (BuildContext context) => AddArticle(),
      },
    );
  }
}