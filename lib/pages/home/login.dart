import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import '../../utils/userInfo.dart';
import '../../utils/httpUtil.dart';
import '../../widgets/dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  bool isButtonDisabled = true;

  void validator() {
    RegExp userNameReg = new RegExp(r'(\d{11})');
    RegExp passwordReg = new RegExp(r'(\d{6,12})');

    setState(() {
      isButtonDisabled = userNameReg.hasMatch(userNameController.text) && passwordReg.hasMatch(passwordController.text) ? false : true;
    });
  }

  void requestLogin (params) async {
    var json = await HttpUtil(context).request(
      '/login/login',
      method: HttpUtil.POST,
      data: params,
    );

    if(json == null){
      return;
    }

    if(json['result'] != 100) {
      MyDialog.show(
        context,
        content: json['message'],
        okName: '重试',
        isHideCancel: true,
      );
    }else{
      UserInfo.updateUserInfo(jsonEncode(json['data']));
      Navigator.of(context).pushNamedAndRemoveUntil('/list', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: userNameController,
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '请输入手机号码',
                      counterText: '',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    onChanged: (String value) {
                      validator();
                    },
                  ),
                  TextField(
                    controller: passwordController,
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '请输入密码',
                      counterText: '',
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                    onChanged: (String value) {
                      validator();
                    },
                  ),
                ],
              ),
              flex: 2,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      '登录',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 10,
                      ),
                    ),
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    onPressed: !isButtonDisabled ? () {
                      requestLogin({
                        'name': userNameController.text,
                        'password': passwordController.text,
                      });
                    } : null,
                  ),
                ],
              ),
              flex: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}