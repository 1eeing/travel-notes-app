import 'package:flutter/material.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: new Text('记录你的美好时光'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mode_edit),
            tooltip: 'Add Article',
            onPressed: () {
              print(controller.text);
            },
          ),
        ],
      ),
      body: new Container(
        child: new TextField(
          controller: controller,
          autofocus: true,
          enableInteractiveSelection: true,
          maxLines: 99,
        ),
      ),
    );
  }
}