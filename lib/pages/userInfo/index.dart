import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import '../../utils/httpUtil.dart';
import '../../utils/userInfo.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _userInfo = {
    'picUrl': 'https://img.alicdn.com/imgextra/i4/69942425/O1CN01N8clmB1Tmgz5LvAS6_!!69942425.jpg',
    'userName': 'Leeing',
    'userId': 1,
  };

  @override
  Widget build(BuildContext context) {
    final _picUrl = _userInfo['picUrl'];
    final _userName = _userInfo['userName'];

    void requestLogout(loginId) async {
      var json = await HttpUtil(context).request(
        '/login/logout',
        method: HttpUtil.POST,
        data: {
          'id': loginId
        }
      );
      if(json == null){
        return;
      }
      if(json['result'] != 100){
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text(
              json['message'],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('重试', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    }

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
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(_userName,),
                            CircleAvatar(
                              backgroundImage: NetworkImage(_picUrl),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            CupertinoButton(
                              child: Text('退出登录'),
                              onPressed: () async {
                                Map<String, dynamic> userInfo = jsonDecode(await UserInfo.getUserInfo());
                                requestLogout(userInfo['id']);
                              },
                            )
                          ],
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