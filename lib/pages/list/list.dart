import 'package:flutter/material.dart';
import '../../utils/httpUtil.dart';
import '../../widgets/listItemTile.dart';
import '../../widgets/dialog.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequestList();
  }

  var _lists;

  void getRequestList() async {
    var res = await HttpUtil(context).request(
      '/posts',
      method: HttpUtil.GET
    );

    if(res == null){
      return;
    }

    if(res['result'] != 100){
      MyDialog.show(
        context,
        content: '请求失败',
        isHideCancel: true,
      );
    }else{
      var data = res['data'];
      setState(() {
        _lists = data['list'];
      });
    }
  }

  // var _lists = [
  //   {
  //     'title': '新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告',
  //     'subTitle': '咔嚓咔嚓咔嚓，有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了',
  //     'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
  //     'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
  //     'likeNum': 100,
  //   },
  //   {
  //     'title': '有一条裙子叫“所有人都夸它美”',
  //     'subTitle': '夏天又来了~',
  //     'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
  //     'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
  //     'likeNum': 205,
  //   },
  //   {
  //     'title': '新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告新晋网红小脆蟹的试吃报告',
  //     'subTitle': '咔嚓咔嚓咔嚓，有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了有了它我的嘴巴再也不寂寞了',
  //     'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
  //     'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
  //     'likeNum': 100,
  //   },
  //   {
  //     'title': '有一条裙子叫“所有人都夸它美”',
  //     'subTitle': '夏天又来了~',
  //     'article': 'This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ... This is a long story ...',
  //     'picUrl': 'https://img.alicdn.com/imgextra/i2/69942425/O1CN01XtRxga1TmgypAahQK_!!69942425.jpg',
  //     'likeNum': 205,
  //   },
  // ];

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
                  if(_lists == null){
                    return Text('loading');
                  }else if(_lists.length == 0){
                    return Text('暂时没有内容哦~快记录您的第一篇游记吧');
                  }else{
                    return _buildLitsItem(_lists[index]);
                  }
                },
                childCount: (_lists == null || _lists.length == 0) ? 1 : _lists.length,
              ),
            ),
          ),
        ],
      ),
      color: Colors.grey[300],
    );
  }
}