import 'package:flutter/material.dart';
import 'dart:convert';
import '../../utils/userInfo.dart';
import '../../utils//httpUtil.dart';
import '../../widgets/dialog.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController picUrlController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  Map<String, dynamic> userInfo;
  int authorId;

  void getUserInfo() async {
    userInfo = jsonDecode(await UserInfo.getUserInfo());
    setState(() {
      authorId = userInfo['id'];
    });
  }

  bool validatorParams() {
    bool res = true;
    String errorMessage;
    if(authorId == null){
      errorMessage = '获取不到用户id，请稍后重试';
      res = false;
    }else if(titleController.text == ''){
      errorMessage = '请输入文章标题';
      res = false;
    }else if(contentController.text == ''){
      errorMessage = '文章内容不能为空哦~';
      res = false;
    }
    if(!res){
      MyDialog.show(
        context,
        content: errorMessage,
        okName: '了解',
        isHideCancel: true,
      );
    }
    return res;
  }

  void addArticle() async {
    if(!validatorParams()){
      return;
    }
    var json = await HttpUtil(context).request(
      '/posts',
      method: HttpUtil.POST,
      data: {
        'title': titleController.text,
        'subTitle': subTitleController.text,
        'coverPicUrl': picUrlController.text,
        'content': contentController.text,
        'authorId': authorId,
      }
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
      MyDialog.show(
        context,
        content: '文章上传成功！',
        isHideCancel: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('记录你的美好时光'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {
              addArticle();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '请输入文章标题',
                counterText: '',
              ),
              maxLength: 30,
            ),
            TextField(
              controller: subTitleController,
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '请输入文章副标题',
                counterText: '',
              ),
              maxLength: 30,
            ),
            TextField(
              controller: picUrlController,
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '请输入封面链接，例如：http://xxx.jpg',
                counterText: '',
              ),
              maxLength: 30,
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                autofocus: false,
                maxLines: 99,
                decoration: InputDecoration(
                  hintText: '请输入文章内容',
                  counterText: '',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}