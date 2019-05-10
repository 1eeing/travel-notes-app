import 'package:flutter/material.dart';
import './widgets/home.dart';
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
      home: new Home(),
    );
  }
}