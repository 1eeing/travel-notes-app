import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget {
  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final _data = {
    'title': '有一条裙子叫“所有人都夸它美”',
    'subTitle': '夏天又来了~',
    'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
    'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
    'likeNum': 205,
  };

  @override
  Widget build(BuildContext context) {
    final _content = _data['article'];

    return new Scaffold(
      body: new Container(
        child: new CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('文章详情'),
              // actions: <Widget>[
              //   IconButton(
              //     icon: const Icon(Icons.),
              //     tooltip: 'Add new entry',
              //     onPressed: () { /* ... */ },
              //   ),
              // ],
            ),
            SliverPadding(
              padding: new EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return new Text(_content);
                  },
                  childCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}