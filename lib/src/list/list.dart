import 'package:flutter/material.dart';
import '../../widgets/listItemTile.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
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

    return new ListItemTile(
      title: _title,
      subTitle: _subTitle,
      picUrl: _picUrl,
      likeNum: _likeNum,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('浪漫旅行'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.supervised_user_circle),
                tooltip: 'Add new entry',
                onPressed: () {
                  Navigator.pushNamed(context, '/userInfo');
                },
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