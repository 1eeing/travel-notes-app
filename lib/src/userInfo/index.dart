import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _userInfo = {
    'picUrl': 'https://img.alicdn.com/imgextra/i4/69942425/O1CN01N8clmB1Tmgz5LvAS6_!!69942425.jpg',
    'userName': 'Leeing',
    'userId': 1,
  };

  @override
  Widget build(BuildContext context) {
    final _picUrl = _userInfo['picUrl'];
    final _userName = _userInfo['userName'];

    return Scaffold(
      body: new Container(
        child: new CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: new Text('Leeing'),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Container(
                    child: new Row(
                      children: <Widget>[
                        Text(_userName,),
                        CircleAvatar(
                          backgroundImage: NetworkImage(_picUrl),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}