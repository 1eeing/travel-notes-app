import 'package:flutter/material.dart';
import './list.dart';
// import './my-drawer.dart';

class ListContainer extends StatefulWidget {
  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
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