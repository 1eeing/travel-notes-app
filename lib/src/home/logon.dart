import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Logon extends StatefulWidget {
  @override
  _LogonState createState() => _LogonState();
}

class _LogonState extends State<Logon> {
  final uerNameController = TextEditingController();

  final passwordController = TextEditingController();

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
                    controller: uerNameController,
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '请输入注册的手机号码',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    autofocus: false,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '请输入登录密码',
                    ),
                    obscureText: true,
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
                      '注册',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 10,
                      ),
                    ),
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    onPressed: () {},
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