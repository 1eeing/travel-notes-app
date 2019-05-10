import 'package:flutter/material.dart';
import './content.dart';
// import './my-drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: new Text('浪漫旅行',),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: new Content(),
      // drawer: new MyDrawer(),
    );
  }
}