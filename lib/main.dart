import 'package:flutter/material.dart';
import './src/home/index.dart';
import './src/articleDetail/index.dart';
import './src/userInfo/index.dart';
import './src/addArticle/index.dart';
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
        '/articleDetail': (BuildContext context) => new ArticleDetail(),
        '/userInfo': (BuildContext context) => new UserInfo(),
        '/addArticle': (BuildContext context) => new AddArticle(),
      },
    );
  }
}