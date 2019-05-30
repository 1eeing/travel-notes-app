import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../utils/httpUtil.dart';

class Logon extends StatefulWidget {
  @override
  _LogonState createState() => _LogonState();
}

class _LogonState extends State<Logon> {
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

  void requestLogon(params) async {
    var json = await HttpUtil(context).request(
      '/users',
      method: HttpUtil.POST,
      data: params
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
              child: Text('确定', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }else{
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
                      hintText: '11位注册手机号码',
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
                      hintText: '6-12位登录密码',
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
                      '注册',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 10,
                      ),
                    ),
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    onPressed: !isButtonDisabled ? () {
                      requestLogon({
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