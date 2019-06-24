import 'package:flutter/material.dart';
import './article_list.dart';
// import './my_drawer.dart';

class ListContainer extends StatefulWidget {
  @override
  _ListContainerState createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   title: Text('浪漫旅行',),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: ArticleList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addArticle');
        },
        child: Icon(Icons.mode_edit),
      ),
      // drawer: MyDrawer(),
    );
  }
}