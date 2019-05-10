import 'package:flutter/material.dart';
import './list.dart';
// import './my-drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: new Text('浪漫旅行',),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: new List(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addArticle');
        },
        child: Icon(Icons.mode_edit),
      ),
      // drawer: new MyDrawer(),
    );
  }
}