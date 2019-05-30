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
  runApp(new MyApp());
  // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent
  // );
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '旅行游记',
      // theme: new ThemeData(
      //   primaryColor: Colors.green,
      // ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => new Home(),
        '/login': (BuildContext context) => new Login(),
        '/logon': (BuildContext context) => new Logon(),
        '/list': (BuildContext context) => new ListContainer(),
        '/articleDetail': (BuildContext context) => new ArticleDetail(),
        '/userInfo': (BuildContext context) => new UserInfoPage(),
        '/addArticle': (BuildContext context) => new AddArticle(),
      },
    );
  }
}