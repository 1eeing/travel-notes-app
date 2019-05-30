import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  '记录你的浪漫之旅',
                  style: new TextStyle(
                    fontSize: 30.0,
                    fontFamily: '幼圆',
                    color: Colors.black87,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: CupertinoButton(
                      child: Text(
                        '登录',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 10,
                        ),
                      ),
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                    width: 200,
                  ),
                  Container(
                    child: CupertinoButton(
                      child: Text(
                        '注册',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 10,
                        ),
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/logon');
                      },
                    ),
                    width: 200,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              flex: 2,
            ),
            Expanded(
              child: Center(
                child: Text('用户协议'),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}