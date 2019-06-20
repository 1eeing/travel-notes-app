import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import '../../utils/userInfo.dart';
import '../../utils//httpUtil.dart';
import '../../widgets/dialog.dart';
import '../../widgets/pick_img_sheet.dart';

class AddArticle extends StatefulWidget {
  AddArticle({
      Key key,
      this.title,
      this.subTitle,
      this.picUrl,
      this.content,
      this.authorId,
      this.articleId,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String picUrl;
  final String content;
  final int authorId;
  final int articleId;

  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  @override
  void initState() {
    super.initState();
    getUserId();
    pickImgSheet = PickImgSheet(context: context);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int userId;
  PickImgSheet pickImgSheet;
  File coverPicFile;

  void getUserId() async {
    int id = await UserInfo.getUserItem('id');
    setState(() {
      userId = id;
      fillContentIfIsEdit();
    });
  }

  void fillContentIfIsEdit() {
    if(widget.authorId != userId){
      return;
    }
    if(widget.title != null){
      titleController.text = widget.title;
    }
    if(widget.subTitle != null){
      subTitleController.text = widget.subTitle;
    }
    if(widget.content != null){
      contentController.text = widget.content;
    }
  }

  bool validatorParams() {
    bool res = true;
    String errorMessage;
    if(userId == null){
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
    Map<String, dynamic> params = {
      'title': titleController.text,
      'subTitle': subTitleController.text,
      'content': contentController.text,
      'authorId': userId,
    };
    if(coverPicFile != null){
      List splitFilePath = coverPicFile.path.split('.');
      String extname = splitFilePath.last;
      params['coverPicUrl'] = UploadFileInfo(coverPicFile, DateTime.now().millisecondsSinceEpoch.toString() + '.' + extname);
    }
    
    var json = await HttpUtil(context).request(
      '/posts',
      method: HttpUtil.POST,
      data: FormData.from(params),
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

  void editArticle() async {
    if(widget.authorId != userId){
      MyDialog.show(
        context,
        content: '当前文章不是你的哟，请退出后重试~',
        isHideCancel: true,
      );
      return;
    }

    Map<String, dynamic> params = {
      'id': widget.articleId,
      'title': titleController.text,
      'subTitle': subTitleController.text,
      'content': contentController.text,
      'authorId': userId,
    };
    if(coverPicFile != null){
      List splitFilePath = coverPicFile.path.split('.');
      String extname = splitFilePath.last;
      params['coverPicUrl'] = UploadFileInfo(coverPicFile, DateTime.now().millisecondsSinceEpoch.toString() + '.' + extname);
    }

    var json = await HttpUtil(context).request(
      '/posts/:id',
      method: HttpUtil.PUT,
      data: FormData.from(params),
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
      MyDialog.show(
        context,
        content: '文章编辑成功！',
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
            icon: Icon(Icons.save),
            onPressed: () {
              widget.articleId == null ? addArticle() : editArticle();
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  coverPicFile == null ? Image.network(
                    widget.picUrl ?? 'http://ptc0b5jyp.bkt.clouddn.com/timg.jpeg',
                    width: 100.0,
                  ) : Image.file(
                    coverPicFile,
                    width: 100.0,
                  ),
                  IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      pickImgSheet.show((File imgFile) {
                        coverPicFile = imgFile;
                      });
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black54))
              ),
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