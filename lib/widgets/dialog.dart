import 'package:flutter/material.dart';

class MyDialog {
  static show(
    BuildContext context, 
    {
      String content = '',
      String okName = '确定',
      String cancelName = '取消',
      bool isHideOk = false,
      bool isHideCancel = false,
      Function onOk,
      Function onCancel
    }
  ) {
    onOk ??= (ctx) {
      Navigator.of(ctx).pop();
    };

    onCancel ??= (ctx) {
      Navigator.of(ctx).pop();
    };

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(
            content,
          ),
          actions: <Widget>[
            !isHideOk ? FlatButton(
              child: Text(okName, style: TextStyle(color: Colors.black),),
              onPressed: () {
                onOk(ctx);
              },
            ) : null,
            !isHideCancel ? FlatButton(
              child: Text(cancelName, style: TextStyle(color: Colors.black),),
              onPressed: () {
                onCancel(ctx);
              },
            ) : null,
          ],
        ),
      );
  }
}