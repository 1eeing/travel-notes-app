import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/httpUtil.dart';
import '../../utils/userInfo.dart';
import '../../widgets/divided_container.dart';
import '../../widgets/dialog.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Map<String, dynamic> userInfo;
  String userName = '小明';
  String picUrl = 'https://img.alicdn.com/imgextra/i4/69942425/O1CN01N8clmB1Tmgz5LvAS6_!!69942425.jpg';
  int userId;

  void getUserInfo() async {
    userInfo = await UserInfo.getUserInfo();
    setState(() {
      userName = userInfo['name'];
      picUrl = userInfo['picUrl'] ?? 'https://img.alicdn.com/imgextra/i4/69942425/O1CN01N8clmB1Tmgz5LvAS6_!!69942425.jpg';
      userId = userInfo['id'];
    });
  }

  void requestLogout(int id) async {
      if(id == null){
        return;
      }
      var json = await HttpUtil(context).request(
        '/login/logout',
        method: HttpUtil.POST,
        data: {
          'id': id
        }
      );
      if(json == null){
        return;
      }
      if(json['result'] != 100){
        MyDialog.show(
          context,
          content: json['message'],
          okName: '重试',
          isHideCancel: true,
        );
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            DividedContainer(
              child: CircleAvatar(
                backgroundImage: NetworkImage(picUrl),
              ),
              height: 100.0,
            ),
            DividedContainer(
              child: Text(
                userName,
                style: TextStyle(
                  fontSize: 18.0
                ),
              ),
              height: 80.0,
            ),
            CupertinoButton(
              child: Text('退出登录'),
              onPressed: () async {
                requestLogout(userId);
              },
            ),
          ],
        ),
      ),
    );
  }
}