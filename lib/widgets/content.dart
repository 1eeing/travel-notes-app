import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _lists = [
    {
      'title': '新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告',
      'subTitle': '咔嚓咔嚓咔嚓，有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了',
      'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
      'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
      'likeNum': 100,
    },
    {
      'title': '有一条裙子叫“所有人都夸它美”',
      'subTitle': '夏天又来了~',
      'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
      'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
      'likeNum': 205,
    },
    {
      'title': '新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告',
      'subTitle': '咔嚓咔嚓咔嚓，有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了',
      'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
      'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
      'likeNum': 100,
    },
    {
      'title': '有一条裙子叫“所有人都夸它美”',
      'subTitle': '夏天又来了~',
      'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
      'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
      'likeNum': 205,
    },
  ];

  Widget _buildLitsItem(item) {
    final _title = item['title'];
    final _subTitle = item['subTitle'];
    final _picUrl = item['picUrl'];
    final _likeNum = item['likeNum'];

    return new Card(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Text(
              '$_likeNum 人喜欢', 
              style: new TextStyle(
                fontSize: 18.0,
                color: Colors.grey[500]
              ),
              textAlign: TextAlign.right,
            ),
            height: 60,
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
          ),
          new Container(
            child: new Image.network(
              _picUrl,
              fit: BoxFit.cover,
            ),
            height: 200,
            width: double.infinity,
          ),
          new Container(
            child: new Text(
              _title,
              textAlign: TextAlign.left,
              style: new TextStyle(
                fontSize: 22.0,
                color: Colors.black
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          ),
          new Container(
            child: new Text(
              _subTitle,
              textAlign: TextAlign.left,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.grey[500]
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.all(16.0),
          ),
        ],
      ),
      margin: new EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('浪漫旅行'),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.supervised_user_circle),
                tooltip: 'Add new entry',
                onPressed: () { /* ... */ },
              ),
            ],
          ),
          SliverPadding(
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _buildLitsItem(_lists[index]);
                },
                childCount: _lists.length,
              ),
            ),
          ),
        ],
      ),
      color: Colors.grey[300],
    );
  }
}